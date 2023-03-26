class Parent:
    def makeChildrenStopCry(self):
        if self.cry():
            self.doWhateverToStopCry(self)
        self.makeCry()

class Children(Parent):
    crying = False
    def makeCry(self):
        self.crying = True
        print("aaaa")
    def doWhateverToStopCry(self):
        self.crying = False
    def cry(self):
        return self.crying

Parent.makeChildrenStopCry(Parent)