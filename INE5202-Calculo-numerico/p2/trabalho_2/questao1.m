pn = @(x) [sin(x)*cos(x), 0, 0, 0.1];
dpn = @(x) diff(pn(x))
dpn(1)
deltax = @(pn, pnd) - pn ./ pnd;

prev_x = 0;
x = 7.0686;
dx = 1;

while prev_x != x
  xi = x;
  pnxi = pn(xi);
  pndxi = dpn(xi);
  dx = deltax(pnxi, pndxi);
  prev_x = x;
  x = dx + xi;
endwhile

dx
pnxi
pndxi
x