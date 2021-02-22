use @package_filename[Pointer[U8]](ast: LibPonycAST)
use @package_qualified_name[Pointer[U8]](ast: LibPonycAST)

primitive PackageOperations
  fun filename(ast: LibPonycAST): String =>
    recover val String.from_cstring(@package_filename(ast)) end

  fun qualified_name(ast: LibPonycAST): String =>
    recover val String.from_cstring(@package_qualified_name(ast)) end
