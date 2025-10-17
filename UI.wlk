import wollok.game.*
import piezas.*
import aliados.*
import enemigos.*

object score {
    var property score = 0
    var property position = game.at(6, 7)

    method addScore(valor) {
        score = score + valor
    }
	
	method text() {
		return " " + self.score()
	}

    method textColor() {
        return "#FFFFFF"
    }

    method reiniciar() {
        score = 0
    }
}

object recursos {
    var property position = game.at(6, 6)
	
	method text() {
		return " " + reyBlanco.recursos()
	}

    method textColor() {
        return "#FFFFFF"
    }
}

object piezasRestantes {
    var property position = game.at(6, 5)

    method text() {
        return " " + oleada.enemigosRestantes()
    }

    method textColor() {
        return "#FFFFFF"
    }
}

object vidas {
    var property position = game.at(6, 0)

    method text() {
        return " " + reyBlanco.vidas()
    }

    method textColor() {
        return "#FFFFFF"
    }
}

//AGREGANDO SONIDOS

object sonidos {
    var property sonidoDeFondo = game.sound("sonidoDeFondo.wav") //cargo el sonido
    //var property captureSound = game.sound("pieceEat.wav") 
    //var property golpeAlRey = game.sound("KingHurt.wav") no funciona bien si lo asigno

    method iniciarMusicaDeFondo() {
        sonidoDeFondo.shouldLoop(true) // esto indica que el sonido se repita automaticamente
    }
    
    method playGameOver() {
      game.sound("game_over.mp3").play()
    }

    method playSonidoDeFondo() {
      sonidoDeFondo.play() // play() inicia la resproduccion de musica
    }
    method playCaptureSound() {
      game.sound("pieceEat.wav").play()
    }
    method playGolpeAlRey() {
      game.sound("KingHurt.wav").play()
    }

    method detenerTodo() {
        sonidoDeFondo.stop()
        //game.sound("pieceEat.wav").stop()
        //game.sound("KingHurt.wav").stop()
    }

}
