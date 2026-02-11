''' 
INE5431 Sistemas Multim��dia
Prof. Roberto Willrich

Aula Pr�tica IV: Compress�o de Entropia

'''

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
    mse = 0
    for i in range(ori.width):
        for j in range(ori.height):
            ori_r, ori_g, ori_b = ori.getpixel((i, j))
            dec_r, dec_g, dec_b = dec.getpixel((i, j))
            
            # Calculate squared difference for each color channel
            mse += (ori_r - dec_r) ** 2
            mse += (ori_g - dec_g) ** 2
            mse += (ori_b - dec_b) ** 2

    return mse / nsymbols

if __name__ == "__main__":

## ====== CUIF.1 ====== ##
    

    # Leitura da imagem 
    filepathBandeira = 'bandeira.bmp'
    filepathLenna = 'lenna.bmp'

    imgBandeira = Image.open(filepathBandeira)
    imgLenna = Image.open(filepathLenna)
    
    # Indique a matr��cula dos alunos do grupo na lista abaixo
    matriculas = [22102202, 21203356, 21104148]
    
    cuifBandeira1 = Cuif(imgBandeira,1,matriculas)
    cuifLenna1 = Cuif(imgLenna,1,matriculas)

    cuifBandeira1.save('cuif1/bandeira1.cuif')
    cuifLenna1.save('cuif1/lenna1.cuif')

    cuifBandeira1.saveBMP('cuif1/bandeira1.bmp')
    cuifLenna1.saveBMP('cuif1/lenna1.bmp')

    # cuifBandeira1.printHeader()
    # cuifBandeira1.show()

    img1 = Image.open('cuif1/bandeira1.bmp')
    print("PSNR do CUIF.1 (bandeira)",PSNR(imgBandeira,img1,8))

    # print("-----------------------------------------------------------")
    
    # cuifLenna1.printHeader()
    # cuifLenna1.show()

    img1 = Image.open('cuif1/lenna1.bmp')
    print("PSNR do CUIF.1 (lenna)",PSNR(imgLenna,img1,8))
    print()
    
## ==================== ##
## ====== CUIF.2 ====== ##

    # Leitura da imagem 
    filepathBandeira = 'bandeira.bmp'
    filepathLenna = 'lenna.bmp'

    imgBandeira = Image.open(filepathBandeira)
    imgLenna = Image.open(filepathLenna)
    
    # Indique a matr��cula dos alunos do grupo na lista abaixo
    matriculas = [22102202, 21203356, 21104148]
    
    cuifBandeira2 = Cuif(imgBandeira,2,matriculas)
    cuifLenna2 = Cuif(imgLenna,2,matriculas)

    cuifBandeira2.save('cuif2/bandeira2.cuif')
    cuifLenna2.save('cuif2/lenna2.cuif')

    cuifBandeira2.saveBMP('cuif2/bandeira2.bmp')
    cuifLenna2.saveBMP('cuif2/lenna2.bmp')

    # cuifBandeira2.printHeader()
    # cuifBandeira2.show()

    img1 = Image.open('cuif2/bandeira2.bmp')
    print("PSNR do CUIF.2 (bandeira)",PSNR(imgBandeira,img1,8))

    # print("-----------------------------------------------------------")
    
    # cuifLenna2.printHeader()
    # cuifLenna2.show()

    img1 = Image.open('cuif2/lenna2.bmp')
    print("PSNR do CUIF.2 (lenna)",PSNR(imgLenna,img1,8))
    print()

## ==================== ##
## ====== CUIF.3 ====== ##

    # Leitura da imagem 
    filepathBandeira = 'bandeira.bmp'
    filepathLenna = 'lenna.bmp'

    imgBandeira = Image.open(filepathBandeira)
    imgLenna = Image.open(filepathLenna)
    
    # Indique a matr��cula dos alunos do grupo na lista abaixo
    matriculas = [22102202, 21203356, 21104148]
    
    cuifBandeira3 = Cuif(imgBandeira,3,matriculas)
    cuifLenna3 = Cuif(imgLenna,3,matriculas)

    cuifBandeira3.save('cuif3/bandeira3.cuif')
    cuifLenna3.save('cuif3/lenna3.cuif')

    cuifBandeira3.saveBMP('cuif3/bandeira3.bmp')
    cuifLenna3.saveBMP('cuif3/lenna3.bmp')

    # cuifBandeira3.printHeader()
    # cuifBandeira3.show()

    img1 = Image.open('cuif3/bandeira3.bmp')
    print("PSNR do CUIF.3 (bandeira)",PSNR(imgBandeira,img1,8))

    # print("-----------------------------------------------------------")
    
    # cuifLenna3.printHeader()
    # cuifLenna3.show()

    img1 = Image.open('cuif3/lenna3.bmp')
    print("PSNR do CUIF.3 (lenna)",PSNR(imgLenna,img1,8))
    print()

## ==================== ##
## ====== CUIF.4 ====== ##

    # Leitura da imagem 
    filepathBandeira = 'bandeira.bmp'
    filepathLenna = 'lenna.bmp'

    imgBandeira = Image.open(filepathBandeira)
    imgLenna = Image.open(filepathLenna)
    
    # Indique a matr��cula dos alunos do grupo na lista abaixo
    matriculas = [22102202, 21203356, 21104148]
    
    cuifBandeira4 = Cuif(imgBandeira,4,matriculas)
    cuifLenna4 = Cuif(imgLenna,4,matriculas)

    cuifBandeira4.save('cuif4/bandeira4.cuif')
    cuifLenna4.save('cuif4/lenna4.cuif')

    cuifBandeira4.saveBMP('cuif4/bandeira4.bmp')
    cuifLenna4.saveBMP('cuif4/lenna4.bmp')

    # cuifBandeira4.printHeader()
    # cuifBandeira4.show()

    img1 = Image.open('cuif4/bandeira4.bmp')
    print("PSNR do CUIF.4 (bandeira)",PSNR(imgBandeira,img1,8))

    # print("-----------------------------------------------------------")
    
    # cuifLenna4.printHeader()
    # cuifLenna4.show()

    img1 = Image.open('cuif4/lenna4.bmp')
    print("PSNR do CUIF.4 (lenna)",PSNR(imgLenna,img1,8))

    print("THE END")
