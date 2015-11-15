# Common patterns

## Asynchronous requests

### Using grequests

```python
import grequests

urls = [
    'http://www.heroku.com',
    'http://python-tablib.org',
    'http://httpbin.org',
    'http://python-requests.org',
    'http://kennethreitz.com'
]

# pending requests created
rs = (grequests.get(u) for u in urls)

# requests queued
grequests.map(rs)
```

## Using requests-futures

```python
from requests_futures.sessions import FuturesSession

session = FuturesSession()

# start requests in the background
future_one = session.get('http://httpbin.org/get')
future_two = session.get('http://httpbin.org/get?foo=bar')

# block until the request completes
response_one = future_one.result()
```

### Using aiohttp

```python
import asyncio
import aiohttp

urls = [
    'http://www.heroku.com',
    'http://python-tablib.org',
    'http://httpbin.org',
    'http://python-requests.org',
    'http://kennethreitz.com'
]

# make one future for all the coroutines together
requests = asyncio.gather(
    *[aiohttp.get(u) for u in urls]
)

# run it in the event loop
loop = asyncio.get_event_loop()
responses = loop.run_until_complete(requests)
```
