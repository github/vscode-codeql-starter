/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id cpp/example/empty-block
 */

import cpp
 
from BlockStmt b
where b.getNumStmt() = 0
select b, "This is an empty block."
