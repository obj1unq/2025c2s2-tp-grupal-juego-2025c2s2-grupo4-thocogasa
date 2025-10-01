import aliados.*
object reyBlanco {
  var property recursos = 100
  var property vidas = 3

  var property position = game.at(2,0)
  
  method image() {
    return "RBlanco.png"
  }

  method moverDerecha() {
    if(self.puedeMover(self.position().right(1))){
      position = self.position().right(1)
    }
  }

  method moverIzquierda() {
    if(self.puedeMover(self.position().left(1))){
      position = self.position().left(1)
    }
  }

  method añadirRecursos(valor) {
    recursos = recursos + valor
  }

  method perderVida() {
    vidas = vidas - 1
  }

  method puedeMover(unaPosicion) = unaPosicion.x() >= 0 && unaPosicion.x() <= 4 

/*
  method colocarPeon(){
    var nuevoPeon = new PeonBlanco(position = game.at(self.position().x(), 2))
  }

  method sePuedeColocar() =  (self.position().x(), 2) 

  */
}


/*
object reyNegro {
  method image() {
    return "RNegro.png"
  }

  var property position = game.at(2,7)
  }*/

/*
  class Peon {
  var property image
  var property position
  }

  const negro1 = new Peon(image="PNegroSilla.png", position=game.at(0,6) )
  const negro2 = new Peon(image="PNegroSilla.png", position=game.at(1,6) )
  const negro3 = new Peon(image="PNegroSilla.png", position=game.at(2,6) )
  const negro4 = new Peon(image="PNegroSilla.png", position=game.at(3,6) )
  const negro5 = new Peon(image="PNegroSilla.png", position=game.at(4,6) )

  const blanco1 = new Peon(image="PBlanco.png", position= game.at(0,1))
  const blanco2 = new Peon(image="PBlanco.png", position= game.at(1,1))
  const blanco3 = new Peon(image="PBlanco.png", position= game.at(2,1))
  const blanco4 = new Peon(image="PBlanco.png", position= game.at(3,1))
  const blanco5 = new Peon(image="PBlanco.png", position= game.at(4,1))
*/