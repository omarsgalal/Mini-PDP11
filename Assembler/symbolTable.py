class SymbolTable:
    def __init__(self, initialPairs = {}):
        self.pairs = initialPairs

    def remember(self, key):
        self.pairs[key] = None

    def isExist(self, key):
        return key in self.pairs.keys()

    def update(self, key, value):
        self.pairs[key] = value

    def get(self, key):
        return self.pairs[key]

ST = SymbolTable()

    