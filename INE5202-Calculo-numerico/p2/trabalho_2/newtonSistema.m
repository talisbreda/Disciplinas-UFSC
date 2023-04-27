function xfinal = newtonSistema(f1, f2, f3, xi)

    dx = [1; 1; 1];
    contador = 0;

    while max(abs(dx)) > 1e-15 && contador < 1000
        contador = contador + 1;

        A(1, 1) = (f1([xi(1) + dx(1); xi(2)        ; xi(3)        ]) - f1(xi)) / dx(1);
        A(1, 2) = (f1([xi(1)        ; xi(2) + dx(2); xi(3)        ]) - f1(xi)) / dx(2);
        A(1, 3) = (f1([xi(1)        ; xi(2)        ; xi(3) + dx(3)]) - f1(xi)) / dx(3);
        A(2, 1) = (f2([xi(1) + dx(1); xi(2)        ; xi(3)        ]) - f2(xi)) / dx(1);
        A(2, 2) = (f2([xi(1)        ; xi(2) + dx(2); xi(3)        ]) - f2(xi)) / dx(2);
        A(2, 3) = (f2([xi(1)        ; xi(2)        ; xi(3) + dx(3)]) - f2(xi)) / dx(3);
        A(3, 1) = (f3([xi(1) + dx(1); xi(2)        ; xi(3)        ]) - f3(xi)) / dx(1);
        A(3, 2) = (f3([xi(1)        ; xi(2) + dx(2); xi(3)        ]) - f3(xi)) / dx(2);
        A(3, 3) = (f3([xi(1)        ; xi(2)        ; xi(3) + dx(3)]) - f3(xi)) / dx(3);

        B = -[f1(xi); f2(xi); f3(xi)];

        dx = A \ B;

        xfinal = xi + dx;

        xi = xfinal;

        xfinal;
        abs(dx);

    end
    contador

end
