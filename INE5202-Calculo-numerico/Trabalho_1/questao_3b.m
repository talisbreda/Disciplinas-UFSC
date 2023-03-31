function questao_3b(t, r, d, b, n)
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

  residuo(1) = abs(r(1)*x(1) + d(1)*x(2) - b(1));
  for i = 2: n-1
    residuo(i) = abs(t(i)*x(i-1) + r(i)*x(i) + d(i)*x(i+1) - b(i));
  endfor
  residuo(n) = abs(t(n)*x(n-1) + r(n)*x(n) - b(n));

  printf("Solução: ")
  x
  printf("Resíduo máximo: %.6f\n", max(residuo));
end
