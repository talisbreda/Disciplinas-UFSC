function X = met_gauss(A,B)
  #Triangularização
  A = [A B];
  n = size(A,1);

  for k = 1 : n -1
    k
#Neste ponto, é necessário escolher a melhor linha k, para seguir com a eliminação.
#A melhor linha será aquela que tem o maior valor possível na sua diagonal principal.
#Por consequência, vai acumular menos erros de arredondamento
A
      [A_max, pos_A_max]  = max(abs(A(k:n,k))) #maior valor em módulo dentro os elementos da coluna k, da daigoanl p baixo.
      LK = A(k,:); #Valor preservado da linha original
      linha_pos_A_max=pos_A_max + k-1
     #L3 = A(linha_pos_A_max,:);
      A(k,:) = A(linha_pos_A_max,:);
      A(linha_pos_A_max,:) = LK;
      A
      for i = k+1 : n
        aux = A(i,k)/A(k,k); A(i,k) = 0;
        for j = k+1 : n+1
          A(i,j) = A(i,j) - aux*A(k,j);
        endfor
      endfor
      A
  endfor
  

  #Retrossubstituição
  X(n,1) = A(n, n+1)/A(n,n);
  for i = n-1 : -1 : 1
    soma = sum(A(i, i+1:n)*X(i+1:n,1));
    X(i,1) = (A(i, n+1) - soma)/A(i,i);
  endfor
end