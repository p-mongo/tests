from importlib.util import find_spec

if find_spec('custom2'):
    import custom2
else:
    class custom2:
        class Custom:
            ...

class MyCustomExtended(custom2.Custom):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
