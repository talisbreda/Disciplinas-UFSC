from imposto import Imposto
from incidencia_imposto import IncidenciaImposto


class Empresa():
    def __init__(self, cnpj: int, nome_de_fantasia: str):
        self.__cnpj = cnpj
        self.__nome_de_fantasia = nome_de_fantasia
        self.__impostos = []
        self.__faturamento_servicos = 0.0
        self.__faturamento_producao = 0.0
        self.__faturamento_vendas = 0.0

    @property
    def cnpj(self) -> list:
        return self.__cnpj

    @property
    def impostos(self) -> list:
        return self.__impostos

    @property
    def nome_de_fantasia(self) -> str:
        return self.__nome_de_fantasia

    @nome_de_fantasia.setter
    def nome_de_fantasia(self, nome: str) -> None:
        self.__nome_de_fantasia = nome

    @property
    def faturamento_servicos(self) -> float:
        return self.__faturamento_servicos

    @property
    def faturamento_producao(self) -> float:
        return self.__faturamento_producao

    @property
    def faturamento_vendas(self) -> float:
        return self.__faturamento_vendas

    def inclui_imposto(self, imposto: Imposto) -> None:
        if isinstance(imposto, Imposto) and imposto not in self.__impostos:
            self.__impostos.append(imposto)

    def remove_imposto(self, imposto: Imposto) -> None:
        self.__impostos.remove(imposto)

    def faturamento_total(self) -> float:
        return (self.__faturamento_producao
                + self.__faturamento_servicos
                + self.__faturamento_vendas)

    def total_impostos(self) -> float:
        total = 0
        for imposto in self.__impostos:
            aliquota = imposto.calcula_aliquota() / 100
            if imposto.incidencia_imposto == IncidenciaImposto(1):
                total += self.__faturamento_producao * aliquota
            if imposto.incidencia_imposto == IncidenciaImposto(2):
                total += self.__faturamento_servicos * aliquota
            if imposto.incidencia_imposto == IncidenciaImposto(3):
                total += self.__faturamento_vendas * aliquota
            if imposto.incidencia_imposto == IncidenciaImposto(4):
                total += self.faturamento_total() * aliquota
        return total

    def set_faturamentos(self,
                         fat_servicos: float,
                         fat_producao: float,
                         fat_vendas: float):
        self.__faturamento_producao = fat_producao
        self.__faturamento_servicos = fat_servicos
        self.__faturamento_vendas = fat_vendas
