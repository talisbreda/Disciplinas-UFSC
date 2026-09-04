def cabecalho()
{
	print "Integrantes: Carlos Eduardo Vitorino Gomes - 23150560, Eduardo Cunha Cabral - 23150561, Enrico Caliolo - 23150562, Gustavo Gonçalves dos Santos - 20102236, Tális Breda - 22102202";
	print "Programa 1: aritmetica e teoria dos numeros";
	return;
}

def quadrado(int valor)
{
	int q;
	q = valor * valor;
	print q;
	return;
}

def cubo(int valor)
{
	int c;
	c = valor * valor * valor;
	print c;
	return;
}

def soma_intervalo(int ini, int fim)
{
	int i;
	int soma;
	soma = 0;
	for (i = ini; i <= fim; i = i + 1)
	{
		soma = soma + i;
	}
	print soma;
	return;
}

def fatorial(int n)
{
	int i;
	int fat;
	fat = 1;
	for (i = 1; i <= n; i = i + 1)
	{
		fat = fat * i;
	}
	print fat;
	return;
}

def potencia(int base, int expoente)
{
	int i;
	int pot;
	pot = 1;
	for (i = 1; i <= expoente; i = i + 1)
	{
		pot = pot * base;
	}
	print pot;
	return;
}

def maximo(int a, int b)
{
	int m;
	if (a > b)
	{
		m = a;
	}
	else
	{
		m = b;
	}
	print m;
	return;
}

def conta_pares(int limite)
{
	int i;
	int pares;
	pares = 0;
	for (i = 0; i < limite; i = i + 1)
	{
		int resto;
		resto = i % 2;
		if (resto == 0)
		{
			pares = pares + 1;
		}
	}
	print pares;
	return;
}

def divisores(int n)
{
	int i;
	int total;
	total = 0;
	for (i = 1; i <= n; i = i + 1)
	{
		int r;
		r = n % i;
		if (r == 0)
		{
			total = total + 1;
		}
	}
	print total;
	return;
}

def soma_vetor(int tamanho)
{
	int vetor[50];
	int i;
	int soma;
	soma = 0;
	for (i = 0; i < tamanho; i = i + 1)
	{
		vetor[i] = i + i;
	}
	for (i = 0; i < tamanho; i = i + 1)
	{
		soma = soma + vetor[i];
	}
	print soma;
	return;
}

def principal()
{
	int aux;
	int n;
	int a;
	int b;
	int ini;
	int fim;
	int base;
	int expoente;
	int limite;
	int tamanho;
	int valor;
	aux = cabecalho();
	valor = 7;
	aux = quadrado(valor);
	aux = cubo(valor);
	ini = 1;
	fim = 10;
	aux = soma_intervalo(ini, fim);
	n = 5;
	aux = fatorial(n);
	base = 2;
	expoente = 8;
	aux = potencia(base, expoente);
	a = 12;
	b = 30;
	aux = maximo(a, b);
	limite = 20;
	aux = conta_pares(limite);
	n = 13;
	aux = divisores(n);
	tamanho = 10;
	aux = soma_vetor(tamanho);
	return;
}
