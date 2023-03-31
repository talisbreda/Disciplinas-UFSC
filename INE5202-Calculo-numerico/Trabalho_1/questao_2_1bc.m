function x = questao_2_1bc(A, n)

  B = A(1:n, n+1);
  A_original = A;

  for k = 1 : n-1
    for i = k+1 : n
      aux = A(i, k) / A(k, k);
      for j = k+1 : n+1
        A(i, j) = A(i, j) - aux * A(k, j);
      endfor
    endfor
  endfor

  x(n, 1) = A(n, n+1) / A(n, n);

  for i = n-1 : -1 : 1
    soma = sum(A(i, i+1:n) * x(i+1:n, 1));
    x(i, 1) = (A(i, n+1) - soma) / A(i, i);
  endfor

  residuo = (A_original(1:n, 1:n)*x) - B;
  operacoes = (4*n^3 + 9*n^2 - n - 6)/6;

  printf("2.1 - b) ")
  printf("Resolver o sistema por método direto e imprimir resultado e resíduo máximo\n")
  printf("\n")
  printf("Solução: ")
  x
  printf("Resíduo máximo: %e\n", max(residuo))

  printf("\n2.1 - c) ")
  printf("Imprimir o número total de operações realizadas\n")

  printf("\nTotal de operações: %d\n", operacoes)
end
