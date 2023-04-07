% exp(x).*sin(x)-1
f = @(x)(exp(x).*sin(x)-1);

a = 0; b = 2.*pi; h = (b-a)./100;

x = a:h:b;
y = f(x);

plot1 = plot(x,y);
waitfor(plot1)