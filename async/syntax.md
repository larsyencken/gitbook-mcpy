# Syntax support

## Coroutines

In a change to Python's syntax, yield now returns a value within the generator function. The value can be explicitly given with `send()`; if the iterator is advanced with `next()` then the value is `None`.

```python
def double(x):
    return x * 2

def double_service():
    v = None
    while True:
        v = 2 * (yield)

s = double_service()
next(s)  # manually advance to the yield point

s.send(10)  # returns 20
```
