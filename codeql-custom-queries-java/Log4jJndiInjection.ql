/**
 * @name Log4j JNDI Injection
 * @description Building Log4j log entries from user-controlled data may allow
 *              attackers to inject malicious code through JNDI lookups.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id java/log4j-jndi-injection
 * @tags security
 */

import java
import semmle.code.java.dataflow.FlowSources
import semmle.code.java.dataflow.ExternalFlow
import DataFlow::PathGraph

private class LoggingSummaryModels extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      [
        "org.apache.logging.log4j;Logger;true;traceEntry;(Message);;Argument[0];ReturnValue;taint",
        "org.apache.logging.log4j;Logger;true;traceEntry;(String,Object[]);;Argument[0..1];ReturnValue;taint",
        "org.apache.logging.log4j;Logger;true;traceEntry;(String,Supplier[]);;Argument[0..1];ReturnValue;taint",
        "org.apache.logging.log4j;Logger;true;traceEntry;(Supplier[]);;Argument[0];ReturnValue;taint",
        "org.apache.logging.log4j;Logger;true;traceExit;(EntryMessage,Object);;Argument[1];ReturnValue;value",
        "org.apache.logging.log4j;Logger;true;traceExit;(Message,Object);;Argument[1];ReturnValue;value",
        "org.apache.logging.log4j;Logger;true;traceExit;(Object);;Argument[0];ReturnValue;value",
        "org.apache.logging.log4j;Logger;true;traceExit;(String,Object);;Argument[1];ReturnValue;value",
      ]
  }
}

private class LoggingSinkModels extends SinkModelCsv {
  override predicate row(string row) {
    row =
      [
        // org.apache.log4j.Category
        "org.apache.log4j;Category;true;assertLog;;;Argument[1];logging",
        "org.apache.log4j;Category;true;debug;;;Argument[0];logging",
        "org.apache.log4j;Category;true;error;;;Argument[0];logging",
        "org.apache.log4j;Category;true;fatal;;;Argument[0];logging",
        "org.apache.log4j;Category;true;forcedLog;;;Argument[2];logging",
        "org.apache.log4j;Category;true;info;;;Argument[0];logging",
        "org.apache.log4j;Category;true;l7dlog;(Priority,String,Object[],Throwable);;Argument[2];logging",
        "org.apache.log4j;Category;true;log;(Priority,Object);;Argument[1];logging",
        "org.apache.log4j;Category;true;log;(Priority,Object,Throwable);;Argument[1];logging",
        "org.apache.log4j;Category;true;log;(String,Priority,Object,Throwable);;Argument[2];logging",
        "org.apache.log4j;Category;true;warn;;;Argument[0];logging",
        // org.apache.logging.log4j.Logger
        "org.apache.logging.log4j;Logger;true;" +
          ["debug", "error", "fatal", "info", "trace", "warn"] +
          [
            ";(CharSequence);;Argument[0];logging",
            ";(CharSequence,Throwable);;Argument[0];logging",
            ";(Marker,CharSequence);;Argument[1];logging",
            ";(Marker,CharSequence,Throwable);;Argument[1];logging",
            ";(Marker,Message);;Argument[1];logging",
            ";(Marker,MessageSupplier);;Argument[1];logging",
            ";(Marker,MessageSupplier);;Argument[1];logging",
            ";(Marker,MessageSupplier,Throwable);;Argument[1];logging",
            ";(Marker,Object);;Argument[1];logging",
            ";(Marker,Object,Throwable);;Argument[1];logging",
            ";(Marker,String);;Argument[1];logging",
            ";(Marker,String,Object[]);;Argument[1..2];logging",
            ";(Marker,String,Object);;Argument[1..2];logging",
            ";(Marker,String,Object,Object);;Argument[1..3];logging",
            ";(Marker,String,Object,Object,Object);;Argument[1..4];logging",
            ";(Marker,String,Object,Object,Object,Object);;Argument[1..5];logging",
            ";(Marker,String,Object,Object,Object,Object,Object);;Argument[1..6];logging",
            ";(Marker,String,Object,Object,Object,Object,Object,Object);;Argument[1..7];logging",
            ";(Marker,String,Object,Object,Object,Object,Object,Object,Object);;Argument[1..8];logging",
            ";(Marker,String,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..9];logging",
            ";(Marker,String,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..10];logging",
            ";(Marker,String,Object,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..11];logging",
            ";(Marker,String,Supplier);;Argument[1..2];logging",
            ";(Marker,String,Throwable);;Argument[1];logging",
            ";(Marker,Supplier);;Argument[1];logging",
            ";(Marker,Supplier,Throwable);;Argument[1];logging",
            ";(MessageSupplier);;Argument[0];logging",
            ";(MessageSupplier,Throwable);;Argument[0];logging", ";(Message);;Argument[0];logging",
            ";(Message,Throwable);;Argument[0];logging", ";(Object);;Argument[0];logging",
            ";(Object,Throwable);;Argument[0];logging", ";(String);;Argument[0];logging",
            ";(String,Object[]);;Argument[0..1];logging",
            ";(String,Object);;Argument[0..1];logging",
            ";(String,Object,Object);;Argument[0..2];logging",
            ";(String,Object,Object,Object);;Argument[0..3];logging",
            ";(String,Object,Object,Object,Object);;Argument[0..4];logging",
            ";(String,Object,Object,Object,Object,Object);;Argument[0..5];logging",
            ";(String,Object,Object,Object,Object,Object,Object);;Argument[0..6];logging",
            ";(String,Object,Object,Object,Object,Object,Object,Object);;Argument[0..7];logging",
            ";(String,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..8];logging",
            ";(String,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..9];logging",
            ";(String,Object,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..10];logging",
            ";(String,Supplier);;Argument[0..1];logging",
            ";(String,Throwable);;Argument[0];logging", ";(Supplier);;Argument[0];logging",
            ";(Supplier,Throwable);;Argument[0];logging"
          ],
        "org.apache.logging.log4j;Logger;true;log" +
          [
            ";(Level,CharSequence);;Argument[1];logging",
            ";(Level,CharSequence,Throwable);;Argument[1];logging",
            ";(Level,Marker,CharSequence);;Argument[2];logging",
            ";(Level,Marker,CharSequence,Throwable);;Argument[2];logging",
            ";(Level,Marker,Message);;Argument[2];logging",
            ";(Level,Marker,MessageSupplier);;Argument[2];logging",
            ";(Level,Marker,MessageSupplier);;Argument[2];logging",
            ";(Level,Marker,MessageSupplier,Throwable);;Argument[2];logging",
            ";(Level,Marker,Object);;Argument[2];logging",
            ";(Level,Marker,Object,Throwable);;Argument[2];logging",
            ";(Level,Marker,String);;Argument[2];logging",
            ";(Level,Marker,String,Object[]);;Argument[2..3];logging",
            ";(Level,Marker,String,Object);;Argument[2..3];logging",
            ";(Level,Marker,String,Object,Object);;Argument[2..4];logging",
            ";(Level,Marker,String,Object,Object,Object);;Argument[2..5];logging",
            ";(Level,Marker,String,Object,Object,Object,Object);;Argument[2..6];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object);;Argument[2..7];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object,Object);;Argument[2..8];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object,Object,Object);;Argument[2..9];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[2..10];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[2..11];logging",
            ";(Level,Marker,String,Object,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[2..12];logging",
            ";(Level,Marker,String,Supplier);;Argument[2..3];logging",
            ";(Level,Marker,String,Throwable);;Argument[2];logging",
            ";(Level,Marker,Supplier);;Argument[2];logging",
            ";(Level,Marker,Supplier,Throwable);;Argument[2];logging",
            ";(Level,Message);;Argument[1];logging",
            ";(Level,MessageSupplier);;Argument[1];logging",
            ";(Level,MessageSupplier,Throwable);;Argument[1];logging",
            ";(Level,Message);;Argument[1];logging",
            ";(Level,Message,Throwable);;Argument[1];logging",
            ";(Level,Object);;Argument[1];logging", ";(Level,Object);;Argument[1];logging",
            ";(Level,String);;Argument[1];logging",
            ";(Level,Object,Throwable);;Argument[1];logging",
            ";(Level,String);;Argument[1];logging",
            ";(Level,String,Object[]);;Argument[1..2];logging",
            ";(Level,String,Object);;Argument[1..2];logging",
            ";(Level,String,Object,Object);;Argument[1..3];logging",
            ";(Level,String,Object,Object,Object);;Argument[1..4];logging",
            ";(Level,String,Object,Object,Object,Object);;Argument[1..5];logging",
            ";(Level,String,Object,Object,Object,Object,Object);;Argument[1..6];logging",
            ";(Level,String,Object,Object,Object,Object,Object,Object);;Argument[1..7];logging",
            ";(Level,String,Object,Object,Object,Object,Object,Object,Object);;Argument[1..8];logging",
            ";(Level,String,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..9];logging",
            ";(Level,String,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..10];logging",
            ";(Level,String,Object,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[1..11];logging",
            ";(Level,String,Supplier);;Argument[1..2];logging",
            ";(Level,String,Throwable);;Argument[1];logging",
            ";(Level,Supplier);;Argument[1];logging",
            ";(Level,Supplier,Throwable);;Argument[1];logging"
          ], "org.apache.logging.log4j;Logger;true;entry;(Object[]);;Argument[0];logging",
        "org.apache.logging.log4j;Logger;true;logMessage;(Level,Marker,String,StackTraceElement,Message,Throwable);;Argument[4];logging",
        "org.apache.logging.log4j;Logger;true;printf;(Level,Marker,String,Object[]);;Argument[2..3];logging",
        "org.apache.logging.log4j;Logger;true;printf;(Level,String,Object[]);;Argument[1..2];logging",
        "org.apache.logging.log4j;Logger;true;traceEntry;(Message);;Argument[0];logging",
        "org.apache.logging.log4j;Logger;true;traceEntry;(String,Object[]);;Argument[0..1];logging",
        "org.apache.logging.log4j;Logger;true;traceEntry;(String,Supplier[]);;Argument[0..1];logging",
        "org.apache.logging.log4j;Logger;true;traceEntry;(Supplier[]);;Argument[0];logging",
        "org.apache.logging.log4j;Logger;true;traceExit;(EntryMessage);;Argument[0];logging",
        "org.apache.logging.log4j;Logger;true;traceExit;(EntryMessage,Object);;Argument[0..1];logging",
        "org.apache.logging.log4j;Logger;true;traceExit;(Message,Object);;Argument[0..1];logging",
        "org.apache.logging.log4j;Logger;true;traceExit;(Object);;Argument[0];logging",
        "org.apache.logging.log4j;Logger;true;traceExit;(String,Object);;Argument[0..1];logging",
        // org.apache.logging.log4j.LogBuilder
        "org.apache.logging.log4j;LogBuilder;true;log;(CharSequence);;Argument[0];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(Message);;Argument[0];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(Object);;Argument[0];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String);;Argument[0];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object[]);;Argument[0..1];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object);;Argument[0..1];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object);;Argument[0..2];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object);;Argument[0..3];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object);;Argument[0..4];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object);;Argument[0..5];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object,Object);;Argument[0..6];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object,Object,Object);;Argument[0..7];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..8];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..9];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Object,Object,Object,Object,Object,Object,Object,Object,Object,Object);;Argument[0..10];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(String,Supplier);;Argument[0..1];logging",
        "org.apache.logging.log4j;LogBuilder;true;log;(Supplier);;Argument[0];logging"
      ]
  }
}


/** A data flow sink for unvalidated user input that is used to log messages. */
abstract class Log4jInjectionSink extends DataFlow::Node { }

/**
 * A node that sanitizes a message before logging to avoid log injection.
 */
abstract class Log4jInjectionSanitizer extends DataFlow::Node { }

/**
 * A unit class for adding additional taint steps.
 *
 * Extend this class to add additional taint steps that should apply to the `Log4jInjectionConfiguration`.
 */
class Log4jInjectionAdditionalTaintStep extends Unit {
  /**
   * Holds if the step from `node1` to `node2` should be considered a taint
   * step for the `LogInjectionConfiguration` configuration.
   */
  abstract predicate step(DataFlow::Node node1, DataFlow::Node node2);
}

private class DefaultLog4jInjectionSink extends Log4jInjectionSink {
  DefaultLog4jInjectionSink() { sinkNode(this, "logging") }
}

private class DefaultLog4jInjectionSanitizer extends Log4jInjectionSanitizer {
  DefaultLog4jInjectionSanitizer() {
    this.getType() instanceof BoxedType or this.getType() instanceof PrimitiveType
  }
}
/**
 * A taint-tracking configuration for tracking untrusted user input used in log entries.
 */
class Log4jInjectionConfiguration extends TaintTracking::Configuration {
  Log4jInjectionConfiguration() { this = "Log4jInjectionConfiguration" }

  override predicate isSource(DataFlow::Node source) { source instanceof RemoteFlowSource }

  override predicate isSink(DataFlow::Node sink) { sink instanceof Log4jInjectionSink }

  override predicate isSanitizer(DataFlow::Node node) { node instanceof Log4jInjectionSanitizer }

  override predicate isAdditionalTaintStep(DataFlow::Node node1, DataFlow::Node node2) {
    any(Log4jInjectionAdditionalTaintStep c).step(node1, node2)
  }
}

from Log4jInjectionConfiguration cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "This $@ flows to a Log4j log entry.", source.getNode(),
  "user-provided value"
