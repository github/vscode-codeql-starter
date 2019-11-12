/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id go/example/empty-block
 */

import go
 
from BlockStmt b
where b.getNumStmt() = 0
select b, "This is an empty block."
