function questao_3b(r, t, d, b, n)
  for i = 2 : n
    aux = t(i) / r(i-1);
    r(i) = r(i) - aux * d(i-1);
		b(i) = b(i) - aux * b(i-1);
  endfor

  x(n) = b(n) / r(n);

	for i = n-1 : -1 : 1
		x(i) = (b(i) - d(i) * x(i+1)) / r(i);
	end
  printf("Solução: ")
  x
end
