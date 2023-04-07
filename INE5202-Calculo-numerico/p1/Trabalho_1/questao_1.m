function questao_1()

  printf("Armazenar -60.06 em float e em double, e calcular a porcentagem de erro estimado\n\n")

  format long;

  x = -60.06;
  x_float = single(x);
  x_double = x;

  printf("Float: %.20f\n", x_float);
  printf("Double: %.20f\n", x_double);

  erro = ((double(x_float) - x_double) / x_double) * 100;
  printf("Erro percentual: %.20f%%\n", erro)
end
