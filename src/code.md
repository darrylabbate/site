---
title: "Example Code"
...

#### ASM

```asm
; Program:      Reverse a String (No push or pop instructions)
; Author:       Darryl Abbate
; Version:      19.16.03

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
string  BYTE    "abcdefghij",0          ; Initial string
strSize = ($ - string) - 1
temp    BYTE    SIZEOF string DUP(?)    ; Var for holding the reversed string

.code
main proc
        mov     ESI, 0                  ; Set source pointer to 0 (first element)
        mov     EDI, strSize - 1        ; Set destination pointer to last element
        mov     ECX, strSize            ; Set loop counter

L1:     mov     AL, string[esi]         ; Store element in AL (first, then second, third...)
        mov     temp[edi], AL           ; And move it into temp (last element, then second-last...)
        inc     ESI                     ; Increment ESI so the next iteration will grab the next element
        dec     EDI                     ; Decrement EDI so the next iteration will store the element in reverse order
        loop    L1

        mov     ESI, 0                  ; Reset source-index pointer to 0
        mov     ECX, strSize            ; Reset loop counter

L2:     mov     AL, temp[esi]           ; Loop 2 = loop 1 where both variables use ESI from 0
        mov     string[esi], AL
        inc     ESI
        loop    L2

        invoke  ExitProcess,0
main endp
end main
```

#### NASM

(Different than `asm`)

```nasm
; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit macOS only.
; To assemble and run:
;
;     nasm -fmacho64 hello.asm && ld hello.o -lSystem && ./a.out
; ----------------------------------------------------------------------------------------

          global    _main

          section   .text
_main:    mov       rax, 0x02000004         ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, message            ; address of string to output
          mov       rdx, 13                 ; number of bytes
          syscall                           ; invoke operating system to do the write
          mov       rax, 0x02000001         ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit

          section   .data
message:  db        "Hello, World", 10      ; note the newline at the end
```

#### AWK
```awk
BEGIN { FS="" } # here's a comment

/pattern/ {
  while (1) {
    for (x in y) {
      z += y[x]
    }
  }
}
```

#### Bash
```bash
$ echo hello | awk '{print $0}' # comment
```

#### C
```c
#include <stdio.h>

// Say hello
int main(void)
{
  printf("Hello, World!\n");
  return 0;
}
```

#### diff
```diff
---one
+++two
-red
+blue
```

#### Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           System.Environment (getArgs)

main :: IO ()
main = getArgs >>= parse

parse ["-h"] = usage
parse ["-v"] = version
parse []     = sayHello

sayHello :: IO ()
sayHello = putStrLn "Hello World" -- Say hello
```

#### Java

```java
import java.util.ArrayList;

public class Recursion
{
    // Ooh javadoc
    /**
     * Finds the "minimum" (i.e. first alphabetically) <code>String</code>
     * in an <code>ArrayList&lt;String&gt;</code>. This method compares
     * two strings at a time using <code>compareTo(String,String)</code>.
     *
     * @param  stringArray the ArrayList&lt;String&gt; to search through.
     * @return the String which comes first alphabetically.
     */
    public static String findMinimum(ArrayList<String> stringArray)
    {
        if (stringArray.size() == 1) return stringArray.get(0);
        return (compareTo(stringArray.get(0), stringArray.get(stringArray.size() - 1)) > 0)
               ? findMinimum(new ArrayList<String>(stringArray.subList(1, stringArray.size())))
               : findMinimum(new ArrayList<String>(stringArray.subList(0, stringArray.size() - 1)));
    }
}
```

#### Make

```makefile
DOC_DIR = doc/            # Change this to change where Javadocs are compiled

CFLAGS = -Xlint:unchecked

DFLAGS += -Xdoclint:none
DFLAGS += -d $(DOC_DIR)

JAVAC_ARTIFACTS = *.class

.PHONY: all clean javadoc test
.SILENT: all clean javadoc test

all: javadoc test

clean:
	echo Removing compiled java files...
	rm -f $(JAVAC_ARTIFACTS)
	echo Removing javadoc artifacts...
	rm -rf $(DOC_DIR)

javadoc:
	echo Compiling javadoc documentation files...
	javadoc $(DFLAGS) *.java
	echo Docs are located in the /doc subdirectory

test:
	echo Compiling and running tests...
	javac *.java $(CFLAGS)
	java org.junit.runner.JUnitCore Tester
```
