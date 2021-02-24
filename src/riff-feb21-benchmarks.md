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
`riff`          0.545s
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
`riff`          0.538s
`ruby`          1.224s
--------------- ------

: spectral norm (n=500)

## Notable Recent Improvements

The implementation of [computed
goto](https://eli.thegreenplace.net/2012/07/12/computed-goto-for-efficient-dispatch-tables/)
in Riff's virtual machine sparked a significant overall performance
boost for programs which relied heavily on VM control flow (recursive
Fibonacci and Ackermann programs are good examples).

An [off-by-one
error](https://github.com/riff-lang/riff/commit/74e14f866533923199a243938b4fe4eb50c79fcd)
caused a major performance drop when benchmarking the spectral norm
program. Before fixing this, the program ran in over 5 seconds.

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
