import wollok.game.*
import piezas.*

object enemigo {
const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)


method image() {
    return "PNegroSilla.png"
  }

  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL
  // TODO: Hacer un método "Oleada" que cree una lista de enemigos, y un spawner que se encarge de ir vaciando la lista y apareciéndolos.
  // TODO: Los peones enemigos tienen que bajar cada x cantidad de ticks
}

