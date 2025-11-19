import wollok.game.*
import rey.*
import aliados.*
import enemigos.*
import oleadas.*


object score {
  var property score = 0
  var property position = game.at(6, 7)
  
  method addScore(valor) {
    score += valor
  }
  
  method text() = " " + self.score()
  
  method textColor() = "000000"
  
  method reiniciar() {
    score = 0
  }
}

object recurso {
  var property recursos = reyBlanco.recursos()
  var property position = game.at(6, 6)
  
  method text() = " " + recursos
  
  method textColor() = "000000"

  method añadirRecursos(valor) {
    recursos += valor
    reyBlanco.recursos(recursos)
  }
  
  method restarRecursos(valor) {
    recursos -= valor
    reyBlanco.recursos(recursos)
  }
  method reiniciar() {
    reyBlanco.recursos(100)
    recursos = 100
  }
}

object piezasRestantes {
  var property position = game.at(6, 5)
  
  method text() = " " + oleada.enemigosRestantes()
  
  method textColor() = "000000"
}

object vida {
  var property position = game.at(6, 0)
  var property vidas = reyBlanco.vidas() //solo del rey
  
  method text() = " " + vidas
  
  method textColor() = "000000"

  method perderVida() {
    vidas = vidas - 1
    reyBlanco.vidas(vidas)
  }

  method reiniciar() {
    reyBlanco.vidas(3)
    vidas = 3
  }
}

object oleadaActual {
  var property position = game.at(6, 4)
  
  method text() = " " + oleada.nivel()
  
  method textColor() = "000000"
}

