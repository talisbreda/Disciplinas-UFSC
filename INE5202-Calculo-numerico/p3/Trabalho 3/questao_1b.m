format long

f = @(x) x.*sin(x);
a = 0;
b = pi/2;
n = 3
h = (b - a)/n;
x = [a : h : b];
y = f(x);
c = coeficientes_greg_nwtn(n, x, f)
#c = [-2.302585092994045; 2.558427881104495; -1.02514272060278] #Valor para n = 2

x_plot = [a : h/10 : b];
y_plot = func_pol_gn(n, c, x, x_plot);

y_exato = f(x_plot);

erro_local = abs(y_plot - y_exato);

[erro_max, pos_erro] = max(abs(y_plot - y_exato))
subplot(3, 2, 2)

plot(x, y, "* r", x_plot, y_plot, "- b", x_plot, y_exato, "- k");
title("Questão 1 - b)")

