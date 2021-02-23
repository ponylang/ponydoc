class Package
  var name: String
  var doc_string: (String | None)

  new create(name': String, doc_string': (String | None)) =>
    name = name'
    doc_string = doc_string'
