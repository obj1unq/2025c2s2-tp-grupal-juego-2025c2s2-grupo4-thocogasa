import wollok.game.*

object board {
  const property width = 5
  var property grid = []
  var property enabled = false
  var property debugEvents = []

  method height() = game.height()

  method inBounds(x, y) = (((x >= 0) and (x < width)) and (y >= 0)) and (y < self.height())

  method ensureInit() {
    if (grid.isEmpty()) {
      const h = self.height()
      grid = []
      var xi = 0
      while (xi < width) {
        const col = []
        var yi = 0
        while (yi < h) {
          col.add(false)
          yi = yi + 1
        }
        grid.add(col)
        xi = xi + 1
      }
    }
  }

  method get(x, y) {
    if (not self.inBounds(x, y)) { return false }
    self.ensureInit()
    return grid.get(x).get(y)
  }

  method registerPiece(pieza) {
    debugEvents.add("register-called")
    if (not self.enabled) { debugEvents.add("register-skipped-disabled"); return true }
    if (pieza == null) { return false }
    const pos = pieza.position()
    if (pos == null) { debugEvents.add("register-pos-null:" + pieza.toString()); return false }
    const px = pos.x()
    const py = pos.y()
    if (not self.inBounds(px, py)) { return false }
    self.ensureInit()
    grid.get(px).set(py, pieza)
    debugEvents.add("register:" + px + "," + py)
    return true
  }

  method removePiece(pieza) {
    debugEvents.add("remove-called")
    if (not self.enabled) { debugEvents.add("remove-skipped-disabled"); return true }
    if (pieza == null) { return false }
    self.ensureInit()
    const h = self.height()
    var xi = 0
    while (xi < width) {
      const col = grid.get(xi)
      var yi = 0
      while (yi < h) {
        if (col.get(yi) == pieza) {
          col.set(yi, false)
          debugEvents.add("remove:" + xi + "," + yi)
        }
        yi = yi + 1
      }
      xi = xi + 1
    }
    return true
  }

  method updatePiecePosition(pieza, oldPos, newPos) {
    debugEvents.add("update-called")
    return false
  }

  method debugDump() = debugEvents.copy()

  method movePiece(fromX, fromY, toX, toY) {
    if (not self.enabled) { debugEvents.add("move-skipped-disabled"); return false }
    if (not self.inBounds(fromX, fromY) or not self.inBounds(toX, toY)) { return false }
    self.ensureInit()
    const pieza = grid.get(fromX).get(fromY)
    if (not pieza) { return false }
    const oldPos = pieza.position()
    pieza.mover(toX, toY)
    const newPos = pieza.position()
    self.updatePiecePosition(pieza, oldPos, newPos)
    return true
  }
}
