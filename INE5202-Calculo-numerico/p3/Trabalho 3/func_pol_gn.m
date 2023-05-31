function y_plot = func_pol_gn(n, c, x, x_plot)
  for i = 1 : length(x_plot)
      y_plot(i) = c(1);
      for k = 1 : n
          prod(k) = 1;
          for j = 1 : k
            prod(k) = prod(k) * (x_plot(i) - x(j));
          end
          y_plot(i) = y_plot(i) + c(k+1)*prod(k);
      endfor
  end
end
