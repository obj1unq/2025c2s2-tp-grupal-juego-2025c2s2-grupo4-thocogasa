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

object recursos { // Quizá los recursos tenga que estar en un objeto Rey, para no tener que entrar a la UI para gastar plata.
    var property recursos = 0
    var property position = game.at(5, 6)

    method añadirRecursos(valor) {
        recursos = recursos + valor
    }
	
	method text() {
		return "$$$: " + self.recursos()
	}

    method textColor() {
        return "#FFFFFF"
    }
}

object vidas {
    var property vidas = 3
    var property position = game.at(5, 0)

    method perderVida() {
        vidas = vidas - 1
    }
    
    method text() {
        return "HP: " + self.vidas()
    }

    method textColor() {
        return "#FFFFFF"
    }
}