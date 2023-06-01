function y = taylor(x)
    % Série de Taylor
    % f(x) = x*sen(x)       0 < x < pi/2

    % primeiro passo
    % primeira derivada
    % f'1(x) =       senx     + x*cos(x)
    % f'2(x) =       2*cos(x) - x*sen(x)
    % f'3(x) =      -3*sen(x) - x*cos(x)
    % f'4(x) =      -4*cos(x) + x*sen(x)

    % c(1) = f(x) / 1!
    % c(2) = f'1(x) / 2!
    % c(3) = f'2(x) / 3!
    % c(4) = f'3(x) / 4!
    % c(5) = f'4(x) / 5!

    xi = pi/4;
    n = 5

    c(1) = (xi * sin(xi));
    c(2) = (sin(xi) + xi*cos(xi)) / 1;
    c(3) = (2*cos(xi) - xi*sin(xi)) / 2;
    c(4) = (-3*sin(xi) - xi*cos(xi)) / 6;
    c(5) = (-4*cos(xi) + xi*sin(xi)) / 24;
    c(6) = (  5*sin(xi) + xi*cos(xi)) / 120;

    for k = 1 : length(x)

        y(k) = c(1);
        aux = 1;

        for i = 2 : n+1
            aux = aux .*(x(k)-xi);
            y(k) = y(k) + c(i) .* aux;
        end
    end

    c

end
