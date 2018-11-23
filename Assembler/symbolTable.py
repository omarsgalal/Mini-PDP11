class SymbolTable:
    def __init__(self, initialPairs = {}):
        self.pairs = initialPairs

    def remember(self, key, label):
        self.pairs[key] = {"value": None, "label": bool(label)}

    def isExist(self, key):
        return key in self.pairs.keys()

    def update(self, key, value, label):
        self.pairs[key] = {"value": value, "label": bool(label)}
    def get(self, key):
        return self.pairs[key]["value"]

    def isVariable(self, key):
        return self.isExist(key) and not self.pairs[key]["label"]

ST = SymbolTable()