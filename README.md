README
------

<img src="https://raw.githubusercontent.com/leosongwei/game_of_life/master/screenshot.png" />

Conway's Game of Life in ncurses on Steel Bank Common Lisp (SBCL).

2 display modes are supported: Ncurses and Opengl.

This game follow these rules:

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overcrowding.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

Keys
----

1. r: Reset the game
2. q: Quit

Requirements
------------

1. sbcl
2. Ncurses: libncursesw (path: /lib/x86_64-linux-gnu/libncursesw.so.5.9)
3. OpenGL: freeglut

Sadly, you must have to satisfy all of these requirements for now(because i'm lazy).

Build
-----

`sh build.sh`

Edit `build.lisp` for choosing display mode.
