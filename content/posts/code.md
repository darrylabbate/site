+++
title = 'Example Code'
url   = 'code'
+++

#### AWK
```awk
BEGIN { FS="" }

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
$ echo hello | awk '{print $0}'
```

#### C
```c
#include <stdio.h>

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