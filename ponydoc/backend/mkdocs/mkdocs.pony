use "../../libponyc"

class Mkdocs
  // index file
  // home file

  new create() =>
    None

  fun generate_docs(ast: AST) =>
    match ast.child()
    | let package: AST =>
      @printf[None]("%s\n".cstring(), package.package_filename().cstring())
    end

