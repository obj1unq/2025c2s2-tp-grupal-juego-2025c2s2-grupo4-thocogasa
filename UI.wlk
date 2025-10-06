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