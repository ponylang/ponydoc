use "files"
use "../"

class Mkdocs is Backend
  let _docs_dir: FilePath

  let _home_file: File
  let _index_file: File

  new create(d: FilePath) ? =>
    _docs_dir = d

    _home_file = FileCreator(_docs_dir, "index.md")?
    _index_file = FileCreator(_docs_dir, "mkdocs.yml")?

    _home_header()

  fun ref bundle_name(name: String) =>
    _index_frontmatter(name)

  fun ref _home_header() =>
    _home_file.write("Packages\n\n")

  fun ref _index_frontmatter(name: String) =>
    _index_file
      .> write("site_name: " + name + "\n")
      .> write("theme: ponylang\n")
      .> write("markdown_extensions:\n")
      .> write("- markdown.extensions.toc:\n")
      .> write("    permalink: true\n")
      .> write("nav:\n")
      .> write("- " + name + ": index.md\n")

primitive FileCreator
  fun apply(dir: FilePath, name: String): File ? =>
    let fp = FilePath(dir, name)?
    match CreateFile(fp)
    | let file: File => file
    else
      error
    end

