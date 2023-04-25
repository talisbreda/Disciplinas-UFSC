%{
    - Equações não lineares
        Exemplo 1: f = exp(x) * sin(x) - 1 = 0

    Dividiremos o processo de determinação de raízes zeros
    em duas etapas:
        - Localizar possíveis soluções
        - Refinar até a precisão desejada

    Localizando:
        - Se forem raízes reais, podemos utilizar o gráfico
        - Fazendo
            sen(x) = 1/exp(x)
        podemos procurar as intersecções destes gráficos e
        aproximar o resultado a partir de pontos conhecidos
        (i. e. x de 0 a 2pi ao passo pi/4)

        - Troca de sinal em funções contínuas também indica raíz real
        (teorema do valor intermediário)

        - Pelo gŕafico, podemos encontrar
            xi = [0.7, 3.0]
        como pontos próximos à raiz para x no intervalo [0, pi]

    Refinando: (Método de Newton-Raphson)
        
        - A ideia é simplificar a função original f usando
        séries de Taylor:
            - sen(x) = a0 + a1 dx + a2 dx² + ...
        onde
            dx = x - xi
        
        - Para x = x1, f = a0

        - Para f' = 0 + a1 + 2*a2*(x-xi) + 3*a3*(x-xi)² ...
        => (x = x1 => f' = a1)

        - Para f'' = 0 + 0 + 2*a2 + 6*a3*(x - xi) ...
        => (x = x1 => f'' = 2a2 => a2 = f''/2)

        - Assim,
            f(x) = f(xi) + f'(xi)(x - xi) + f''(xi)(x - xi)/2 + ...
        ou
            f(x) = {SUM n=0 inf} f^(n) (xi)*[(x - xi)^n]/n!
        
        - Podemos então achar uma g aproximada de f para xi proximo de x
            f(x) = 0
        ou
            f(xi) + f'(xi)(x - xi) = 0
        =>  dx = -f/f'
        =>  x = xi + dx

        para encontrar uma raíz aproximada refinada para as raízes da f
        original.
%}

function R = newton_raphson(f, A, B)

    # Localizar possíveis soluções
    
    # Define quantidade de pontos do intervalo
    step = 200; 
    h = (B-A)/step; 
    
    # Define os intervalos
    X = A : h : B;
    Y = f(X);
    
    # Visualizando
    
    plot(X, Y, "-r");
    grid on
    
    axis([A B -10 10]);
    limits = axis ();
    
    # Indexar o vetor de raízes
    contador_raiz = 0;
    
    for i = 1 : step
        if Y(i) * Y(i+1) <= 0 && abs(Y(i)) + abs(Y(i+1)) < 1 
            # Houve troca de sinal e os valores de Y
            # não são muito grandes (ex. descontinuidade)
            contador_raiz++; # contador_raiz = contador_raiz + 1
            Xi(contador_raiz) = 0.5*(X(i) + X(i+1));
        end
    end

    Xi
    
    # Refinar até a precisão desejada
    
    # Calculando df (f') numericamente
    
    for indice = 1 : contador_raiz # Raizes

        # Xi(indice) Valor inicial
    
        # Para f = exp(x) .* sin(x) - 1
        # df = @(x) exp(x) .* sin(x) .+ exp(x) .* cos(x);
        dx = 1e-5;
    
        contador_reps = 0;
        indice = indice;
        
        while abs(dx) > 1e-10 && contador_reps < 1000
            
            # Para caso haja divergência, contar
            # as repetições
            contador_reps = contador_reps + 1;
            
            # Pela série de taylor simplificada 
            
            # Obtendo uma derivada numérica
            # Pela definição de limite, com dx pequeno
            num_df = (f(Xi(indice) + dx) - f(Xi(indice)))/dx;
            
            dx = -f(Xi(indice)) / num_df; 
        
            Xf(indice) = Xi(indice) + dx;
            
            Xi(indice) = Xf(indice);
            
            Xf(indice);
            # printf("\n");
            
        end
    
    end
    
    R = Xf;

end
