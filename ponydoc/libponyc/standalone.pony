use "lib:ponyc-standalone"
use "operations"

use @ponydoc_load[NullablePointer[LibPonycAST]](from_path: Pointer[U8] tag,
  pony_installation: Pointer[U8] tag)

type Path is String

primitive Ponydoc
  fun load(from: Path, install: Path): (AST | None) =>
    ASTBuilder.from_nullable(@ponydoc_load(from.cstring(), install.cstring()))
