use "cli"
use "files"

use "../"
use "../libponyc"
use "../backend/mkdocs"


primitive Build
  fun apply(env: Env, command: Command val) =>
    let output = command.option("output").string()
    let package = command.arg("package").string()
    let pony = command.option("pony").string()

    let p = FilePath(FileAuth(env.root), output)
    let output_path = if p.mkdir() then
      p
    else
      NoOutputDirectory(env)
      return
    end

    let backend = match command.arg("backend").string()
    | "mkdocs" =>
      try
        Mkdocs(output_path)?
      else
        UnableToCreateBackend(env)
        return
      end
    else
      NoBackendSupplied(env)
      return
    end

    match Ponydoc.load(package, pony)
    | let ast: AST => Guts.generate_docs(backend, ast)
    else
      env.out.print("No AST!")
    end
