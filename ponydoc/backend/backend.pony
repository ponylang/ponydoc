trait Backend
  """
  Receives the name of the bundle that documentation is being generated for.

  `bundle_name` is the first call to any backend when we start generating
  documentation.
  """
  fun ref bundle_name(name: String)
