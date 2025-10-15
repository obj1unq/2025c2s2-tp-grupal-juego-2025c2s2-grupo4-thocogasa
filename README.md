# mini Ajedrez de Wollok

## trabajo grupal POO1 2c2025 c2

### Integrantes:
* Condori, Ivana
* Correa, Thomas
* Kakazu, Gabriel
* Fisela, Santiago
---

## Este juego es una variante de ajedrez en tiempo real (el ajedrez tradicional es un juego de estrategia por turnos)
Puede servir como un tutorial divertido para aprender los movimientos de algunas piezas de ajedrez con una jugabilidad semejante a Plantas vs Zombies.

### En el 1er nivel, ud controla al Rey blanco que se ubica en la fila 1 (la primera fila del tablero visto desde abajo)

+ El *objetivo* de este nivel es "sobrevivir" a la oleada de peones enemigos que van apareciendo aleatoreamente desde la fila 7 (última fila desde abajo) y van descendiendo hasta la fila 1.
+ El Rey Blanco puede moverse únicamente a izquierda y derecha
+ Con la tecla p, si hay recursos suficientes, el Rey compra por $20 y ubica un Peon blanco en la fila 2.
+ Los peones aliados defienden sus posiciones arriba en ambas diagonales, si una pieza contraria llega a dicha casilla de influencia, nuestro peon lo captura automáticamente y ocupa su posicion. 
+ Si dos peones se encuentran "verticalmente", se matan mutuamente y ambos desaparecen del tablero.
+ Eliminar un peón enemigo incorpora $10 a nuestra arcas.
+ Si un peón blanco asciende hasta la última fila del tablero es "coronado". Se retira del tablero y el jugador recibe $100.
+ Si un peon enemigo llega a la primera fila del tablero, corona y nuestro Rey muere: GAME OVER.
+ El Rey blanco puede evitar lo anterior si se interpone en la trayectoria del peón enemigo, pero esto consume 1HP (punto de daño). Si nuestro rey pierde todo su HP, también muere.


[Proyecto To-Do](https://github.com/orgs/obj1unq/projects/3/views/1)


