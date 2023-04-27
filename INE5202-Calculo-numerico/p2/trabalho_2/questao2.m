f1 = @(x) sin(x(1)) .* cos(x(2)) + x(3) - 1.5;
f2 = @(x) x(1).^2 + x(2).^2 + x(3).^2 - 3.0;
f3 = @(x) x(1) + x(2) + x(3) - 3.1;

printf("============================\n");
printf("Solução 1: \n");

xi = [complex(1, 1), complex(1, 1), complex(1, 1)];
x = newtonSistema(f1, f2, f3, xi)
residuo_maximo = max(abs([f1(x), f2(x), f3(x)]))



printf("============================\n");
printf("Solução 2: \n")

xi = [complex(2, 2), complex(2, 2), complex(2, 2)];
x = newtonSistema(f1, f2, f3, xi)
residuo_maximo = max(abs([f1(x), f2(x), f3(x)]))
