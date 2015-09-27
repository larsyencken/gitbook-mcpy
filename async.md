# Non-blocking and async

## Cooperative multitasking

In a threaded or multiprocess model, the operating system handles scheduling for us. This means that execution can be interrupted at arbitrary places, which can be hard to reason about.

In contrast, cooperative multitasking is when scheduling is handled within our program, usually by a library or framework. When one task waits for something it needs (usually IO), another task is given the chance to run. This was popularized by Node.js, but has been supported in Python for some time through `twisted` and `gevent`.

## Contents

- [Select](async/select.md)
- [Asyncio](async/asyncio.md)
- [Twisted](async/twisted.md)
- [Gevent](async/gevent.md)
