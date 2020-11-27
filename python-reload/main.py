import utils
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
        for module_name in list(sys.modules.keys()):
            m = sys.modules.get(module_name)
            if not hasattr(m, '__file__'):
                continue
            if getattr(m, '__name__', None) in [None, '__mp_main__', '__main__']:
                continue

        reload(utils)

    MyCustomExtended = utils.MyCustomExtended
    print(MyCustomExtended)
    MyCustomExtended(1, 2, 3)
    print("COOL")


if __name__ == "__main__":
    main()
