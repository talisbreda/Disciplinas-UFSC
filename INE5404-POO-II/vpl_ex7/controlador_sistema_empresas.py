from empresa import Empresa
from empresa_dao import EmpresaDAO
from empresa_duplicada_exception import EmpresaDuplicadaException


class ControladorSistemaEmpresas:
    def __init__(self):
        self.__empresa_dao = EmpresaDAO()

    def inclui_empresa(self, empresa: Empresa):
        if isinstance(empresa, Empresa):
            cache = self.__empresa_dao.get_all()
            for i in cache:
                if i == empresa.cnpj:
                    raise EmpresaDuplicadaException
            self.__empresa_dao.add(empresa)

    def exclui_empresa(self, empresa: Empresa):
       self.__empresa_dao.remove(empresa)

    def busca_empresa_pelo_cnpj(self, cnpj: int) -> Empresa:
        return self.__empresa_dao.get(cnpj)

    @property
    def empresas(self):
        return self.__empresa_dao.get_all().values()

    def calcula_total_impostos(self) -> float:
        cache = self.empresas
        total = 0
        for empresa in cache:
            total += empresa.total_impostos()
        return total
