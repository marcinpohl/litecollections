# litecollections

Python collections and common container types, except its all backed by SQLite for large scale disk backed operations and ACID operations.

### To Install

Recommend:

```
python3 -m pip install --user litecollections
```

If you're using venvs:

```
pip install litecollections
```

If you want test utilities included, set the environment variable `$TEST_TOOLS` to `1` like the following.

```
TEST_TOOLS=1 python3 -m pip install --user litecollections
```

or

```
TEST_TOOLS=1 pip install litecollections
```

### The Data Types

| stdlib equivalent | sqlite backed alternative | status |
|:---:|:---:|:---:|
`dict`
`set`
`list`
`collections.namedtuple`
`collections.deque`
`collections.Counter`
`collections.OrderedDict`
`collections.defaultdict`
`queue.Queue`
`queue.LifoQueue`
`queue.PriorityQueue`
`queue.SimpleQueue`
`array.ArrayType`
`graphlib.TopologicalSorter`

