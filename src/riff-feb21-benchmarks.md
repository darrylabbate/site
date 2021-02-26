---
title:  'Riff: February 2021 Benchmarks'
author: Darryl Abbate
date:   2021/02/22
...

I regularly benchmark [Riff](https://riff.cx) as I implement new
features into the language or new optimizations for the VM. These
benchmarks are very useful for finding incorrect and/or
poorly-performing parts of the interpreter.

--------------- ------
`luajit`        0.090s
`luajit -j off` 0.463s
`riff`          0.541s
`lua`           0.757s
`ruby`          0.829s
--------------- ------

: fibonacci(35)

<br>

--------------- ------
`luajit`        0.136s
`luajit -j off` 0.578s
`riff`          0.791s
`lua`           1.015s
`ruby`          1.376s
--------------- ------

: ackermann(3,10)

<br>

--------------- ------
`luajit`        0.020s
`luajit -j off` 0.256s
`lua`           0.449s
`riff`          0.522s
`ruby`          1.224s
--------------- ------

: spectral norm ($n$=500)

## Notable Recent Improvements

The implementation of [computed
goto](https://eli.thegreenplace.net/2012/07/12/computed-goto-for-efficient-dispatch-tables/)
in Riff's virtual machine sparked a significant overall performance
boost for programs which relied heavily on VM control flow (recursive
Fibonacci and Ackermann programs are good examples). Before, the
interpreter loop was a standard giant `switch`-`case` construct inside
a `while` loop[^1].

[^1]: It still is, actually, if the compiler doesn't support GNU C
  extensions

| Program     | Before | After  | Δ           |
| -------     | ------ | -----  | -           |
| `fib(35)`   | 0.638s | 0.541s | **-15.21%** |
| `ack(3,10)` | 1.146s | 0.791s | **-30.98%** |
| `s-n(500)`  | 0.615s | 0.522s | **-15.12%** |

: Benchmark comparison: computed goto

These improvements line up with the improvements noted in Eli
Bendersky's blog post.

> I did some simple benchmarking with random opcodes and the `goto` version is 25% faster than the `switch` version.

> Comments inside the CPython implementation note that using computed goto made the Python VM 15-20% faster

## Notes

Programs were benchmarked on a 2018 Mac mini with a 3.0 GHz 6-core
processor and 32GB of 2667 MHz DDR4 RAM.

`riff` was compiled with Apple clang 12.0 (`clang-1200.0.32.27`) with
`-O3` optimizations enabled.

| Interpreter | Version  | Source                            |
| ----------- | -------  | ------                            |
| Lua         | 5.4.2    | Homebrew-installed                |
| LuaJIT      | 2.0.5    | Homebrew-installed                |
| Ruby        | 2.6.3p62 | Default interpreter on macOS 11.2 |
