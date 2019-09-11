#!/bin/sh
## life.sh -- Jun 25 2010, by Patsie
# awk implementation of the Game of Life. A simple automata
# Usage: life.sh [<nr of runs> [<sleep interval>] ]
#
# On a rectangular grid, let each cell be either living or dead.
# Designate a living cell with a dot and a dead one with a blank space.
# Begin with an arbitrarily drawn dot-and-blank grid, and let this be
# the starting generation. Determine each successive generation by the
# following rules:
#  1) Each cell has 8 neighbors, the adjoining cells.
#  2) A living cell with either 2 or 3 living neighbors remains alive.
#  3) A dead cell with 3 living neighbors comes alive (a birth).
#  4) All other cases result in a dead cell for the next generation.


mawk -v runs=${1:-10} -v sleep=${2:-0.5} '
BEGIN { DEAD=" "; ALIVE="o"; }

  # return if a neighbor is alive
  function isAlive(cell, neighbor) {
    if ( (neighbor < 1) || (neighbor > size) ) return 0;	 # above or below screen
    if ( ((cell%cols) == 1) && ((neighbor%cols) == 0) ) return 0; # left off screen
    if ( ((cell%cols) == 0) && ((neighbor%cols) == 1) ) return 0; # right off screen

    return (substr(data, neighbor, 1) == ALIVE)?1:0;
  }

  ## count number of alive neighbors
  function countAlive(cell) {
    cnt  = isAlive(cell, cell-cols-1) + isAlive(cell, cell-cols) + isAlive(cell, cell-cols+1);
    cnt += isAlive(cell, cell-1) + isAlive(cell, cell+1);
    cnt += isAlive(cell, cell+cols-1) + isAlive(cell, cell+cols) + isAlive(cell, cell+cols+1);

    return cnt;
  }

  # display playfield
  function display(field) {
    for (i=0; i<lines; i++)
      printf("%s\n", substr(field, i*cols+1, cols));
  }
{
  # get generation 0 from stdin
  lines++;		# count all lines
  data=data""$0;	# add read data
} END {

  ## clear screen
  printf("\033[2J");

  ## calc number of columns
  size = length(data);
  cols = int(size/lines);
  if ( (size/lines) != cols) { printf("Incorrect data\n"); exit(1); }

  ## do number of runs
  for (run=0; run<runs; run++) {
    printf("\033[HItteration %d/%d:\033[K\n", run, runs);
    display(data);

    ## generate new data
    newdata="";
    for (cell=1; cell<=size; cell++) {
      oldstate = substr(data, cell, 1);	# get old cell state
      newstate = DEAD;			# default state is dead

      cnt = countAlive(cell);		# number of 'alives' around cell
      if (cnt == 3) newstate = ALIVE;	# 3 is always alive
      if (cnt == 2) newstate = oldstate; # no change

      newdata=newdata""newstate;
    }

    ## put newdata back and take a break
    data = newdata;
    if (sleep > 0) system(sprintf("sleep %.1f", sleep));
  }

  # display final itteration
  printf("\033[HItteration %d/%d:\033[K\n", run, runs);
  display(data);
}'
