import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import enemigo.*
import enemigos.*

object oleada {
  const enemigosPorSpawnear = []
  const enemigosActivos = []
  var property intervaloSpawn = 2000
  var property intervaloMovimiento = 1500
  var spawnerActivo = false
  var movimientoActivo = false
  var property enTransicion = false
  
  method enemigoAleatorio() { //TODO: Rehacer esto para que tome en cuenta el "Nivel" de oleada, desbloqueando enemigos con el paso del tiempo.
    const enemigosDisponibles = [new PeonEnemigo(), new AlfilNegro(), new CaballoNegro(), new TorreNegro()]

    return enemigosDisponibles.anyOne()
  }

  method crearOleada(cantidad) {
    cantidad.times({ i => enemigosPorSpawnear.add(self.enemigoAleatorio()) })
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
    enTransicion = false
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
    enTransicion = false
  }

  method iniciarTransicion() {
    enTransicion = true
  }

  method terminarTransicion() {
    enTransicion = false
  }

  method estaEnTransicion() = enTransicion
}