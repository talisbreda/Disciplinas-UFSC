import pickle
from empresa import Empresa


class EmpresaDAO:
    def __init__(self, datasource="empresa.pkl"):
        self.__datasource = datasource
        self.__object_cache = {}
        self.__dump()

    def __dump(self):
        pickle.dump(self.__object_cache, open(self.__datasource, 'wb'))

    def __load(self):
        self.__object_cache = pickle.load(open(self.__datasource, 'rb'))

    def add(self, empresa: Empresa) -> None:
        self.__object_cache[empresa.cnpj] = empresa
        self.__dump()

    def get(self, cnpj: int) -> Empresa:
        self.__load()
        try:
            return self.__object_cache.get(cnpj)
        except KeyError:
            return None

    def remove(self, empresa: Empresa):
        self.__load()
        if empresa.cnpj in self.__object_cache:
            del self.__object_cache[empresa.cnpj]
        self.__dump()

    def get_all(self):
        self.__load()
        return self.__object_cache
