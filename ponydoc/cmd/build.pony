use "cli"
use "files"

use "../"
use "../libponyc"
use "../backend/mkdocs"


primitive Build
  fun apply(env: Env, command: Command val) =>
    try
      let ambient = env.root as AmbientAuth
      let output = command.option("output").string()
      let package = command.arg("package").string()
      let pony = command.option("pony").string()


      let output_path = try
        let p = FilePath(ambient, output)?
        if not p.mkdir() then
          NoOutputDirectory(env)
          return
        end
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
        end
      else
        NoBackendSupplied(env)
        return
      end

      match Ponydoc.load(package, pony)
      | let ast: AST => Guts.generate_docs(ast)
      else
        env.out.print("No AST!")
      end
    else
      NoAmbientAuth(env)
      return
    end
