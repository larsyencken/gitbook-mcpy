# Atomic operations

An operation is _atomic_ if it cannot be interrupted. In Python, these operations are atomic:

- reading or replacing a single instance attribute
- reading or replacing a single global variable
- fetching an item from a list
- modifying a list in-place (e.g. with `append`)
- fetching an item from a dictionary
- modifying a dictionary in-place

Examples of things which are not atomic:

- Read a variable and write a new value back to it
