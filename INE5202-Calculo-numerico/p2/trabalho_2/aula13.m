format long

# vamos determinar todas as raízes de um polinômio de grau n: reais, complexas, simples, múltiplas, etc...
# Pn(x) = a(1)x^n + a(2)x^(n-1) + ... + a(n)x^1 + a(n+1) = 0
# teremos n raízes


% ' primeiro polinômio '
% ' P3(x) = x³-2*x²-3*x+5 '
% a = [1, -2, -3, 5] # coeficientes da equação

% x_octave = roots(a)
% [x, M] = roots_aula(a)
% residuos = valorPolinomio(a, x)

' primeiro polinômio exemplo 3.24'
' P3(x) = x³-3*x²+3*x-1 '
a = [1, -3, 3, -1] # raiz unitária, Multiplicidade 3 (para testar o nosso algoritmo)

x_octave = roots(a)
[x, M] = roots_aula(a)
residuos = valorPolinomio(a, x)

printf('\n\n\n');
' segundo polinômio '
' P3(x) = x³-2*x²-3*x+5 '
a = [1, -2, -3, 5] # coeficientes da equação

x_octave = roots(a)
[x, M] = roots_aula(a)
residuos = valorPolinomio(a, x)