function questao_2_2a(A, n)

  printf("\n2.2 - a) ")
  printf("Demonstrar que o sistema tem convergência garantida por métodos iterativos\n")
  printf("\nDe acordo com os testes realizados, ")

  converge = true;
  maior = false; # Já que a diagonal principal deve ser maior que a soma dos vizinhos em pelo menos uma linha

  if (A(1, 1) < A(1, 2))
    converge = false;
  endif

  for i = 2 : n
    if (A(i, i) < A(i, i+1) + A(i, i-1))
      converge = false;
      break
    endif
    if (!maior && A(i, i) > A(i, i+1) + A(i, i-1))
      maior = true;
    endif
  endfor

  if (A(n, n) < A(n, n-1))
    converge = false;
  endif

  if (maior && converge)
    printf("o sistema tem convergência garantida\n");
  else
    printf("o sistema não tem convergência garantida\n");
  endif
end
