import wollok.game.*
import piezas.*
import aliados.*
import enemigos.*

object score {
    var property score = 0
    var property position = game.at(5, 7)

    method addScore(valor) {
        score = score + valor
    }
	
	method text() {
		return "Pts: " + self.score()
	}

    method textColor() {
        return "#FFFFFF"
    }
}

object recursos {
    var property position = game.at(5, 6)
	
	method text() {
		return "$$$: " + reyBlanco.recursos()
	}

    method textColor() {
        return "#FFFFFF"
    }
}

object piezasRestantes {
    var property position = game.at(5, 5)

    method text() {
        return "Enem. Rest.: " //+ enemigos.piezasRestantes()
    }

    method textColor() {
        return "#FFFFFF"
    }
}

object vidas {
    var property position = game.at(5, 0)

    method text() {
        return "HP: " + reyBlanco.vidas()
    }

    method textColor() {
        return "#FFFFFF"
    }
}