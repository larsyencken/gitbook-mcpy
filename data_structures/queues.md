# Queue

Python provides several implementations of multi-consumer, multi-producer queues. They are perhaps the best way to communicate data between threads.

The three modules provides queues in Python:

- `queue.Queue`: thread-safe queue
- `asyncio.Queue`: unsafe queue
- `multiprocessing.Queue`: thread-safe and process-safe queue

## Basic operations

Queues support `put()` and `get()` methods, both of which can be blocking.

All queues will block on `get()` if the queue is empty:

```python
q1 = queue.Queue()
q1.put(10)
q1.get()  # returns 10
q1.get()  # blocks...
```

Size bounded queues will block on `put()` if the queue is full:

```python
q2 = queue.Queue(2)
q2.put(10)
q2.put(3)
q3.put(8)  # blocks...
```

The non-blocking `put_nowait()` and `get_nowait()` can be used instead of blocking ones.

The queue's status can be checked with `q.empty()` and `q.full()`, but by the time you act on that information the queue's status might have changed again.

## Completion

Queues have an internal counter of items queued up. If each item dequeued is eventually paired with a `q.task_done()` call, then you can wait for all tasks to be completed with `q.join()`.

The example given in the [queue documentation](https://docs.python.org/3.5/library/queue.html) is:

```python
def worker():
    while True:
        item = q.get()
        if item is None:
            break
        do_work(item)
        q.task_done()

q = queue.Queue()
threads = []
for i in range(num_worker_threads):
    t = threading.Thread(target=worker)
    t.start()
    threads.append(t)

for item in source():
    q.put(item)

# block until all tasks are done
q.join()

# stop workers
for i in range(num_worker_threads):
    q.put(None)
for t in threads:
    t.join()
```

Note the use of `None` as a tombstone here, telling the workers to stop processing items.
