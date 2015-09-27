# Select

## Checking for readiness

In many situations, attempting to read or write to a file handle causes us to block until data is available to be returned. Instead of blocking, most operating systems support a non-blocking check if data is available. On Windows this only works for sockets, but on Linux, BSD and Solaris it works on files too.

In this simple example, we are able to do something else (printing "Nothing") whilst waiting for input to arrive.

```python
import select
import sys


def has_input(f, timeout):
    "Block for up to timeout seconds waiting for input."
    return bool(select.select([f], [], [], timeout)[0])


while True:
    # print Nothing every second until input arrives
    while not has_input(sys.stdin, 1.0):
        print('Nothing')

    print('Something: {}'.format(sys.stdin.readline()), end='')
```

In each inner loop condition, we are checking if `stdin` is ready to read from yet.

The main benefits from select come when we're dealing with a large number of file descriptors. Queuing up IO takes time, and if we do it in a non-blocking manner we can queue up many more operations with the same CPU capacity.

## Using select

The interface for `select()` lets you pass in three parameters:

- `rlist`: wait until these are ready to read
- `wlist`: wait until these are ready to write
- `xlist`: wait until these have "exceptional events"

`select` blocks until one or more file descriptor in one of these three lists meets the conditions specified, returning three matching lists to describe which ones are available.

Using select means you never waste cycles waiting for one resource to become available whilst another is ready for use, letting us do far more IO operations per cycle than if we simply tried to use each resource sequentially.

## Read more

- https://docs.python.org/3/library/select.html
