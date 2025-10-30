import wollok.game.*

object sonidos {
    //esto solo reproduce el sonido que haya, empieza y termina
    const property sonidoDeFondo = game.sound("sonidoDeFondo.mp3")
    var property isPlaying = false

  method playFondo(){
    // con shoul se loopee (repita)
    if(not self.isPlaying()){
      sonidoDeFondo.shouldLoop(true) 

        sonidoDeFondo.play()
    }
    self.isPlaying(true)

  }
  method pausaDeFondo() {
    //si o si iba en variable por que sino era uno nuevo
    sonidoDeFondo.pause()
  }
  method stopSonidoDeFondo() {
    if(self.isPlaying()){
      sonidoDeFondo.stop()
    }
    self.isPlaying(false)
  }
  method playGameOver(){
    const sonidoGameOver = game.sound("game_over.mp3")
    sonidoGameOver.play()
  }
}