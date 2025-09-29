object reyBlanco {
  method image() {
    return "RBlanco.png"
  }

  var property position = game.at(2,0)

  method mover(direccion){
    position = direccion
  }
}

object reyNegro {
  method image() {
    return "RNegro.png"
  }

  var property position = game.at(2,7)
  }

  class Peon {
  var property image
  var property position
  }

  const negro1 = new Peon(image="PNegro.png", position=game.at(0,6) )
  const negro2 = new Peon(image="PNegro.png", position=game.at(1,6) )
  const negro3 = new Peon(image="PNegro.png", position=game.at(2,6) )
  const negro4 = new Peon(image="PNegro.png", position=game.at(3,6) )
  const negro5 = new Peon(image="PNegro.png", position=game.at(4,6) )

  const blanco1 = new Peon(image="PBlanco.png", position= game.at(0,1))
  const blanco2 = new Peon(image="PBlanco.png", position= game.at(1,1))
  const blanco3 = new Peon(image="PBlanco.png", position= game.at(2,1))
  const blanco4 = new Peon(image="PBlanco.png", position= game.at(3,1))
  const blanco5 = new Peon(image="PBlanco.png", position= game.at(4,1))
