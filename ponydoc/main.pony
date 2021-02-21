use "cli"

actor Main
  new create(env: Env) =>
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

    Ponydoc.load(b, i)

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponynoblock = true
