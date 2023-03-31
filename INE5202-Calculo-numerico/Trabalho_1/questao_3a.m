function [t, r, d, b] = questao_3a(n1, n2)

%   for i=1;                         #         x(i)+x(i+1)  = -1.00;
% for i=2:n1                    #x(i-1)+2x(i)+x(i+1) = 1.00;
% for i=n1+1:n2-1          # x(i-1)+3x(i)+x(i+1) = 2.00;
% for i=n2;                     #  x(i-1)+4x(i)            = 3.00; 

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
