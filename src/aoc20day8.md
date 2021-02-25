---
title:  'Advent of Code 2020: Day 8 Solution'
author: Darryl Abbate
date:   2020/12/08
before: 
    - A [user on Reddit asked](https://www.reddit.com/r/adventofcode/comments/k8xw8h/2020_day_08_solutions/gf38rf6/) me to explain my AWK one-line solution to [day 8](https://adventofcode.com/2020/day/8)'s puzzle (part 1); specifically to understand what's going on in AWK.

after:
    - AWK is one of my favorite programming languages, and I find it especially well-suited for Advent of Code puzzles. I solved [every 2019 puzzle](https://github.com/rootbeersoup/aoc/tree/master/19) in AWK and even wrote an overly-complex [assembler/disassembler/debugger/interpreter](https://github.com/rootbeersoup/aoc/blob/master/19/intcode.awk) for [Intcode](https://adventofcode.com/2019/day/2) in AWK.
...


```
awk '{p[NR]=$2$1}END{i=1;for(;;){if(r[i]++){print a;exit}p[i]~/a/?a+=p[i++]:p[i]~/j/?i+=p[i]:++i}}' input
```

The puzzle basically asks you to simulate a very simple virtual
machine, with only `acc`, `jmp` and `nop` instructions. For the first
part, you're asked for the value in the accumulator *before* any
instruction is run a second time.

## Input Parsing

By default, AWK's Record Separator (`RS`) is a newline. The Field
Separator (`FS`) is any whitespace. AWK will process the input one
line at a time.

```
{ p[NR] = $2$1 }
```

This code block is an **empty pattern**, meaning AWK will
unconditionally execute it once for each line of input. For each line
of input, we want AWK to store the second field (`$2`) concatenated
with the first field (`$1`) in an [associative
array](https://en.wikipedia.org/wiki/Associative_array) `p`. The key
being used here is `NR`, a special AWK variable which holds the
current record number (or line number) of the input.

For example, when given the following input:

```
nop +335
acc +46
jmp +42
```

The array `p` will be populated as follows:

```
p[1] = "+355nop"
p[2] = "+46acc"
p[3] = "+42jmp"
```

We want `$2` to precede `$1` in the concatenated strings to take
advantage of the numeric coercion AWK employs when performing
arithmetic on strings. AWK will coerce a string such as `+46acc` as
the number `46` when used as an operand in an arithmetic expression.

## The `END` Block

Code in the `END` block is executed once all input has been processed.

```awk
END {
    i = 1
    for (;;) {
        if (r[i]++) {
            print a
            exit
        }
        p[i] ~ /a/ ? a += p[i++] : p[i] ~ /j/ ? i += p[i] : ++i
    }
}
```

The entire "virtual machine" is modeled in just 8 lines of AWK code
inside the `END` block. We use a few variables to represent different
parts of the machine.


----------------------------------------------------------------------
 Variable  Description
---------- -----------------------------------------------------------
`a`        The accumulator. This value will change for every `acc`
           instruction executed.

`i`        The "instruction pointer" (or program counter). This keeps
           track of our position in the input program (stored in the
           array `p`). This is initialized to `1` since our entry
           point (first instruction) is at `p[1]`.

`p`        The input program, which was initialized earlier.

`r`        We use a second associative array `r` to mark which
           instructions have already been run.
----------------------------------------------------------------------

```awk
for (;;) {
    ...
}
```

This represents the interpreter loop, which will run until we
explicitly `exit` the program.

```awk
if (r[i]++) {
    print a
    exit
}
```

Here, we increment `r[i]` to mark the instruction `i` as "run." If
`r[i]` was already non-zero, we print the value in accumulator (`a`)
and exit; the puzzle is solved!

```awk
p[i] ~ /a/ ? a += p[i++] : p[i] ~ /j/ ? i += p[i] : ++i
```

Otherwise, we use this chained ternary expression as a concise
*if-else* construct.

If the string in `p[i]` contains the letter "`a`", we know the
instruction is `acc`; we add the value of `p[i]` to `a`. As mentioned
earlier, AWK will coerce the string to a number when used as an addition
operand. We also increment `i` so `p[i]` will point to the succeeding
instruction when the interpreter loop jumps back to the beginning.

Else, if `p[i]` contains the letter "`j`", we know it's a `jmp`
instruction. Instead of adding `p[i]` to `a`, we add it to `i` to
simulate a "jump" in the program.

Finally, we can just assume the instruction is a `nop` if it reaches
the final clause in the ternary expression. In this case, we just
increment `i`.
