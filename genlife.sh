#!/bin/sh
## genlife.sh -- Jun 25 2010, by Patsie
# generates random data for a first generation of Life
# usage: genlife.sh [<width> [<height> [<fill percentage>] ] ]
# defaults to a grid of 15x10 with 25% filling

awk -v width=${1:-15} -v height=${2:-10} -v perc=${3:-25} '
BEGIN { DEAD=" "; ALIVE="o"; srand(); }
END {
  for (y=0; y<height; y++) {
    for (x=0; x<width; x++)
      printf("%c", (rand()*100<perc)?ALIVE:DEAD);
    printf("\n");
  }
}' </dev/null
