function questao_2_2b(A, n)
  printf("\n");
  k = 0; dif = 1;
  x = ones(n, 1);
  f_relax = 0.99;
  ops = 0;
  while dif > 1e-6
    k += 1;
    original = x;
    for i = 1 : n
      principal = A(i, i);
      eq = A(i, n+1);
      for j = 1 : n
        if (i != j && A(i, j) != 0)
          eq += A(i, j) * x(j) *(-1);
          ops += 1;
        endif
      endfor
      x(i) = (1-f_relax)* x(i) + f_relax * eq / principal;
      ops += 1;
    endfor
    dif = max(abs(x - original));
  endwhile

  printf("Solução: ")
  x
  printf("Total de iterações: %d\n", k)
  b = A(1:n, n+1);
  residuo = (A(1:n, 1:n)*x) - b;
  printf("Resíduo máximo: %.6f\n", max(residuo))
  printf("Total de operações: %d\n", ops)
end
