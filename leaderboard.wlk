import wollok.game.*
import UI.*

object leaderboard {
  const entries = []         // { name, score }
  const displayed = []
  var property maxEntries = 5
  var property visible = false

  method addEntry(name, valor) {
    const entry = new LeaderboardEntry(name = name, value = valor)
    entries.add(entry)
  }

  method addCurrentScoreWithName(name) {
    self.addEntry(name, score.score())
  }

  method top(n) = entries.take(n)

  method clear() { entries.clear() }

  method show() {
    displayed.forEach({ d => if (game.hasVisual(d)) game.removeVisual(d) })
    displayed.clear()
    var row = 2
    entries.forEach({ e =>
      const line = new LeaderboardEntry(
        name = e.name(),
        value = e.value(),
        position = game.at(6, row)
      )
      displayed.add(line)
      game.addVisual(line)
      row = row + 1
    })
  }

  method hide() {
    displayed.forEach({ d => if (game.hasVisual(d)) game.removeVisual(d) })
    displayed.clear()
  }

  method toggle() {
    visible = not visible
    if (visible) self.show() else self.hide()
  }

  method saveToDisk() { }
  method loadFromDisk() { }
}

class LeaderboardEntry {
  var property name = "Anon"
  var property value = 0
  var property position = game.at(6, 2)
  method text() = self.name() + " " + self.value()
  method textColor() = "#FFFFFF"
}