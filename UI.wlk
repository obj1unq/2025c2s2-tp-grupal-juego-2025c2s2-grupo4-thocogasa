import wollok.game.*
import rey.*
import aliados.*
import enemigos.*
import oleadas.*
import trucos.*

class Interfaz {
  const property position
  var property valor

  method text() {
    return " " + self.valorAMostrar()
  }

  method valorAMostrar() {
    return valor
  }

  method textColor() = "000000"

  method reiniciar() //abstracto

  method actualizar(_valorNuevo) {
    valor = _valorNuevo
  }
}


object score inherits Interfaz(position = game.at(6,7), valor = 0) {
  method addScore(v) {
    valor += v
  }

  override method reiniciar() {
    valor = 0
  }
}


object recurso inherits Interfaz(position = game.at(6,6), valor = reyBlanco.recursos()) {

  override method valorAMostrar() {
    return valor
  }

  method añadirRecursos(v) {
    valor += v
    reyBlanco.recursos(valor)
  }

  method restarRecursos(v) {
    if (not trucos.infinityAmmo()) {
      valor -= v
      reyBlanco.recursos(valor)
    }
  }

  override method reiniciar() {
    valor = 100
    reyBlanco.recursos(100)
  }
}


object piezasRestantes inherits Interfaz(position = game.at(6,5), valor = 0) {

  override method valorAMostrar() {
    return oleada.enemigosRestantes()
  }

  override method reiniciar() {
    valor = 0
  }
}


object vida inherits Interfaz(position = game.at(6,0), valor = reyBlanco.vidas()) {

  method perderVida() {
    if (not trucos.modoDios()) {
      valor -= 1
      reyBlanco.vidas(valor)
    }
  }

  override method reiniciar() {
    valor = 3
    reyBlanco.vidas(3)
  }
}


object oleadaActual inherits Interfaz(position = game.at(6,4), valor = 1) {

  override method valorAMostrar() {
    return oleada.nivel()
  }

  override method reiniciar() {
    oleada.nivel(1)
  }
}





// object score {
//   var property score = 0
//   var property position = game.at(6, 7)
  
//   method addScore(valor) {
//     score += valor
//   }
  
//   method text() = " " + self.score()
  
//   method textColor() = "000000"
  
//   method reiniciar() {
//     score = 0
//   }
// }

// object recurso {
//   var property recursos = reyBlanco.recursos()
//   var property position = game.at(6, 6)
  
//   method text() = " " + recursos
  
//   method textColor() = "000000"

//   method añadirRecursos(valor) {
//     recursos += valor
//     reyBlanco.recursos(recursos)
//   }
  
//   method restarRecursos(valor) {
//     if (not trucos.infinityAmmo()) {recursos -= valor
//     reyBlanco.recursos(recursos)}
//   }
//   method reiniciar() {
//     reyBlanco.recursos(100)
//     recursos = 100
//   }
// }

// object piezasRestantes {
//   var property position = game.at(6, 5)
  
//   method text() = " " + oleada.enemigosRestantes()
  
//   method textColor() = "000000"
// }

// object vida {
//   var property position = game.at(6, 0)
//   var property vidas = reyBlanco.vidas() //solo del rey
  
//   method text() = " " + vidas
  
//   method textColor() = "000000"

//   method perderVida() {
//     if (not trucos.modoDios()) {vidas = vidas - 1}
//     reyBlanco.vidas(vidas)
//   }

//   method reiniciar() {
//     reyBlanco.vidas(3)
//     vidas = 3
//   }
// }

// object oleadaActual {
//   var property position = game.at(6, 4)
  
//   method text() = " " + oleada.nivel()
  
//   method textColor() = "000000"

//   method reiniciar() {
//     oleada.nivel(1)
//   }
// }

