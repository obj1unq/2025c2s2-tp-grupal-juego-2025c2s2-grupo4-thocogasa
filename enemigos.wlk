import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*

object oleada {
  const enemigosPorSpawnear = []
  const enemigosActivos = []
  var property intervaloSpawn = 2000
  var property intervaloMovimiento = 1500
  var spawnerActivo = false
  var movimientoActivo = false
  
  method crearOleada(cantidad) {
    cantidad.times({ i => enemigosPorSpawnear.add(new PeonEnemigo()) })
  }
  
  method agregarEnemigo(enemigo) {
    enemigosPorSpawnear.add(enemigo)
  }
  
  method spawnearSiguienteEnemigo() {
    if (not enemigosPorSpawnear.isEmpty()) {
      const nuevoEnemigo = enemigosPorSpawnear.first()
      enemigosPorSpawnear.remove(nuevoEnemigo)
      enemigosActivos.add(nuevoEnemigo)
      game.addVisual(nuevoEnemigo)
    } else {
      self.detenerSpawner()
    }
  }
  
  method moverTodosLosEnemigos() {
    const enemigosParaMover = enemigosActivos.copy()
    enemigosParaMover.forEach({ enemigo => enemigo.avanzar() })
    
    reyBlanco.limpiarAliadosInactivos()
    self.limpiarEnemigosInactivos()
  }
  
  method limpiarEnemigosInactivos() {
    const enemigosAEliminar = enemigosActivos.filter(
      { enemigo => (enemigo.position().y() == 0) or (not game.hasVisual(
          enemigo
        )) }
    )
    enemigosAEliminar.forEach({ enemigo => enemigosActivos.remove(enemigo) })
  }
  
  method iniciarSpawner() {
    if (not spawnerActivo) {
      spawnerActivo = true
      game.onTick(
        intervaloSpawn,
        "spawner_enemigos",
        { self.spawnearSiguienteEnemigo() }
      )
    }
  }
  
  method detenerSpawner() {
    if (spawnerActivo) {
      spawnerActivo = false
      game.removeTickEvent("spawner_enemigos")
    }
  }
  
  method iniciarMovimientoEnemigos() {
    if (not movimientoActivo) {
      movimientoActivo = true
      game.onTick(
        intervaloMovimiento,
        "movimiento_enemigos",
        { self.moverTodosLosEnemigos() }
      )
    }
  }
  
  method detenerMovimientoEnemigos() {
    if (movimientoActivo) {
      movimientoActivo = false
      game.removeTickEvent("movimiento_enemigos")
    }
  }
  
  method iniciarOleada() {
    self.iniciarSpawner()
    self.iniciarMovimientoEnemigos()
  }
  
  method detenerOleada() {
    self.detenerSpawner()
    self.detenerMovimientoEnemigos()
  }
  
  method enemigosRestantes() = enemigosPorSpawnear.size() + enemigosActivos.size()
  
  method oleadaCompleta() = enemigosPorSpawnear.isEmpty() and enemigosActivos.isEmpty()
  
  method reiniciar() {
    self.detenerOleada()
    enemigosPorSpawnear.clear()
    enemigosActivos.clear()
    spawnerActivo = false
    movimientoActivo = false
  }
} // CREAMOS LAS SUBCLASES DE LAS PIEZAS EN SU VERSION DE ENEMIGOS

class Enemigos {
  var property position = game.at((0 .. 4).anyOne(), 7) //0.randomUpTo(4)
  var property valor
  var property muerto = false  
  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }  
  method esNegro() = true

    method avanzar() {
    position = game.at(position.x(), (position.y() - 1).max(0))
    
    if (position.y() == 0) {
      reyBlanco.perderVida()
      if (reyBlanco.vidas() <= 0) {
        game.say(self, "¡Game Over! Presiona R para reiniciar")
        mecanicasJuego.gameOver()
      } else {
        self.desaparece()
      }
    }
  }

  
  method capturarRey() {
    if (position.y() == 0) {
      reyBlanco.perderVida()
      if (reyBlanco.vidas() <= 0) {
        game.say(self, "¡Game Over! Presiona R para reiniciar")
        mecanicasJuego.gameOver()
      } else {
        self.desaparece()
      }
    }

  }

}
class PeonEnemigo inherits Enemigos(valor = 10) {

  method image() {
    if (!muerto) {
      return images.peonMuerto()
    } else {
      return images.peonNegro()
    }
  }
  

}

class AlfilNegro inherits Enemigos(valor = 30) {

  method image() = images.alfilNegro()

  override method avanzar() {
    const diagonalDer = game.at((position.x()+1).min(4), (position.y()-1).max(0))
    const diagonalIzq = game.at((position.x()-1).max(0), (position.y()-1).max(0))
    const ambasDiagonales = #{diagonalDer, diagonalIzq}

    if (position.x() == 0) {position = diagonalDer} 
        else if (position.x() == 4 ) {position = diagonalIzq}
       else {position = ambasDiagonales.anyOne()}
    
    self.capturarRey()
    

  }
}
/*
object movimientosEnemigos {
  method peones(posicionOrigen){
    return game.at(posicionOrigen.x(), (posicionOrigen.y() - 1).max(0))
  }

  method alfiles(posicionOrigen) {
       return game.at(
        posicionOrigen.x().left(1) , 
        (posicionOrigen.y() - 1).max(0))
  } */



