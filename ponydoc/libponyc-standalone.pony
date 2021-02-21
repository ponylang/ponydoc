use "lib:ponyc-standalone"

use @ponydoc_load[None](from_path: Pointer[U8] tag,
  pony_installation: Pointer[U8] tag)

type Path is String

primitive Ponydoc
  fun load(from: Path, pony_installation: Path) =>
    @ponydoc_load(from.cstring(), pony_installation.cstring())
