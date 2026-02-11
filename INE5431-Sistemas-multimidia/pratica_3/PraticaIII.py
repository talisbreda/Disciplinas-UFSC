from PIL import Image
from Cuif import Cuif
import math

def PSNR(original,decodificada,b):
    try:
        mse = MSE(original,decodificada) 
        psnr = 10*math.log10(((2**b-1)**2)/mse)
        return psnr
    except ZeroDivisionError:
        return "Infinito"

def MSE(ori, dec):
    nsymbols = ori.width * ori.height * 3
    for i in range(ori.width):
        for j in range(ori.height):
            ori_r, ori_g, ori_b = ori.getpixel((i, j))
            dec_r, dec_g, dec_b = dec.getpixel((i, j))
            mse = ((ori_r - dec_r) + (ori_g - dec_g) + (ori_b - dec_b))**2
            mse = mse/(nsymbols)
    return mse

if __name__ == "__main__":
    # filepath = '/content/drive/MyDrive/PraticaIII/lena.bmp'
    filepath = 'peixe.bmp'
    img = Image.open(filepath)
    matriculas = [22102202, 21203356, 21104148]

    #------------------------------------------------------------------
    # CUIF.1
    #------------------------------------------------------------------
    
    # # instancia objeto Cuif, convertendo imagem em CUIF.1
    # cuif = Cuif(img,1,matriculas)
    
    # # imprime cabeçalho Cuif
    # cuif.printHeader()
    
    # # mostra imagem Cuif
    # cuif.show()
    
    # #gera o arquivo Cuif.1
    # cuif.save('peixe1.cuif')
    
    # #Abre um arquivo Cuif e gera o objeto Cuif
    # cuif1 = Cuif.openCUIF('peixe1.cuif')
    
    # # Converte arquivo Cuif em BMP e mostra
    # cuif1.saveBMP("peixe1.bmp")
    # cuif1.show()
    
    # img1 = Image.open("peixe1.bmp")

    # psnr = PSNR(img, img1, 8)
    # print(f'Calculo do PSNR: {psnr}')

    #------------------------------------------------------------------
    # CUIF.2
    #------------------------------------------------------------------

    # instancia objeto Cuif, convertendo imagem em CUIF.1
    cuif = Cuif(img,2,matriculas)
    
    # imprime cabeçalho Cuif
    cuif.printHeader()
    
    # mostra imagem Cuif
    # cuif.show()
    
    #gera o arquivo Cuif.1
    cuif.save('peixe2.cuif')
    
    #Abre um arquivo Cuif e gera o objeto Cuif
    cuif2 = Cuif.openCUIF('peixe2.cuif')
    
    # Converte arquivo Cuif em BMP e mostra
    cuif2.saveBMP("peixe2.bmp")
    cuif2.show()
    
    img2 = Image.open("peixe2.bmp")
    img2.show()

    psnr = PSNR(img, img2, 8)
    print(f'Calculo do PSNR: {psnr}')