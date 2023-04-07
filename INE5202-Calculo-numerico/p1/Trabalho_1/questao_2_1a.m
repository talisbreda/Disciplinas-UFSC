function A = questao_2_1a(n1, n2, n3)

  printf("2.1 - a) ")
  printf("Armazenar o sistema da questão 2 em forma de matriz completa (sem imprimir)\n")

  i = 1;
  A = zeros(n3, n3);

  A(i, i) = 3;
  A(i, i+5) = 2;
  A(i, n3+1) = 2;

  for i = 2 : n1-1
    A(i, i-1) = 1;
    A(i, i) = 3;
    A(i, i+5) = 2;
    A(i, n3+1) = -2;
  endfor

  for i = n1 : n2-1
    A(i, i-4) = 2;
    A(i, i) = 4;
    A(i, i+1) = 1;
    A(i, n3+1) = 3;
  endfor

  i = n2;
  A(i, i-1) = 1;
  A(i, i) = 6;
  A(i, i+4) = -1;
  A(i, n3+1) = -2;

  for i = n2+1 : n3-1
    A(i, i-3) = 1;
    A(i, i-1) = 1;
    A(i, i) = 7;
    A(i, i+1) = 2;
    A(i, n3+1) = 5;
  endfor

  i = n3;
  A(i, i-10) = 2;
  A(i,  i) = 5;
  A(i, n3+1) = -5;
end

