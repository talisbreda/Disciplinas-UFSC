format long
%Equação de Blasius" da camada limite plana y('x)
%y'''+(1/2)*y*y''=0 x E [0;Inf]
%y''' = -(1/2)*y*y"
%y(x=0)=0
%y'(x=0)=0 e
%y'(x = Inf) = 1 = D
%Considera-se Inf = 10
%PVC: Problema de valor de contorno

#1º passo: vamos criar 3 novas variáveis para representar o y'''
#y1 = y
#y2 = y'
#y3 = y''

#2º passo: derivar as 3 novas variáveis para criar 3 novas equações diferenciais e 1ª ordem
#y1' = y'
#y2' = y''
#y3' = y'''

#3º passo: substituir a variável original y
#y1' = y2
#y2' = y3
#y3' = -(1/2)*y*y'' = -(1/2)*y1*y3

#4º passo: definição das condições iniciais para as novas variáveis
#y1(x = 0) = y(x = 0) = 0
#y2(x = 0) = y'(x = 0) = 0
#y3(x = 0) = y''(x = 0) = C = 0.2  #Valor chutado

f_y1 = @(x,y1,y2,y3) y2;
f_y2 = @(x,y1,y2,y3) y3;
f_y3 = @(x,y1,y2,y3) -(1/2)*y1.*y3;

a = 0; b = 10;
x(1) = 0;
y1(1) = 0;
y2(1) = 0;
D = 1 #Condição de contorno y'(x = 10) = D = 1; Valor conhecido
n = 64 #para erro de y1 menor que 1e-6
C = valorC(x, y1, y2, f_y1, f_y2, f_y3, a, b, n, D);
y3(1) = C;


#Vamos criar uma função Runge-Kutta de 4ª ordem para resolver 3 equações diferenciais de 1ª ordem

[x, y1, y2, y3] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, n);
[x_e, y1_e, y2_e, y3_e] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, 2*n);

erro_estimado_y1 = max(abs(y1 - y1_e(1 : 2 : 2*n+1)))
erro_estimado_y2 = max(abs(y2 - y2_e(1 : 2 : 2*n+1)))
erro_estimado_y3 = max(abs(y3 - y3_e(1 : 2 : 2*n+1)))
erro_CC = y2(n+1) - D #Erro do valor de contorno: Valor calculado - Valor conhecido, para a mesma incógnita
plot(x, y1, "-r", x, y2, "-k", x, y3, "-b"); hold on;
plot(x(1), y1(1), "*r", x(1), y2(1), "s k", x(n+1), y2(n+1), "x k", x(n+1), D, "o k", x(1), y3(1), "d b")
legenda = legend("y1", "y2", "y3");
legend(legenda, "location", "northwest")
grid on