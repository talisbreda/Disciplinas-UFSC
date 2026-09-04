def cabecalho()
{
	print "Integrantes: Carlos Eduardo Vitorino Gomes - 23150560, Eduardo Cunha Cabral - 23150561, Enrico Caliolo - 23150562, Gustavo Gonçalves dos Santos - 20102236, Tális Breda - 22102202";
	print "Programa 3: vetores, busca e controle de fluxo";
	return;
}

def preenche(int tamanho)
{
	int dados[100];
	int i;
	for (i = 0; i < tamanho; i = i + 1)
	{
		dados[i] = i * i;
		print dados[i];
	}
	return;
}

def busca(int alvo, int tamanho)
{
	int dados[100];
	int i;
	int achou;
	achou = 0;
	for (i = 0; i < tamanho; i = i + 1)
	{
		dados[i] = i + i;
	}
	for (i = 0; i < tamanho; i = i + 1)
	{
		if (dados[i] == alvo)
		{
			achou = 1;
			print i;
			break;
		}
	}
	print achou;
	return;
}

def soma_pares(int tamanho)
{
	int soma;
	int i;
	soma = 0;
	for (i = 0; i < tamanho; i = i + 1)
	{
		int resto;
		resto = i % 2;
		if (resto == 0)
		{
			soma = soma + i;
		}
	}
	print soma;
	return;
}

def maior_elemento(int tamanho)
{
	int dados[100];
	int i;
	int maior;
	for (i = 0; i < tamanho; i = i + 1)
	{
		dados[i] = tamanho - i;
	}
	maior = dados[0];
	for (i = 1; i < tamanho; i = i + 1)
	{
		if (dados[i] > maior)
		{
			maior = dados[i];
		}
	}
	print maior;
	return;
}

def aloca_dinamico(int tamanho)
{
	int dados[100];
	int i;
	dados = new int[tamanho];
	for (i = 0; i < tamanho; i = i + 1)
	{
		dados[i] = i;
	}
	print tamanho;
	return;
}

def conta_regressiva(int inicio)
{
	int i;
	for (i = inicio; i > 0; i = i - 1)
	{
		print i;
	}
	print inicio;
	return;
}

def tabuada(int numero)
{
	int i;
	int produto;
	for (i = 1; i <= 10; i = i + 1)
	{
		produto = numero * i;
		print produto;
	}
	return;
}

def matriz_soma(int linhas)
{
	int grade[10][10];
	int i;
	int j;
	int soma;
	soma = 0;
	for (i = 0; i < linhas; i = i + 1)
	{
		for (j = 0; j < linhas; j = j + 1)
		{
			grade[i][j] = i + j;
			soma = soma + grade[i][j];
		}
	}
	print soma;
	return;
}

def principal()
{
	int aux;
	int tamanho;
	int alvo;
	int inicio;
	int numero;
	int linhas;
	aux = cabecalho();
	tamanho = 8;
	aux = preenche(tamanho);
	alvo = 6;
	aux = busca(alvo, tamanho);
	aux = soma_pares(tamanho);
	aux = maior_elemento(tamanho);
	aux = aloca_dinamico(tamanho);
	inicio = 5;
	aux = conta_regressiva(inicio);
	numero = 9;
	aux = tabuada(numero);
	linhas = 4;
	aux = matriz_soma(linhas);
	return;
}
