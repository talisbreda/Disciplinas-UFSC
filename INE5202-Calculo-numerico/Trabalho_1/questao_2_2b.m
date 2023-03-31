function questao_2_2b(A, n1, n2, n3)

  printf("\n");
  printf("2.2 - b) ")
  printf("Resolver o mesmo sistema por um método iterativo e imprimir a solução e o resíduo máximo\n")

  k = 0; dif = 1;
  x = ones(n3, 1);
  f_relax = 1;
  ops = 0;

  eq_relax = (1-f_relax);

  while dif > 1e-6
    k += 1;
    x_original = x;

    i = 1;
    x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i+5) * x(i+5)) / A(i, i);
    ops += 6;

    for i = 2 : n1-1
      x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i-1) * x(i-1) - A(i, i+5) * x(i+5)) / A(i, i);
      ops += 8;
    endfor

    for i = n1 : n2-1
      x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i-4) * x(i-4) - A(i, i+1) * x(i+1)) / A(i, i);
      ops += 8;
    endfor

    i = n2;
    x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i-1) * x(i-1) - A(i, i+4) * x(i+4)) / A(i, i);
    ops += 8;

    for i = n2+1 : n3-1
      x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i-3) * x(i-3) - A(i, i-1) * x(i-1) - A(i, i+1) * x(i+1)) / A(i, i);
      ops += 10;
    endfor

    i = n3;
    x(i) = eq_relax * x(i) + f_relax * (A(i, n3+1) - A(i, i-10) * x(i-10)) / A(i, i);
    ops += 6;

    dif = max(abs(x - x_original));

  endwhile

  printf("\nSolução: ")
  x
  printf("Total de iterações: %d\n", k)
  printf("Fator de relaxamento escolhido: %.2f\n", f_relax)
  B = A(1:n3, n3+1);
  residuo = (A(1:n3, 1:n3)*x) - B;
  printf("Resíduo máximo: %e\n", max(residuo))

  printf("\n2.2 - c) ")
  printf("Imprimir o número total de operações realizadas\n")
  printf("\nTotal de operações: %d\n", ops)
end
