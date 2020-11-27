from importlib.util import find_spec
from importlib import reload
from os import system, stat
import weakref
import sys


def setup():
    if system('python3 setup.py clean build install') > 0:
        raise SystemError("Failed to setup python c-api extention class")


def main():
    if find_spec('custom2') is None:
        setup()

    from utils import MyCustomExtended
    MyCustomExtended(1, 2, 3)
    print("COOL")


if __name__ == "__main__":
    main()
