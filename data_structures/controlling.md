# Controlling access

We can use _locks_ to make a larger block atomic, or limit access to just one consumer. If we want to allow multiple consumers, but put some bounds on how many at once, we can use a _semaphore_.

## Locks

If you use a lock, then you will block until you can acquire it. This context manager hides a blocking call to `lock.acquire()`.

```python
import threading

lock = threading.Lock()
with lock:
    do_something()  # access shared resource
```

You can attempt to acquire a lock in a non-blocking way:

```python
if not lock.acquire(False):
    # we didn't get the lock
```

But you can't check if it's unlocked and be guaranteed to acquire it. Someone else may have it by then:

```python
if not lock.locked():
    # someone else may get the lock between these two statements
    lock.acquire()
```

The [Effbot threading article](http://effbot.org/zone/thread-synchronization.htm) notes that locks may block even the same thread from acquiring the lock twice, which is usually overkill. A _re-entrant lock_ (`threading.RLock`) only blocks if another thread is holding the lock.

## Semaphores

Semaphores are a more general type of lock implemented with a counter. Instead of just one thread holding the lock, $$n$$ threads can hold the semaphore. So, a lock is just a semaphore where $$n = 1$$.

Python offers two types:

- `threading.Semaphore`: implements a plain counter $$c$$ initialized to $$n$$
- `threading.BoundedSemaphore`: also enforces that $$c \in [0, n]$$
