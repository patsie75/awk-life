I made this a few years ago already while being bored.<br>
It's Conways Game of Life, written in awk.<br>
<p>
There's a seed generator <pre>genlife.sh</pre> and the actual game renderer <pre>life.sh</pre>
<p>
<pre>
## genlife.sh -- Jun 25 2010, by Patsie
# generates random data for a first generation of Life
# usage: genlife.sh [&lt;width;&gt; [&lt;height&gt; [&lt;fill percentage&gt;] ] ]
# defaults to a grid of 15x10 with 25% filling
</pre>
<p>
Like the comment in the seed generator says, it accepts up to 3 parameters. A width, a height and a fill percentage<br>
Since the game renderer has an extra statusbar line at the top and you need a free line at the bottom, you could generate a seed as big as your terminal like:<br>
<pre>
./genlife.sh $COLUMNS $((LINES-2))
</pre>
<p>
<pre>
## life.sh -- Jun 25 2010, by Patsie
# awk implementation of the Game of Life. A simple automata
# Usage: life.sh [&lt;nr of runs&gt; [&lt;sleep interval&gt;] ]
</pre>
<p>
The game renderer takes a seed from stdin and runs it for a specified amount of frames/runs with a small 'sleep' interval in between each frame/run.<br>
You can also specify these as arguments. To run for 100 frames with a 0.1 second sleep interval:<br>
<pre>
./life 100 0.1
</pre>
<p>
Now lets combine the two to get something which actually produces some output:<br>
<pre>
./genlife.sh | ./life.sh
</pre>
or<br>
<pre>
./genlife.sh $COLUMNS $((LINES-2)) | ./life.sh 100 0.1
</pre>

