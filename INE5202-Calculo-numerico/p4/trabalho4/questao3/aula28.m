#Exemplo do livro: 9.1
#Busca solução numérica com erro menor que 1e-6

format long

#y' = x - y + 2
f = @(x,y) x - y + 2
f_exato = @(x) (x + 1) + exp(-x);
x_inicial = 0;
y_inicial = 2;

a = 0; b = 1;

printf("Método de Euler\n\n")  #Baseado na série de Taylor de grau 1

n = 2^16

[x, y] = f_euler(x_inicial, y_inicial, f, a, b, n);

y_exato = f_exato(x);
[x_exato_estimado, y_exato_estimado] = f_euler(x_inicial, y_inicial, f, a, b, 2*n);
[erro_max_exato, pos_erro_exato] = max(abs(y-y_exato)) #Erro máximo exato
[erro_max_estimado, pos_erro_estimado] = max(abs(y - y_exato_estimado(1 : 2 : 2*n + 1))) #Erro máximo estimado

plot(x, y, "-r", x, y_exato, "-b")
grid on

printf("\nRunge-Kutta de 4ª ordem\n\n") 

n = 8

[x4, y4] = f_runge_kutta4(x_inicial, y_inicial, f, a, b, n);

y_exato4 = f_exato(x4);
[x_exato_estimado4, y_exato_estimado4] = f_runge_kutta4(x_inicial, y_inicial, f, a, b, 2*n);
[erro_max_exato4, pos_erro_exato4] = max(abs(y4-y_exato4)) #Erro máximo exato
[erro_max_estimado4, pos_erro_estimado4] = max(abs(y4 - y_exato_estimado4(1 : 2 : 2*n + 1))) #Erro máximo estimado

plot(x, y, "-r", x4, y4, "-g", x, y_exato, "-b")
legenda = legend("euler", "runge kutta4", "exato");
legend(legenda, "location", "northwest")
grid on