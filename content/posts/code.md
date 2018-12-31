+++
url = 'code'
+++

```bash
$ echo hello | awk '{print $0}'
```

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

```c
#include <stdio.h>

int main(void)
{
  printf("Hello, World!\n");
  return 0;
}
```

```diff
---one
+++two
-red
+blue
```
