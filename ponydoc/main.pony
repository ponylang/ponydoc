use "cli"
use "libponyc"
use "backend/mkdocs"

actor Main
  let _out: OutStream

  new create(env: Env) =>
    _out = env.out

    // Parse the CLI args and handle help and errors.
    let command =
      match recover val CLI.parse(env.args, env.vars) end
      | let c: Command val => c
      | (let exit_code: U8, let msg: String) =>
        if exit_code == 0 then
          env.out.print(msg)
        else
          env.out.print(CLI.help())
          env.exitcode(exit_code.i32())
        end
        return
      end

    match command.fullname()
    | "ponydoc/version" => env.out.print(Version())
    | "ponydoc/build" => build(command)
    end

  be build(command: Command val) =>
    let b = command.arg("package").string()
    let i = command.option("pony").string()

    match Ponydoc.load(b, i)
    | let ast: AST => Mkdocs.generate_docs(ast)
    else
      _out.print("No AST!")
    end

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponynoblock = true
