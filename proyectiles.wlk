import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*
import images.*
import timers.*

class Proyectil inherits Aliado {
    //var property trayectoria

    method avanzarYComer(){
            if (self.tickName() == null) {
                self.tickName(timers.nextName("mov_proy"))
                game.onTick(125, self.tickName(), {
                    const miPos = self.position()
                    self.mover(miPos.x(), miPos.y()+1)
                    self.intentarCapturar()
                    self.intentarCoronar()
                })
            }
    }

    override method coronar(){
        reyBlanco.añadirRecursos(valor.div(4))
        score.addScore(valor.div(4))
        self.imagePieza(images.peonBlanco(true))
        self.detenerTick()
        game.schedule(1400, { game.removeVisual(self) })
    }

    override method mover(posiciónx, posicióny) {
        const posicionATestear = game.at(posiciónx, posicióny)
        if (self.estaDentroDelTablero(posicionATestear )) 
        {
            position = posicionATestear 
        }
    }

    override method desaparece(){
        self.detenerTick()
        super()
    }
}