use "files"

class Mkdocs
  let _docs_dir: FilePath

  let _home_file: File
  let _index_file: File

  new create(d: FilePath) ? =>
    _docs_dir = d

    _home_file = FileCreator(_docs_dir, "index.md")?
    _index_file = FileCreator(_docs_dir, "mkdocs.yml")?

primitive FileCreator
  fun apply(dir: FilePath, name: String): File ? =>
    let fp = FilePath(dir, name)?
    match CreateFile(fp)
    | let file: File => file
    else
      error
    end

