#Resolução de sistema de equações lineares pelo método de eliminação gaussiana

A = [2  3  4;
     1 -1  1;
     3 -3 -1]
B = [9; 1;-1]

#X = inv(A)*B

X = met_gauss(A,B)
Xe=[ 1; 1; 1]
Erro_X = max(X - Xe) # Erro da solução X, entre o valor obtido e o valor exato (normalmente indisponivel)
Residuo_eq = max((A*X)-B) # Residuo das equações
