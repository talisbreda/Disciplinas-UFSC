function A = questao_2_3(n1, n2)
  A = zeros(n2, n2+1);
  i = 1;

  A(i, i) = 1;
  A(i, i+1) = 1;
  A(i, n2+1) = -1;

  for i = 2 : n1
    A(i, i-1) = 1;
    A(i, i) = 2;
    A(i, i+1) = 1;
    A(i, n2+1) = 1;
  endfor

  for i = n1+1 : n2-1
    A(i, i-1) = 1;
    A(i, i) = 3;
    A(i, i+1) = 1;
    A(i, n2+1) = 2;
  endfor

  i = n2;
  A(i, i-1) = 1;
  A(i, i) = 4;
  A(i, n2+1) = 3;

end

