function c = coeficientes_greg_nwtn(n, x, f)
  y = f(x);

  for i = 1 : n
     dif_div(i,1) = (y(i+1) - y(i))/(x(i+1) - x(i));
  end #for

  #for i = 1 : n-1 #n + 1 - 2 = n - 1
  #   dif_div(i,2) = (dif_div(i+1,1) - dif_div(i,1))/(x(i+2) - x(i));
  #end #for


  for k = 2 : n
      for i = 1 : n + 1 - k
          dif_div(i,k) = (dif_div(i+1,k-1) - dif_div(i,k-1))/(x(i+k) - x(i));
      end #for
  end #for
      c = [y(1) dif_div(1,1:n)];

      #c = [-2.302585092994045; 2.558427881104495; -1.02514272060278]
      #plot(x,y, '* r')
      #grid on
end #function
