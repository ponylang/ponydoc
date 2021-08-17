use "libponyc"
use "libponyc/operations"
use "backend"
use "free_candy"

use @printf[None](fmt: Pointer[U8] tag, ...)

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
      _bundle.add_package(_doc_package(main))
      var p = main
      while true do
        match p.sibling()
        | let s: AST =>
          // TODO STA: we can filter out packages we don't care about here
          // could also filter out "testing packages" here
          _bundle.add_package(_doc_package(s))
          p = s
        else
          break
        end
      end
    else
      // TODO STA: explode here
      return
    end

    for p in _bundle.packages.values() do
      @printf("package ==> %s\n".cstring(), p.name.cstring())
      match p.doc_string
      | let ds: String =>
        @printf("doc string ==> %s\n".cstring(), ds.cstring())
      end
    end

  fun ref _doc_package(ast: AST): Package =>
    let pqn = ast.package_qualified_name()
    var doc_string: (String | None)= None
    var p = ast.child()
    while true do
      match p
      | let m: AST =>
        if m.id() == StringToken() then
          doc_string = m.name()
        else
          var t = m.child()
          while true do
            match t
            | let q: AST =>
              if q.id() != UseToken() then
                // TODO STA:
                // can filter out testing and internal names here
                _doc_entity(q)
              end
              t = q.sibling()
            else
              break
            end
          end
        end
        p = m.sibling()
      else
        break
      end
    end

    Package(pqn, doc_string)

  fun ref _doc_entity(ast: AST) =>
    // TODO STA: source here? or do we get for something else
    None
