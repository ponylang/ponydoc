struct LibPonycToken
  // TODO STA:
  // there's to do here
  // this isn't all the fields
  var id: USize
  var source: Pointer[LibPonycSource] tag
  var line: USize
  var pos: USize
  var printed: Pointer[U8] tag

  new create() =>
    id = 0
    source = Pointer[LibPonycSource]
    line = 0
    pos = 0
    printed = Pointer[U8]
