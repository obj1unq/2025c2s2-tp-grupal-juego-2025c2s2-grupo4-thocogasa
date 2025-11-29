import UI.*
object trucos {

  var property modoDios = false
  var property infinityAmmo = false
  var property sangre = false
  var property lento = false
  var property idclip = false

  method idfa() { infinityAmmo = true }

  method iddqd() { modoDios = true }

  method blood() { sangre = true }

  method slow() { lento = true }

  method motherlode() { game.schedule(1000, { => recurso.añadirRecursos(50000) }) }

  method noclip() { idclip = true }

  method reset() {
    modoDios = false
    infinityAmmo = false
    sangre = false
    lento = false
  }

  method trigger(code) {
    const key = if (code != null) code.toLowerCase() else ""
    if (key == "idfa") { self.idfa() }
    else if (key == "iddqd") { self.iddqd() }
    else if (key == "fatality") { self.blood() }
    else if (key == "vainilla") {self.reset()}
    else if (key == "slowpoke") {self.slow()}
    else if (key == "reset") {self.reset()}
    else if (key == "motherlode") {self.motherlode()}
    else if (key == "idclip") { self.noclip()}
    else if (key == "noclip") { self.noclip()}
  }
}
 