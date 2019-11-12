/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id cpp/example/empty-block
 */

import cpp
 
from Block b
where b.getNumStmt() = 0
select b, "This is an empty block."