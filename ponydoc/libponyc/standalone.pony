use "lib:ponyc-standalone"
use "operations"

use @ponydoc_load[NullablePointer[LibPonycAST]](from_path: Pointer[U8] tag,
  pony_installation: Pointer[U8] tag)

primitive Ponydoc
  fun load(from: String, install: String): (AST | None) =>
    ASTBuilder.from_nullable(@ponydoc_load(from.cstring(), install.cstring()))
