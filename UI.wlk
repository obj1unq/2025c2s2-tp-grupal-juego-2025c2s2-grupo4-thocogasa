import wollok.game.*
import piezas.*
import aliados.*
import enemigos.*

object score {
  var property score = 0
  var property position = game.at(6, 7)
  
  method addScore(valor) {
    score += valor
  }
  
  method text() = " " + self.score()
  
  method textColor() = "#FFFFFF"
  
  method reiniciar() {
    score = 0
  }
}

object recursos {
  var property position = game.at(6, 6)
  
  method text() = " " + reyBlanco.recursos()
  
  method textColor() = "#FFFFFF"
}

object piezasRestantes {
  var property position = game.at(6, 5)
  
  method text() = " " + oleada.enemigosRestantes()
  
  method textColor() = "#FFFFFF"
}

object vidas {
  var property position = game.at(6, 0)
  
  method text() = " " + reyBlanco.vidas()
  
  method textColor() = "#FFFFFF"
}