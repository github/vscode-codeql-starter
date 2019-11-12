/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id csharp/example/empty-block
 */

import csharp

from BlockStmt b
where b.getNumberOfStmts() = 0
select b, "This is an empty block."
