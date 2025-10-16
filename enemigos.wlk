import wollok.game.*
import piezas.*
import aliados.*
import mecanicas.*

class Enemigo {
  var property position = game.at(0.randomUpTo(4), 7)
  var property valor = 10
  var property muerto = false
  var property animando = false

  method image() {
    if (muerto) {
      return "PBlancoMuerto.gif"
    }
    if (animando) {
      // show walking animation while moving between cells
      return "PNegroWalk.gif"
    }
    return "PNegro.png"
  }

  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }

  method esNegro() {
    return true
  }

  method avanzar() {
    // don't start another move while animating or if already dead
    if (not (animando or muerto)) {
      const nuevaPos = game.at(position.x(), (position.y() - 1).max(0))

      // move to the new cell immediately so the animation shows in the correct cell
      position = nuevaPos
      animando = true

      // after the animation duration, stop animating and handle reaching the end
      game.schedule(1200, {
        animando = false

        if (position.y() == 0) {
          reyBlanco.perderVida()
          if (reyBlanco.vidas() <= 0) {
            game.say(self, "¡Game Over! Presiona R para reiniciar")
            mecanicasJuego.gameOver()
          } else {
            self.desaparece()
          }
        }
      })
    }
  }
}

object oleada {
  const enemigosPorSpawnear = []
  const enemigosActivos = []
  var property intervaloSpawn = 2000
  var property intervaloMovimiento = 1500
  var spawnerActivo = false
  var movimientoActivo = false

  method crearOleada(cantidad) {
    cantidad.times({ i => enemigosPorSpawnear.add(new Enemigo()) })
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
    const enemigosAEliminar = enemigosActivos.filter({ enemigo => 
      enemigo.position().y() == 0 or not game.hasVisual(enemigo)
    })
    enemigosAEliminar.forEach({ enemigo => enemigosActivos.remove(enemigo) })
  }

  method iniciarSpawner() {
    if (not spawnerActivo) {
      spawnerActivo = true
      game.onTick(intervaloSpawn, "spawner_enemigos", { => self.spawnearSiguienteEnemigo() })
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
      game.onTick(intervaloMovimiento, "movimiento_enemigos", { => self.moverTodosLosEnemigos() })
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

  method enemigosRestantes() {
    return enemigosPorSpawnear.size() + enemigosActivos.size()
  }

  method oleadaCompleta() {
    return enemigosPorSpawnear.isEmpty() and enemigosActivos.isEmpty()
  }

  method reiniciar() {
    self.detenerOleada()
    enemigosPorSpawnear.clear()
    enemigosActivos.clear()
    spawnerActivo = false
    movimientoActivo = false
  }
}

object enemigo {
  const property positionX = 0.randomUpTo(4)
  var property position = game.at(self.positionX(),7)
  var property valor = 10
  var property muerto = false
  var property animando = false
  
  method image() {
    if (muerto) { return "PBlancoMuerto.gif" }
    if (animando) { return "PNegroWalk.gif" }
    return "PNegro.png"
  }

  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }
  
  method esNegro() {
    return true
  }

  method avanzar() {
    if (not (animando or muerto)) {
      const nuevaPos = game.at(position.x(), (position.y() - 1).max(0))
      position = nuevaPos
      animando = true
      game.schedule(1200, {
        animando = false

        if(position.y() == 0) {
          reyBlanco.perderVida()
          if(reyBlanco.vidas() <= 0) {
            game.say(self, "¡Game Over! Presiona R para reiniciar")
            mecanicasJuego.gameOver()
          } else {
            self.desaparece()
          }
        }
      })
    }
  }
}

