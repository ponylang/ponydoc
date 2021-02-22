use "operations"

primitive ASTBuilder
  fun from_nullable(p: NullablePointer[LibPonycAST]): (AST | None) =>
    try AST(p()?) else None end

class val AST
  var _s: LibPonycAST

  new val create(s': LibPonycAST) =>
    _s = s'

  fun val child(): (AST | None) =>
    ASTBuilder.from_nullable(ASTOperations.child(_s))

  fun val package_filename(): String =>
    PackageOperations.filename(_s)

  fun val print(): None =>
    ASTOperations.print(_s)
