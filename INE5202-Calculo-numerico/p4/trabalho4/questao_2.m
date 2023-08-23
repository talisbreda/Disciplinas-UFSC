clear
format long
#Vamos calcular numericamente a integral de 1/(1+x) entre 1 e 6,
# com 6 digitos significativos exatos (erro estimado menor que 1e-6)

#Vamos definir a função integranda f(x)
f = @(x) log(x.^x);
a = 0.1
b = 1
%Integral_exata = (-1/4.*b.*(b + 2.*b.*log(b) - 4.*log(b^b))) - (-1/4.*a.*(a + 2.*a.*log(a) - 4.*log(a^a)))
Integral_exata = -0.235987;

printf("\n1: Método dos Trapézios\n")
# 1)Precisamos definir o número de sub-intervalos onde aplicaremos o
# método dos trapézios
n = 48#número de intervalos

#Vamos definir o resultado da integral
Tn = f_trapezios(n, a, b, f)
erro_exato_Tn = abs(Tn - Integral_exata) #valor aproximado obtido menos
# o valor exato
erro_estimado_Tn = abs(Tn - f_trapezios(2*n, a, b, f))

printf("\n2: Método de Simpson\n")
# 1)Precisamos definir o número de sub-intervalos onde aplicaremos o
# método de Simpson
n = 8 #número de intervalos (obrigatoriamente par -> ajustado na f_simpson)

#Vamos definir o resultado da integral
Sn = f_simpson(n, a, b, f)
erro_exato_Sn = abs(Sn - Integral_exata) #valor aproximado obtido menos
# o valor exato
erro_estimado_Sn = abs(Sn - f_simpson(2*n, a, b, f))

printf("\n3: Método de Gauss-Legendre\n")
# 1)Precisamos definir o número de pontos onde aplicaremos o método de
# Gauss-Legendre
m = 4 # número de pontos

#Vamos definir o resultado da integral
Gm = f_gauss_legendre(m, a, b, f)
erro_exato_Gm = abs(Gm - Integral_exata) #valor aproximado obtido menos
# o valor exato
erro_estimado_Gm = abs(Gm - f_gauss_legendre(m+1, a, b, f))




