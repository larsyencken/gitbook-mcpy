# Futures

Futures are a way of programming asynchronously. We submit our call as a request:

```python
promise = executor.submit(something_slow_or_expensive)
```

Then we keep moving, free to run other code until we actually need the result.

```python
r = promise.result()  # block until completion
do_something(r)
```

The executor can either be a pool of threads or a pool of processes.

## Thread pools

```python
from concurrent import futures

with futures.ThreadPoolExecutor(max_workers=4) as e:
    e.submit(shutil.copy, 'src1.txt', 'dest1.txt')
    e.submit(shutil.copy, 'src2.txt', 'dest2.txt')
    e.submit(shutil.copy, 'src3.txt', 'dest3.txt')
    e.submit(shutil.copy, 'src4.txt', 'dest4.txt')
```

## Process pool

```python
from concurrent import futures
import math

PRIMES = [
    112272535095293,
    112582705942171,
    112272535095293,
    115280095190773,
    115797848077099,
    1099726899285419,
]

def is_prime(n):
    if n % 2 == 0:
        return False

    sqrt_n = int(math.floor(math.sqrt(n)))
    for i in range(3, sqrt_n + 1, 2):
        if n % i == 0:
            return False
    return True

with futures.ProcessPoolExecutor() as e:
    for number, prime in zip(PRIMES, e.map(is_prime, PRIMES)):
        print('%d is prime: %s' % (number, prime))
```
