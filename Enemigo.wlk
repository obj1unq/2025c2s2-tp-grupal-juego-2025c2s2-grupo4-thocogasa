import wollok.game.*
import piezas.*
import randomizer.*


class Enemigo {
  var property position = null //0.randomUpTo(game.width() - 2).roundUp() // es mas adaptable 
  
  method image() {
    return if(position.y() == 0) "RNegro.png" else "PNegroSilla.png"
  }

  method esNegro() {
    return true
  }

  method desaparecer() {
    game.removeVisual(self)
  }
  method avanzarACoronar() {
    const x = position.x()
    const y = (position.y() - 1).max(0)
		position = game.at(x, y) //este es como el de gravedad

    if(position.y() == 0){
      game.say(self, "Gane")
      game.stop()
    } // preguntar si agregar 
	}
}
object oleadas {
  const enemigosFuturos = [] // lista con enemigos solo deben aparecer
  const enemigosActivos = [] // una vez afuera ellos deben avanzar 
  
  var positionsOfEnemys = [0,1,2,3,4].randomize() //lista fija de elementos 1 al 5 // RECORDAR QUE SON LAS Y // le agregue property solo porque necesito el geteer
  var postionsLibresDeFila = [] // lista que va a vambiar constantemente por si se recibe una posicion y sino 

 
  method crearOleada(cantidadDeEnemigos) {
  cantidadDeEnemigos.times({i => enemigosFuturos.add(new Enemigo(position == positionsOfEnemys().first()))})

  //console.println(enemigosFuturos.map({e => e.position()}))

  }
  method sacarEnemigo() { //acasacamos al enemigo
  //sino inicalizar variable al estilo contador y 
  
  
  /*  if (not enemigosFuturos.isEmpty()){ //
      const firstEnemy = enemigosFuturos.first() //LAS CONSTANTE DEBERIAN ESTAR ARRIBA
      enemigosFuturos.remove(firstEnemy)
      enemigosActivos.add(firstEnemy)
      game.addVisual(firstEnemy)
    }
    */
    //return if (not enemigosFuturos.isEmpty()) enemigosFuturos.remove(enemigosFuturos.first())
  }
  method validarPosicion() { // ¿que hago? //
    const positionDeEnemigos = enemigosFuturos.map({e => e.position()})
    const primerEnemigo = positionDeEnemigos.first()
    console.println(positionDeEnemigos) 

    //if(positionDeEnemigos.any({position => primerEnemigo.x() == position.x() })){ //si la primeraPosition == algunaDeLAsPosicionesDeLasDemas
    // positionDeEnemigos = positionDeEnemigos.randomizer() 
  }

  // Verificar que no haya alguien en alguna posicion y si llega a ver que vaya detras de alguien  
  /*
  randomized()

Devuelve el orden de la lista de forma aleatoria

[1, 2, 3, 4].randomized() => Answers [2, 3, 1, 4]
[1, 2, 3, 4].randomized() => Answers [2, 1 ,4 ,3]
  */
  /*
  method moverEnemigos() {
    enemigosActivos.forEach({enemigo => enemigo.avanzarACoronar()}) 
  }
  
  method spawner() {
    game.onTick(1000, "Lanzar Enemigos", { i => 
      if (not enemigosFuturos.isEmpty()) { 
        self.sacarEnemigo()
      } else {
        game.removeTickEvent(" Lanzar Enemigos")
      }
    })
  }*/
}
/*
times(action) 
4.times({ i => console.println(i) }) ==> Answers
si lo tradusco a crear enemigos puedo pasarle parametros si hay  y ya 
=> n.times({parametrosSiHay => enemigosFuturos.add(new Enemigo()) })

nex nombreDeCLase crea la clase
Ejecuta la acción dada n veces (n = self)

Self debe ser un valor entero positivo.

El cierre debe tener un argumento (el índice va de 1 a sí mismo)
*/
//LINK COMANDOS: https://www.wollok.org/documentation/language/#wollok.lib.assert