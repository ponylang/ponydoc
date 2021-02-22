use "libponyc"
use "libponyc/operations"
use "backend"
use "free_candy"

class Guts
  var _bundle: Bundle

  new create() =>
    _bundle = Bundle("")

  fun ref generate_docs(backend: Backend, ast: AST): None =>
    // assumption, our AST id is TK_PROGRAM
    match ast.child()
    | let c: AST =>
      _bundle = Bundle(c.package_filename())
      backend.bundle_name(c.package_filename())
    end

    _doc_packages(backend, ast)

  fun ref _doc_packages(backend: Backend, ast: AST) =>
    // assumption, our AST id is TK_PROGRAM
    // The Main package appears first, other packages in alphabetical order
    match ast.child()
    | let main: AST =>
      var p = main
      while true do
        try
          // TODO STA: we can filter out packages we don't care about here
          p = (p.sibling() as AST)
          // TODO STA: move this logic into _doc_packge
          let pqn = p.package_qualified_name()
          _bundle.add_package(Package(pqn))
        else
          break
        end
      end
    else
      // TODO STA: explode here
      return
    end

    for p in _bundle.packages.values() do
      @printf[None]("package ==> %s\n".cstring(), p.name.cstring())
    end

  fun ref _doc_package(ast: AST) =>
    None

