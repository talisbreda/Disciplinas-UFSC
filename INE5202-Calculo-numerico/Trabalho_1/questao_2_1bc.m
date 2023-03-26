function x = questao_2_1bc(A, n)
  ops = 0;
  B = A(1:n, n+1);
  A_original = A;

  for k = 1 : n-1
    for i = k+1 : n
      aux = A(i, k) / A(k, k);
      ops += 1;
      for j = k+1 : n+1
        A(i, j) = A(i, j) - aux * A(k, j);
        ops += 1;
      endfor
    endfor
  endfor

  x(n, 1) = A(n, n+1) / A(n, n);

  for i = n-1 : -1 : 1
    soma = sum(A(i, i+1:n) * x(i+1:n, 1));
    x(i, 1) = (A(i, n+1) - soma) / A(i, i);
  endfor


  residuo = (A_original(1:n, 1:n)*x) - B;

  printf("\n")
  printf("Solução: ")
  x
  printf("Resíduo máximo: %.6f\n", max(residuo))
  printf("Total de operações: %d\n", ops)
end
