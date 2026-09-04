def cabecalho()
{
	print "Integrantes: Carlos Eduardo Vitorino Gomes - 23150560, Eduardo Cunha Cabral - 23150561, Enrico Caliolo - 23150562, Gustavo Gonçalves dos Santos - 20102236, Tális Breda - 22102202";
	print "Programa 2: calculos com ponto flutuante";
	return;
}

def media2(float fa, float fb)
{
	float media;
	media = fa + fb;
	media = media / 2.0;
	print media;
	return;
}

def media3(float fa, float fb, float fc)
{
	float soma;
	float media;
	soma = fa + fb;
	soma = soma + fc;
	media = soma / 3.0;
	print media;
	return;
}

def converte_celsius(float celsius)
{
	float fahrenheit;
	fahrenheit = celsius * 1.8;
	fahrenheit = fahrenheit + 32.0;
	print fahrenheit;
	return;
}

def juros_simples(float capital, float taxa, float tempo)
{
	float juros;
	float montante;
	juros = capital * taxa;
	juros = juros * tempo;
	montante = capital + juros;
	print montante;
	return;
}

def area_retangulo(float largura, float altura)
{
	float area;
	area = largura * altura;
	print area;
	return;
}

def area_circulo(float raio)
{
	float pi;
	float area;
	pi = 3.14159;
	area = pi * raio;
	area = area * raio;
	print area;
	return;
}

def desconto(float preco, float percentual)
{
	float valor;
	float liquido;
	valor = preco * percentual;
	liquido = preco - valor;
	print liquido;
	return;
}

def acumula(int n)
{
	float acumulado;
	float incremento;
	int i;
	acumulado = 0.0;
	incremento = 1.5;
	for (i = 0; i < n; i = i + 1)
	{
		acumulado = acumulado + incremento;
	}
	print acumulado;
	return;
}

def maior_float(float fx, float fy)
{
	float maior;
	if (fx > fy)
	{
		maior = fx;
	}
	else
	{
		maior = fy;
	}
	print maior;
	return;
}

def principal()
{
	int aux;
	int n;
	float fa;
	float fb;
	float fc;
	float celsius;
	float capital;
	float taxa;
	float tempo;
	float largura;
	float altura;
	float raio;
	float preco;
	float percentual;
	float fx;
	float fy;
	aux = cabecalho();
	fa = 8.5;
	fb = 9.0;
	fc = 7.5;
	aux = media2(fa, fb);
	aux = media3(fa, fb, fc);
	celsius = 25.0;
	aux = converte_celsius(celsius);
	capital = 1000.0;
	taxa = 0.05;
	tempo = 12.0;
	aux = juros_simples(capital, taxa, tempo);
	largura = 4.0;
	altura = 3.0;
	aux = area_retangulo(largura, altura);
	raio = 2.0;
	aux = area_circulo(raio);
	preco = 250.0;
	percentual = 0.1;
	aux = desconto(preco, percentual);
	n = 10;
	aux = acumula(n);
	fx = 3.3;
	fy = 9.9;
	aux = maior_float(fx, fy);
	return;
}
