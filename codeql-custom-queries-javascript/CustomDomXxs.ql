/**
 * @name Client-side clipboard-based cross-site scripting
 * @description Pasting clipboard input directly to the DOM without proper sanitization allows for
 *              a cross-site scripting vulnerability.
 * @kind problem
 * @problem.severity error
 * @security-severity 3.1
 * @precision high
 * @id js/clipboard-xss
 * @tags security
 *       external/cwe/cwe-079
 */

import javascript
import DataFlow
import semmle.javascript.security.dataflow.DomBasedXss

/*
 * Gets references to clipboardData DataTransfer objects
 * https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent/clipboardData
 */

SourceNode clipboardDataTransferSource(TypeTracker t) {
  t.start() and
  exists(DataFlow::PropRead pr | pr.getPropertyName() = "clipboardData" and result = pr)
  or
  exists(TypeTracker t2 | result = clipboardDataTransferSource(t2).track(t2, t))
}

SourceNode clipboardDataTransferSource() {
  result = clipboardDataTransferSource(TypeTracker::end())
}

/*
 * Gets references to the result of a call to getData on a DataTransfer object
 * https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/getData
 */

SourceNode clipboardDataSource(TypeTracker t) {
  t.start() and
  result = clipboardDataTransferSource().getAMethodCall("getData")
  or
  exists(TypeTracker t2 | result = clipboardDataSource(t2).track(t2, t))
}

SourceNode clipboardDataSource() { result = clipboardDataSource(TypeTracker::end()) }

class ClipboardSource extends DataFlow::Node {
  ClipboardSource() { this = clipboardDataSource() }
}

class ClipboardHtmlInjectionConfiguration extends DomBasedXss::HtmlInjectionConfiguration {
  override predicate isSource(DataFlow::Node source) { source instanceof ClipboardSource }
}

class ClipboardJQueryHtmlOrSelectorInjectionConfiguration extends DomBasedXss::JQueryHtmlOrSelectorInjectionConfiguration {
  override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel label) {
    // Reuse any source not derived from location
    source instanceof ClipboardSource and
    (
      label.isTaint()
      or
      label.isData() // Require transformation before reaching sink
    )
  }
}

from DataFlow::Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where
  (
    cfg instanceof ClipboardHtmlInjectionConfiguration or
    cfg instanceof ClipboardJQueryHtmlOrSelectorInjectionConfiguration
  ) and
  cfg.hasFlowPath(source, sink)
select sink.getNode(),
  sink.getNode().(DomBasedXss::Sink).getVulnerabilityKind() + " vulnerability due to $@.",
  source.getNode(), "user-provided clipboard value"