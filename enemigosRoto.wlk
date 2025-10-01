import wollok.game.*
import piezas.*

object enemigo {

const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }

// y aca agregar gameStop puedo hacer metodo como titular/Suplente
  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL
  
  method avanzarACoronar() {
		position = game.at(position.x(), (position.y()-1).max(0))

    if(position.y() == 0){
      game.say(self, "Gane")
      game.stop()
    } // preguntar si agregar 
	} 

  // TODO: Hacer un método "Oleada" que cree una lista de enemigos, 
  //y un spawner que se encarge de ir vaciando la lista y apareciéndolos. => quiere decir que debo lamzar esos enemigos nuevos por la lista
  //es un un objeto el spawaner? podria ser 
  
  
  // TODO: Los peones enemigos tienen que bajar cada x cantidad de ticks
  //es como la gravedad
}









//paso 1 . probarlo con objetos
//como son cinco solo hago 5 enemigos los creo y los spawneo

object enemigoDos {

const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }
  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL
  method avanzarACoronar() {
		position = game.at(position.x(), (position.y()-1).max(0))
	} 
}
object enemigoTres {

const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }
  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL
  method avanzarACoronar() {
		position = game.at(position.x(), (position.y()-1).max(0))
	} 
}
object enemigoCuatro {

const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }
  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL

  method avanzarACoronar() {
		position = game.at(position.x(), (position.y()-1).max(0))
	} 
}
object enemigoCinco {

const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }
  method desaparece() {game.removeVisual(self)}
  method esNegro() {return true} //AGREGUÉ ESTE MÉTODO PARA DETERMINAR SI UNA PIEZA ES RIVAL. GABRIEL
  method avanzarACoronar() {
		position = game.at(position.x(), (position.y()-1).max(0))
	} 
}
//ACA  DEFINO LA OLEADA
object oleada {
  const enemigosFuturos = []
  const enemigosActivos = []

  method agregarEnemigo(unEnemigo) {
    enemigosFuturos.add(unEnemigo)
  }
  method sacarEnemigo() { //acasacamos al enemigo


    if (not enemigosFuturos.isEmpty()){
      const firstEnemy = enemigosFuturos.first() //LAS CONSTANTE DEBERIAN ESTAR ARRIBA
      enemigosFuturos.remove(firstEnemy)
      enemigosActivos.add(firstEnemy)
      game.addVisual(firstEnemy)
    }
    //return if (not enemigosFuturos.isEmpty()) enemigosFuturos.remove(enemigosFuturos.first())
  }
  method moverEnemigos() {
    enemigosActivos.forEach({enemigo => enemigo.avanzarACoronar()}) 
  }

  

}


/*
Interfaz que si funciono con este codigo

	//Agregando Oleada como objetos
    oleada.agregarEnemigo(enemigo)
	oleada.agregarEnemigo(enemigoDos)
	oleada.agregarEnemigo(enemigoTres)
	oleada.agregarEnemigo(enemigoCuatro)
	oleada.agregarEnemigo(enemigoCinco)

	//spawner sin metodo
	game.onTick(1000, "Lanzar Enemigo", {oleada.sacarEnemigo()})

  	game.onTick(1000, "Mover Enemigos", {oleada.moverEnemigos()})
	
*/

// haciendolo con clases 
