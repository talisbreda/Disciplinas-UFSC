format long

#f = @(x) (exp(x) .* sin(x) - 1);
#a = 0; # rad 
#b = 2*pi; # rad

f = @(x) (sin(x).^3 .* cos(x).^3 + 0.1); # Funçao com descontinuidades 
a = 0; # rad 
b = 2*pi; # rad

R = newton_raphson(f, a, b); #Calcula raizes Reais dentro do intervalo [A, B]

R;
res = f(R)
