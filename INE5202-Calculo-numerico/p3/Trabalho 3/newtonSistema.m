function Xf = newtonSistema(f1, f2, f3, Xi,x,y)

    dx = [1e-5; 1e-5; 1e-5];
    contador_reps = 0;

    while max(abs(dx)) > 1e-10 && contador_reps < 1000

        contador_reps = contador_reps + 1;

        A(1, 1) = (f1([Xi(1) + dx(1); Xi(2)        ;Xi(3)        ],x,y) - f1(Xi,x,y)) / dx(1);
        A(1, 2) = (f1([Xi(1)        ; Xi(2) + dx(2);Xi(3)        ],x,y) - f1(Xi,x,y)) / dx(2);
        A(1, 3) = (f1([Xi(1)        ; Xi(2)        ;Xi(3) + dx(3)],x,y) - f1(Xi,x,y)) / dx(3);
        A(2, 1) = (f2([Xi(1) + dx(1); Xi(2)        ;Xi(3)        ],x,y) - f2(Xi,x,y)) / dx(1);
        A(2, 2) = (f2([Xi(1)        ; Xi(2) + dx(2);Xi(3)        ],x,y) - f2(Xi,x,y)) / dx(2);
        A(2, 3) = (f2([Xi(1)        ; Xi(2)        ;Xi(3) + dx(3)],x,y) - f2(Xi,x,y)) / dx(3);
        A(3, 1) = (f3([Xi(1) + dx(1); Xi(2)        ;Xi(3)        ],x,y) - f3(Xi,x,y)) / dx(1);
        A(3, 2) = (f3([Xi(1)        ; Xi(2) + dx(2);Xi(3)        ],x,y) - f3(Xi,x,y)) / dx(2);
        A(3, 3) = (f3([Xi(1)        ; Xi(2)        ;Xi(3) + dx(3)],x,y) - f3(Xi,x,y)) / dx(3);

        B = -[f1(Xi,x,y); f2(Xi,x,y); f3(Xi,x,y)];

        dx = A \ B;

        Xf = Xi + dx;

        Xi = Xf;

    end
    #contador_reps
    #dx
    #residuomax = max(abs([f1(Xf, x,y), f2(Xf, x,y),f3(Xf, x,y)]))
end
