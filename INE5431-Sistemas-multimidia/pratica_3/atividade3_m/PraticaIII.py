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
    somatorio = 0
    for i in range(ori.width):
        for j in range(ori.height):
            ori_r, ori_g, ori_b = ori.getpixel((i, j))
            dec_r, dec_g, dec_b = dec.getpixel((i, j))
            #print(somatorio)
            somatorio += ((ori_r - dec_r) + (ori_g - dec_g) + (ori_b - dec_b))**2

    return somatorio/(nsymbols)

if __name__ == "__main__":
    filepath = 'lena.bmp'
    img = Image.open(filepath)
    matriculas = [20201570, 20203081]
    
    # # instancia objeto Cuif, convertendo imagem em CUIF.1
    cuif = Cuif(img,1,matriculas)
    cuif2 = Cuif(img,2,matriculas)

    # # imprime cabeçalho Cuif
    #cuif.printHeader()
    
    # # mostra imagem Cuif
    # cuif.show()
    
    # #gera o arquivo Cuif.1
    cuif.save('lena1.cuif')
    cuif2.save('lena2.cuif')
    # original = Image.open("lena.bmp")
    # decodificada = Cuif.openCUIF("lena1.cuif")
    # decodificada.saveBMP("lena1.bmp")

    # dec_bmp = Image.open("lena1.bmp")

    # ruido = MSE(original, dec_bmp)
    # print(ruido)

    #Abre um arquivo Cuif e gera o objeto Cuif
    cuif1 = Cuif.openCUIF('lena1.cuif')
    cuif2 = Cuif.openCUIF('lena2.cuif')

    # Converte arquivo Cuif em BMP e mostra
    cuif1.saveBMP("lena1.bmp")
    cuif2.saveBMP("lena2.bmp")
    #cuif1.show()
    
    img1 = Image.open("lena1.bmp")
    img2 = Image.open("lena2.bmp")
    print(f"MSE utilizando opção CUIF 1: {MSE(img, img1)}")
    print(f"MSE utilizando opção CUIF 2: {MSE(img, img2)}")


    print(f"PSNR: {PSNR(img, img1, 8)}")
    print(f"PSNR 2: {PSNR(img, img2, 8)}")

    #psnr = PSNR(img, img1, 8)
    #print(f'Cálculo do PSNR: {psnr}')
