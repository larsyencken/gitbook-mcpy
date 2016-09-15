# Processes

Processes can be used for actual cpu-bound parallelism in Python. Use them whenever you have number crunching to do, or just to avoid the problems of threads.

## Forking

Splits the program into two processes at the point `os.fork()` is called, one parent and one child. This is an old-school mechanism, normally saved for servers.

```python
import os

print('Prefork:', os.getpid())      # 27102

child_pid = os.fork()

if child_pid == 0:
    print('Child:', os.getpid())    # 27122
else:
    print('Parent:', os.getpid())   # 27102
```

This is too low-level for most Python applications, use a higher-level abstraction instead.

## Manual management

```python
from multiprocessing import Process, cpu_count

# start multiple processes
procs = []
for i in range(cpu_count()):
    p = Process(target=do_something_expensive)
    p.start()
    procs.append(p)

# wait for all to complete
for p in procs:
    p.join()
```

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

Continue to [Futures](/futures.html) to read more.

https://docs.python.org/3.5/library/multiprocessing.html
