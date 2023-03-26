from abc import ABC, abstractmethod
from incidencia_imposto import IncidenciaImposto


class Imposto(ABC):
    def __init__(self,
                 aliquota: float,
                 incidencia_imposto: IncidenciaImposto) -> None:
        self.__aliquota = aliquota
        self.__incidencia_imposto = incidencia_imposto

    @property
    def aliquota(self) -> float:
        return self.__aliquota

    @property
    def incidencia_imposto(self) -> float:
        return self.__incidencia_imposto

    @abstractmethod
    def calcula_aliquota(self) -> float:
        pass
