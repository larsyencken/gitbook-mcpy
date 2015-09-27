# Processes

Processes can be used for actual cpu-bound parallelism in Python. Use them whenever you have number crunching to do.

## Process pools

A process pool is a high-level construct that lets you parallelise tasks easily.

### In `multiprocessing`

```python
import multiprocessing as mp
import time
import random

def f(x):
    time.sleep(1 + random.random() * 3)
    return x * x

with mp.Pool(5) as p:
    print(p.map(f, [1, 2, 3, 4, 5]))

# prints [1, 4, 9, 16, 25]
```

### In `concurrent.futures`

```python
from concurrent import futures

with futures.ProcessPoolExecutor(3) as p:
    e.submit(do_something_expensive, 'file1.txt')
    e.submit(do_something_expensive, 'file2.txt')
    e.submit(do_something_expensive, 'file3.txt')
```

https://docs.python.org/3.5/library/multiprocessing.html
