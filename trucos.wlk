object trucos {

  var property modoDios = false
  var property infinityAmmo = false
  var property sangre = false

  method idfa() { infinityAmmo = true }

  method iddqd() { modoDios = true }

  method blood() { sangre = true }

  method reset() {
    modoDios = false
    infinityAmmo = false
    sangre = false
  }

  method trigger(code) {
    const key = if (code != null) code.toLowerCase() else ""
    if (key == "idfa") { self.idfa() }
    else if (key == "iddqd") { self.iddqd() }
    else if (key == "fatality") { self.blood() }
  }

}
