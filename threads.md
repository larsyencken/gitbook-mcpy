# Threads

Threads are OS-scheduled routines for execution. Unlike async methods, they can be preempted at any time, which can make them more dangerous to work with.

## Processes vs threads

A process can have many threads. Threads can communicate between each other more quickly than processes can, and spawning a new thread is cheaper than spawning a new process. But threads cannot run independently of the parent process, whereas processes can.

In other languages, threads can run concurrently and thus fully make use of a multi-core machine. In Python, and other dynamic languages, there is a global interpreter lock (GIL) that prevents more than one thread running at once.

Although the GIL prevents multicore pure Python using threads, many C extensions that do cpu-bound work release the GIL whilst they work, providing a work-around in some cases. In other cases, threads are still useful for doing concurrent actions which are not cpu-bound, like IO.

## Thread pools

The `concurrent.futures` module supports futures using threads. Here is one of their examples:

```python
import shutil
from concurrent import futures

with futures.ThreadPoolExecutor(max_workers=4) as e:
    e.submit(shutil.copy, 'src1.txt', 'dest1.txt')
    e.submit(shutil.copy, 'src2.txt', 'dest2.txt')
    e.submit(shutil.copy, 'src3.txt', 'dest3.txt')
    e.submit(shutil.copy, 'src4.txt', 'dest4.txt')
```

The context manager blocks until all the tasks are completed, shutting down the thread pool after.

## Spawning threads

The `threading` module provides a high-level version of threads.

```python
def hello_world():
    time.sleep(3)
    print('Hello world!')


t = threading.Thread(target=hello_world)
t.start()
t.join()  # blocks for 3 seconds
```

https://docs.python.org/3.5/library/threading.html
