import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*
import images.*
import proyectiles.*

class PeonBlanco inherits Aliado(valor = 20, image = images.peonBlanco(false)) {
    override method posicionesDiagonales() = [self.position().up(1).left(1), self.position().up(1).right(1)]
}

class CaballoBlanco inherits Aliado(valor = 50, image = images.caballoBlanco()) {
    override method posicionesDiagonales() = [self.position().up(2).left(1), self.position().up(2).right(1), self.position().up(1).left(2), self.position().up(1).right(2), self.position().down(2).left(1), self.position().down(1).left(2), self.position().down(2).right(1), self.position().down(1).right(2)]
}

class TorreBlanca inherits Proyectil (
    valor = 100,
    image = images.torreBlanco()) {
        override method posicionesDiagonales() = 
            [self.position().up(2), self.position().up(1)]

        override method coronar(){
        reyBlanco.añadirRecursos(valor / 4)
        score.addScore(valor / 4)
        self.image(images.peonBlanco(true))
        game.schedule(1400, { game.removeVisual(self) })
    }
}

class AlfilBlanco inherits Proyectil (
    valor = 70,
    image = images.alfilBlanco()
){
    override method posicionesDiagonales() = [
        self.position().up(1).right(1), 
        self.position().up(1).left(1)
        ]

        override method coronar(){
        reyBlanco.añadirRecursos(valor / 4)
        score.addScore(valor / 4)
        self.image(images.peonBlanco(true))
        game.schedule(1400, { game.removeVisual(self) })
        }
    
    override method avanzarYComer() {
        game.onTick(250, "movimiento", {
            const miPos = self.position()
            const random = #{1, -1}.anyOne()
            self.mover(miPos.x()+random, miPos.y()+1)
            self.intentarCapturar()
        })

    }

}