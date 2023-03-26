"""Universidade Federal de Santa Catarina.
   CTC - Centro Tecnologico - http://ctc.ufsc.br
   INE - Departamento de Informatica e Estatistica - http://inf.ufsc.br
"""

class Ordenacao():

    def __init__(self, arr):
        self.arr = arr
        return

    def ordena(self):
        n = len(self.arr)
        for i in range (n):
            for j in range (i+1, n):
                if self.arr[i] <= self.arr[j]:
                    continue
                elif self.arr[i] > self.arr[j]:
                    self.arr[i], self.arr[j] = self.arr[j], self.arr[i]
        
        return self.arr

    def toString(self):
        n = len(self.arr)
        out = ""
        for i in range (n):
            if i == 0:
                out += str(self.arr[i])
            else:
                out += "," + str(self.arr[i])
        
        return out
        
