---
title:  'Riff: Early Ideas and Motivation'
author: Darryl Abbate
date:   2020/09/30
before:
    - This post is transposed from part of a presentation I gave as
      part of an Undergraduate Seminar. Feel free to check out [Riff's
      website](https://riff.cx) to learn more about the project.
...

## What is Riff?

Riff is a general-purpose programming language I started developing
around April 2020 as a hobby project. Riff is dynamically-typed and
designed with a focus on prototyping and command-line usage.

## Design Goals

- Design a *supplementary tool* which can be useful for all
  programmers, regardless of their preferred language or paradigm. In
  other words, I want Riff to *coexist*, not *compete*.
- Expressiveness without compromises - I want to push the limits of
  what's possible grammatically and syntactically. An example of this
  is optional statement terminators, similar to Lua.
- Most importantly, **something I'll actually use myself**.

## Motivation

```c
int main(void) {
    int x = 0;
    x * 2 + 1;  // What happens to this?
    return 0;
}
```

This looks like a typical expression, but it's invalid. It's not being
assigned to a variable, it's not part of a conditional expression,
nothing. A C compiler will probably compile it (Clang raises a
warning) and Java throws an error.

## Idea

```riff
x = y + z
i++
x * i       // Print
```

My idea was to give some kind of functionality to these otherwise
invalid expression statements. Given the focus on being a command-line
protoyping tool, it made sense to simply print the results of these
"atypical" expression statements. This gives the language a kind of
"interactive" REPL-like feel without having to enter an interactive
session.

## Why Not Use `<existing_language>`?

Even if you just wanted to write one-liners, many tools and languages
already support a similar functionality.

```bash
$ perl –e 'print(30/0.5+10, "\n")'
$ awk 'BEGIN{print 30/0.5+10}'
$ python –c 'print(30/0.5+10)'
$ ruby –e 'puts 30/0.5+10'
$ lua –e 'print(30/0.5+10)'
$ riff '30/0.5+10'
```

These all work perfectly fine. All of these commands will produce the
same result. However, the Riff example is noticeably simpler; I feel
any given programmer would be more likely to remember its syntax over
the other languages' provided examples (assuming they don't actively
program in those languages).

## Caveats?

I don't want to *just* make a command-line calculator. I want it to be
actually useful. This means the language needs standard facilities like
control flow, compound data structures, user-defined functions,
a standard library of functions, etc. Does this "implicit printing"
functionality impede the ability to implement these basic language
features?[^1]

*At this point in the presentation, I briefly spoke about the
language's features before wrapping up with a simple benchmark,
placing Riff in the ballpark of Lua in terms of performance.*

[^1]: While this wasn't really a serious question for anyone familiar
  with languages and compilers, it's an understandably natural
  question for a group of undergraduate students. For what it's worth,
  since I started developing Riff, I've discovered two other languages
  with a similar "implicit printing" functionality: bc and HolyC.
