---
title:  'xcv: A Fully Client-Side Pastebin Clone'
author: Darryl Abbate
date:   2021/03/25
before: '[xcv](https://rootbeersoup.github.io/xcv/) | [source code](https://github.com/rootbeersoup/xcv)'
...

As part of a web development course I'm taking in my final undergrad
semester, we were tasked with developing our own simple browser
application. I wanted to explore how some web apps utilize anchor
links to encode data in the URL.

For example, [Try It Online](https://tio.run) uses anchor links to
encode the text data of a given program. Users can share the link
to the program without the need to store the text data on the server.

Here's what a URL looks like for a [small Lua
program](https://tio.run/##yylN/P@/oCgzr0RDySM1JydfRyE8vygnRVFJ8/9/AA):

```
https://tio.run/##yylN/P@/oCgzr0RDySM1JydfRyE8vygnRVFJ8/9/AA
```

From just looking at the URL, you can tell there's some method of
compression being employed before converting the data to base-64. For
the purpose of my assignment, I decided to make a simple
[Pastebin](https://pastebin.com) clone. This way I could understand
the process of encoding and decoding URL data for potential use in any
future projects.

I ended up implementing a functionally-identical solution to
[paste](https://topaz.github.io) (credit: [Eric Wastl](http://was.tl))
I initially tried using a different JavaScript compression library but
eventually settled on the same
[LZMA-JS](https://github.com/LZMA-JS/LZMA-JS) compression library used
by Eric.

## Lessons Learned

I've used [Adobe Fonts](https://fonts.adobe.com) (formerly TypeKit)
for my web projects for a few years now. One thing I've always liked
is the ability to utilize any available [OpenType
features](https://helpx.adobe.com/fonts/user-guide.html/fonts/using/use-open-type-features.ug.html)
for a particular font[^1]. For example, [Source Code
Pro](https://fonts.adobe.com/fonts/source-code-pro) is my favorite
monospace font; I use it everywhere I can. However, I'm not a huge
fan of the dotted zeros. With OpenType features, I can add this one
line of Sass/CSS to enable slashed zeros in the imported font:

[^1]: As far as I'm aware, this feature is not available via Google Fonts.

```sass
font-feature-settings: 'zero' on
```

I ran into an issue where, for larger text inputs (say ~1,000 lines),
the generated URL would disappear from the input field even though the
URL was technically in the input field; the "copy link" button still
copied the URL to the clipboard.

Through a little trial-and-error, I discovered disabling the
`font-fature-settings` line fixed this issue. Very strange.
