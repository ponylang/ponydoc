class Bundle
  let name: String
  let packages: Array[Package] = packages.create()

  new create(name': String) =>
    name = name'

  fun ref add_package(p: Package) =>
    packages.push(p)

