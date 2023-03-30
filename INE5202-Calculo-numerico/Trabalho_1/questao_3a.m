function [t, r, d, b] = questao_3a(n1, n2)
  t = zeros(1, n2); r = t; d = t; b = t;
  t(1) = 1;
  r(1) = 1;
  b(1) = -1;

  for i = 2 : n1
    d(i) = 1;
    t(i) = 2;
    r(i) = 1;
    b(i) = 1;
  endfor

  for i = n1+1 : n2-1
    d(i) = 1;
    t(i) = 3;
    r(i) = 1;
    b(i) = 2;
  endfor

  d(n2) = 1;
  t(n2) = 4;
  b(n2) = 3;

end
