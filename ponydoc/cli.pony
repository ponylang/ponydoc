use "cli"

primitive CLI
  fun parse(
    args: Array[String] box,
    envs: (Array[String] box | None))
    : (Command | (U8, String))
  =>
    try
      match CommandParser(_spec()?).parse(args, envs)
      | let c: Command => c
      | let h: CommandHelp => (0, h.help_string())
      | let e: SyntaxError => (1, e.string())
      end
    else
      (-1, "unable to parse command")
    end

  fun help(): String =>
    try Help.general(_spec()?).help_string() else "" end

  fun _spec(): CommandSpec ? =>
    CommandSpec.parent(
      "ponydoc",
      "Pony documentation generator",
      [ OptionSpec.bool(
          "verbose", "Show extra output", 'v', false)
      ],
      [ CommandSpec.leaf(
          "version",
          "Display the doctool version and exit")?
        CommandSpec.leaf(
          "build",
          "Build documentation for a package",
          [ OptionSpec.string(
              "pony",
              "Specify the pony installation to use",
              None,
              "/usr/local/lib/pony/0.38.3-2e8f0404/bin/")
          ],
          [ ArgSpec.string(
              "package",
              "Directory to build",
              ".")
          ])?
      ])?
      .> add_help("help", "Print this message and exit")?
