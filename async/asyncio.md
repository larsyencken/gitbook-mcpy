# Asyncio

In Python 3.4 the `asyncio` module was introduced, supporting non-blocking IO and cooperative multitasking in Python. In Python 3.5 additional syntax was provided to support it. `asyncio` is considered to be similar to [Twisted](async/twisted.md), but was built into core Python in order to standardize approaches across the community.

You could write a whole book just on this module alone. I can only give an outline here.

## Generators

The `yield` keyword turned from a statement into a value, letting us not only iterate but to send it values. For example, take this simple function:

```python
def double(x):
    return 2 * x

double(3)  # returns 6
double(8)  # returns 16
```

We can treat this function like a little service, and make a generator version using `yield` and `send`:

```python
def double():
    v = None
    while True:
        v = 2 * (yield)

next(double)    # advance to the first yield point

double.send(3)  # returns 6
double.send(8)  # returns 16
```

This is basically how a coroutine is implemented.

## Coroutines

You can define them two ways. In Python 3.4 use the decorator:

```python
@asyncio.coroutine
def hello_world():
    print('Hello world!')
```

From 3.5 onwards use `async def`:

```python
async def hello_world():
    print('Hello world!')
```

Calling one of these functions does not execute the function, it returns a representation of the coroutine that can be run by an event loop.

## The event loop

Coroutines are managed in an event loop. There is a global default one that you can fetch and work with:

```pycon
>>> loop = asyncio.get_event_loop()
>>> loop.run_until_complete(hello_world())
Hello world!
>>> loop.close()
```

The loop itself can be passed to coroutines, which can call `stop()` on it to halt further execution. Once a suitable set of coroutines has been set up, `run_forever()` can be called to leave it executing those routines.

Coroutines can be set to run immediately with `call_soon()`, or after a delay with `call_later()`. You can yield to the next item in the loop with `await asyncio.sleep(0)`.

## Chaining

Use `ensure_future` to kick off a task, to begin running at next opportunity. Use `await` to let other coroutines run until the result you want is ready.

```python
async def hello():
    w = asyncio.ensure_future(world())

    # block (world begins executing)
    await asyncio.sleep(1)

    print('Hello ', end='', flush=True)
    print(await w)


async def world():
    await asyncio.sleep(2)
    return 'world!'


loop = asyncio.get_event_loop()
loop.run_until_complete(hello())
loop.close()
```

## Queues

An async version of `queue.Queue` is available in `asyncio`. Instead of potentially blocking on `get()` or `put()`, it returns a coroutine for each. This means that you won't actually queue or dequeue anything unless you use either `ensure_future` or `await`.

```python
q = asyncio.Queue()
asyncio.ensure_future(q.put(1))
asyncio.ensure_future(q.put(2))
asyncio.ensure_future(q.put(3))

...

do_something(await q.get())
```

Here, the items would get put into the queue at their next chance to run.

## Debugging

Because of the difficulty of bugs encountered programming this way, a special [debug mode](https://docs.python.org/3/library/asyncio-dev.html#debug-mode-of-asyncio) is available with extended logging.

## Read more

- http://legacy.python.org/dev/peps/pep-0342/
- http://www.getoffmalawn.com/blog/playing-with-asyncio
