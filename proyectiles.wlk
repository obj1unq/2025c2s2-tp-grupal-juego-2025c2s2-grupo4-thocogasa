import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*
import images.*

class Proyectil inherits Aliado {
    //var property trayectoria

    method avanzarYComer(){
        game.onTick(125, "movimiento", {
            const miPos = self.position()
            self.mover(miPos.x(), miPos.y()+1)
            self.intentarCapturar()
        })
    }

}





