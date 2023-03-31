function questao_3b(t, r, d, b, n)

  printf("3 - b) ")
  printf("Resolver o sistema por método de Gauss otimizado para matriz tridiagonal e imprimir a solução e o resíduo máximo\n")

   t_original = t;
   r_original = r;
   d_original = d;
   b_original = b;

  for i = 2 : n
    aux = t(i) / r(i-1);
    r(i) = r(i) - aux * d(i-1);
		b(i) = b(i) - aux * b(i-1);
  endfor

  x = zeros(n, 1);

  x(n) = b(n) / r(n);

	for i = n-1 : -1 : 1
		x(i) = (b(i) - d(i) * x(i+1)) / r(i);
	end

  residuo(1) = abs(r(1)*x(1) + d_original(1)*x(2) - b_original(1));
  for i = 2: n-1
    residuo(i) = abs(t_original(i)*x(i-1) + r_original(i)*x(i) + d_original(i)*x(i+1) - b_original(i));
  endfor
  residuo(n) = abs(t_original(n)*x(n-1) + r_original(n)*x(n) - b_original(n));

  printf("\nSolução: ")
  x
  printf("Resíduo máximo: %e\n", max(residuo));
end
