function [t, r, d, b] = questao_3a(n1, n2)

  printf("\n3 - a) ")
  printf("Armazenar o sistema na forma de vetores t, r, d, b (sem imprimir)\n")

  t = zeros(1, n2);
  r = zeros(1, n2);
  d = zeros(1, n2);
  b = zeros(1, n2);

  r(1) = 1;
  d(1) = 1;
  b(1) = -1;

  for i = 2 : n1
    t(i) = 1;
    r(i) = 2;
    d(i) = 1;
    b(i) = 1;
  endfor

  for i = n1+1 : n2-1
    t(i) = 1;
    r(i) = 3;
    d(i) = 1;
    b(i) = 2;
  endfor

  t(n2) = 1;
  r(n2) = 4;
  b(n2) = 3;

end
