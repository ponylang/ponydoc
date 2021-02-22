use @ast_child[NullablePointer[LibPonycAST]](ast: LibPonycAST)
use @ast_print[None](ast: LibPonycAST, width: USize)

primitive ASTOperations
  fun child(ast: LibPonycAST): NullablePointer[LibPonycAST] =>
    @ast_child(ast)

  fun print(ast: LibPonycAST): None =>
    @ast_print(ast, 80)

 struct val LibPonycAST
  var token: Pointer[LibPonycToken]
  var symtab: Pointer[LibPonycSymTab]
  var data:  Pointer[U8] tag
  var parent: Pointer[LibPonycAST]
  var child: Pointer[LibPonycAST]
  var sibling: Pointer[LibPonycAST]
  var annotation_type: Pointer[LibPonycAST]
  var flags: U32
  var frozen: Bool

  new val create() =>
    token = Pointer[LibPonycToken]
    symtab = Pointer[LibPonycSymTab]
    data =  Pointer[U8]
    parent = Pointer[LibPonycAST]
    child = Pointer[LibPonycAST]
    sibling = Pointer[LibPonycAST]
    annotation_type = Pointer[LibPonycAST]
    flags = 0
    frozen = false
