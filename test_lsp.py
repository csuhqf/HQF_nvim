import os
import sys


def ugly_function(x, y):
    print("hello")


def another_ugly_function(a, b):
    return a + b


def main():
    result = another_ugly_function(5, 10)
    print("Result:", result)
    ugly_function("foo", "bar")


if __name__ == "__main__":
    main()
