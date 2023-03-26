#3x1 - x2 - x3 = 1
#x1 + 3x2 + x3 = 5
#x1 - x2 + 2x3 = 2

#x1 = (1 + x2 + x3)/3
#x2 = (5 - x1 - x3)/3
#x3 = (2 - x1 + x2)/2
#format long

x = [0; 0; 0]
x_exato = [1; 1; 1];

i = 0; dif = 1;
f_relax = 0.85
while dif > 1e-6
i = i+1
aux = x;
#x(1) = (1 + x(2) + x(3))/3;
#x(2) = (5 - x(1) - x(3))/3;
#x(3) = (2 - x(1) + x(2))/2;
x(1) = (1-f_relax)*x(1) + f_relax*((1 + x(2) + x(3))/3);
x(2) = (1-f_relax)*x(2) + f_relax*((5 - x(1) - x(3))/3);
x(3) = (1-f_relax)*x(3) + f_relax*((2 - x(1) + x(2))/2);
x
dif = max(abs(x - aux))
end

printf("\nUtilizamos fator de relaxação de 0.85 e reduzimos o número de iterações de 29 para 10. O erro da solução é da ordem de grandeza entre a última e a penúltima operação\n")