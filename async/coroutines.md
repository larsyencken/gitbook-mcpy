# Coroutines

You can define them two ways. Before Python 3.5, use the decorator:

```python
@asyncio.Coroutines
def hello_world():
    print('Hello world!')
```

From 3.5 onwards use `async def`:

```python
async def hello_world():
    print('Hello world!')
```

You run them in an event loop:

```pycon
>>> loop = async.get_event_loop()
>>> loop.run_until_complete(hello_world())
Hello world!
>>> loop.close()
```

## Read more

- http://legacy.python.org/dev/peps/pep-0342/
- http://www.getoffmalawn.com/blog/playing-with-asyncio
