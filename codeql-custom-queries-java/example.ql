/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id java/example/empty-block
 */

import java

from BlockStmt b
where b.getNumStmt() = 0
select b, "This is an empty block."
