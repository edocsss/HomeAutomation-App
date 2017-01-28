class BaseModel(object):
    def __setattr__(self, name, value):
        if hasattr(self, name):
            object.__setattr__(self, name, value)

        else:
            raise TypeError('Cannot set name {} on object of type {}!'.format(name, self.__class__.__name__))