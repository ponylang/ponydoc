primitive NoAmbientAuth
  fun apply(env: Env) =>
    env.exitcode(-1)
    env.err.print("No ambient auth")

primitive NoBackendSupplied
  fun apply(env: Env) =>
    env.exitcode(-2)
    env.err.print("Please supply a valid backend")

primitive NoOutputDirectory
  fun apply(env: Env) =>
    env.exitcode(-3)
    env.err.print("Can't create or access the output directory")

primitive UnableToCreateBackend
  fun apply(env: Env) =>
    env.exitcode(-4)
    env.err.print("Unable to create backend")
