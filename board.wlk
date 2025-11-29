import wollok.game.*

object board {
  const property width = 5

  method height() = game.height()

  method at(x, y) = game.at(x, y)

  method fromPosition(pos, dx, dy) = game.at(pos.x() + dx, pos.y() + dy)

  method fromSelf(caller, dx, dy) {
    if (caller == null) { return game.at(dx, dy) }
    const p = caller.position()
    if (p == null) { return game.at(dx, dy) }
    return game.at(p.x() + dx, p.y() + dy)
  }

  method inBounds(x, y) = (((x >= 0) and (x < width)) and (y >= 0)) and (y < self.height())
}
