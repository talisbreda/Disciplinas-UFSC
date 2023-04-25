% x^4 - 2*i x^3 - 1.5 x^2 + (0.5*i) x + 0.0625
a = [1, -2*i, -1.5, (0.5*i), 0.0625];
[x, M] = roots_aula(a)

R = valorPolinomio(a, x)
