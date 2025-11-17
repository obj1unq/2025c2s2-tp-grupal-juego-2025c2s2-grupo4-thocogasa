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
                })
            }
    }

    override method desaparece(){
        self.detenerTick()
        super()
    }

}





