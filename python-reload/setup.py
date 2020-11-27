

from distutils.core import Extension, setup

custom_ext = Extension("custom2", ["src/custom.c"])
setup(name="custom2", version="1.0", ext_modules=[custom_ext])


