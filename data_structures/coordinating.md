# Coordinating

If we want threads to be able to coordinate, then they should have the means to notify one another if a resource has become available.

The `threading` module provides two types of flags, _events_ and _conditions_, which a thread can check, set, or wait on.

## Event

Events are boolean flags used to coordinate between threads:

```python
event = threading.Event()

# block until the event is set
event.wait()

# set the flag
event.set()

# clear the flag
event.clear()
```

## Condition

Conditions are similar, except that you can choose to only wake one thread waiting:

```python
condition = threading.Condition()

# producer thread
with condition:
    # wake just one waiting thread
    condition.notify()

# consumer thread
with condition:
    item = get_item()
    while not item:
        condition.wait()
        item = get_item()
process_item()
```

You can also use `condition.notify_all()` to wake all the threads that are waiting. Unlike events, conditions must be acquired like a lock in order to work with them. You can pass your own lock to the constructor if you like.
