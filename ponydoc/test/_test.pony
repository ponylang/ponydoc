use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    None

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponynoblock = true
