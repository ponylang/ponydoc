use @ast_child[NullablePointer[LibPonycAST]](ast: LibPonycAST)
use @ast_id[USize](ast: LibPonycAST)
use @ast_name[Pointer[U8]](ast: LibPonycAST)
use @ast_print[None](ast: LibPonycAST, width: USize)
use @ast_sibling[NullablePointer[LibPonycAST]](ast: LibPonycAST)
use @ast_source[NullablePointer[LibPonycSource]](ast: LibPonycAST)

primitive ASTOperations
  fun child(ast: LibPonycAST): NullablePointer[LibPonycAST] =>
    @ast_child(ast)

  fun id(ast: LibPonycAST): USize =>
    @ast_id(ast)

  fun name(ast: LibPonycAST): String =>
    recover val String.from_cstring(@ast_name(ast)) end

  fun print(ast: LibPonycAST): None =>
    @ast_print(ast, 80)

  fun sibling(ast: LibPonycAST): NullablePointer[LibPonycAST] =>
    @ast_sibling(ast)

  fun source(ast: LibPonycAST): NullablePointer[LibPonycSource] =>
    @ast_source(ast)

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
