x = [0 : pi/1000 : pi/2];
xi = pi/4;
y = taylor(x);

f = @(xp) xp.*sin(xp);
y_exato = f(x);

[erro_max, pos_max] = max(abs(y - y_exato))

subplot(3, 2, 1)

plot(x, y, "- r", x, y_exato, "- b", xi, taylor(xi), "* k");
title("Questão 1 - a)")
grid on
