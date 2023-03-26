from empresa import Empresa
from empresa_dao import EmpresaDAO
from controlador_sistema_empresas import ControladorSistemaEmpresas

empresa = Empresa(0000, 'aaaa')
empresa1 = Empresa(1111, 'bbbb')
empresa2 = Empresa(2222, 'cccc')
empresa3 = Empresa(3333, 'dddd')
empresa4 = Empresa(4444, 'eeee')
empresaDAO = EmpresaDAO()
controller = ControladorSistemaEmpresas()
controller.inclui_empresa(empresa)
controller.inclui_empresa(empresa1)
controller.inclui_empresa(empresa2)
controller.inclui_empresa(empresa3)
controller.inclui_empresa(empresa4)

print(controller.busca_empresa_pelo_cnpj(1111).nome_de_fantasia)
