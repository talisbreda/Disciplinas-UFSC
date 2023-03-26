#1). Faça o armazenamento de  -60.06 em float, nesse link VPL.
# Imprima com 20 dígitos significativos o número decimal acima convertido em
# variável float (single) e double, e calcule o erro estimado de
# arredondamento percentual gerado.

function questao_1()
  format long;

  x = -60.06;
  x_float = single(x);
  x_double = x;

  printf("Float: %.20f\n", x_float);
  printf("Double: %.20f\n", x_double);

  erro = ((x_float - x_double) / x_double) * 100;
  printf("Erro percentual: %.20f%%\n", erro)
end
