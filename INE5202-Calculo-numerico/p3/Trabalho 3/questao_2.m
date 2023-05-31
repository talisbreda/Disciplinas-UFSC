#Dados
x = [ 1.2,   1.5,   2,     4,     6,     10,   15, ]
y = [ 0.45, 0.40, 0.33, 0.20, 0.14, 0.10, 0.06 ]

#plot(x,y, "*r")
#grid on

#1 Representar por qual g(x)? -> genérica não-linear'
#g(x) = c(1) / (c(2) + c(3)*x)

g = @(c,x) c(1) / (c(2) + c(3)*x);

c = min_desv_quad_g(x,y);

x_plot = [min(x) : 0.1 : max(x)];
y_calculado_g = g(c,x_plot);

aux = g(c,x) - y;
desvio_quad_total_g = sum(aux.*aux)


#2 Representar por Pn(x) -> polinômio com coeficientes lineares de grau n'
# Pn(x) = a(1) + a(2)*x + ... + a(n+1)*x^n

# Pn = @(c,x) c(1) + c(2)*x.^(-c(3));

n = 6
a = min_desv_quad_pn(n,x,y);

y_calculado_pn = valor_pn(a, x_plot);

aux = valor_pn(a, x) - y;
desvio_quad_total_pn = sum(aux.*aux)

plot(x,y, "*r", x_plot, y_calculado_g, "-b", x_plot, y_calculado_pn, "-k")
grid on
