function questao_2_2a(A, n)
  converge = true;
  if (A(1, 1) < A(1, 2))
    converge = false;
  endif

  for i = 2 : n
    if (A(i, i) < A(i, i+1) + A(i, i-1))
      converge = false;
      break
    endif
  endfor

  if (A(n, n) < A(n, n-1))
    converge = false;
  endif

  if (converge)
    printf("\nO sistema tem convergência garantida\n");
  else
    printf("\nO sistema não tem convergência garantida\n");
  endif
end
