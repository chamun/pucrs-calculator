# The calculator

This is the second project of the Algoritmos e Estruturas de Dados I (Algorithms
and Data Structures I) discipline offered at Pontíficia Universidade Católica do
Rio Grande do Sul (PUCRS), Brazil.

The task is to implement a set of operations in a postfix calculator. More
details can be found at `t2.pdf` (but they are in Portuguese.)

The model HP9100A was chosen to name this project's main class because it was
the first model name I read in
[this](https://en.wikipedia.org/wiki/Reverse_Polish_notation) Wikipedia article,
and I wanted a real postfix calculator name.

More information of this discipline can be found at its
[website](http://www.inf.pucrs.br/~oliveira/alestI/index.html) (also in
Portuguese.)

### How to run

This project is written in ruby, so you'll need ruby to run it.

Just type `ruby main.rb` followed by any number of input files.

Ex.:

    ruby main.rb input/x1 input/x2

example input files are located under `input/`.

**VERY IMPORTANT:** You'll need ruby 2.2. Previous versions have a bug on
Math.atan2 when both arguments are +Infinity or -Infinity.

### How to test

You'll need rspec.

    gem install rspec

To run just type

    rspec

in the project root.
