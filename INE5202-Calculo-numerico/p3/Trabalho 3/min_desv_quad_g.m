function c = min_desv_quad_g(x,y)
    #Vamos gerar três equações a partir das derivadas do desvio quadrático
    #total em relação aos três parametros da função g(x)
    #g = @(c,x) c(1) + c(2)*x.^(-c(3));
    #D = desvio_quad_total = sum((g(c,x) - y)²)

    #Derivada do D em relação ao c(1)
    #dD/dc1 = sum[2*(g(c,x)-y)*1]
    #Derivada do D em relação ao c(2)
    #dD/dc2 = sum[2*(g(c,x)-y)*(x^(-c(3)))]
    #Derivada do D em relação ao c(3)
    #dD/dc3 = sum[2*(g(c,x)-y)*(c(2)*x^(-c(3))*ln(x))]

    g = @(c,x) c(1) ./ (c(2) + c(3)*x);

    f1 = @(c,x,y) sum((g(c,x)-y)./ (c(2)+c(3).*x));
    f2 = @(c,x,y) sum((g(c,x)-y)./ ((c(2) + c(3).*x).*(c(2) + c(3).*x)));
    f3 = @(c,x,y) sum((g(c,x)-y).* x ./ ((c(2) + c(3).*x).*(c(2) + c(3).*x)));

    c_inicial = [1;1;1]; #É um valor inicial que precisa ser refinado

    c = newtonSistema(f1, f2, f3, c_inicial,x,y)

end
