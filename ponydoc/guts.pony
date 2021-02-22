use "libponyc"
use "libponyc/operations"

primitive Guts
  fun generate_docs(ast: AST): None =>
    match ast.child()
    | let package: AST =>
      @printf[None]("%s\n".cstring(), package.package_filename().cstring())
    end
