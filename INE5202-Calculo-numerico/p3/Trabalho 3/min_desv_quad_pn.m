function a = min_desv_quad_pn(n,x,y)

    #Vamos gerar três equações a partir das derivadas do desvio quadrático
    #total em relação aos três parametros da função g(x)
    #D = desvio_quad_total = sum((pn(a,x) - y)²)

    #[m          sum(x) ...      sum(x^n)    ]*[a(1)  ]      [sum(y)       ]
    #[sum(x)     sum(x²) ...     sum(x^(n+1))] [a(2)  ]  =   [sum(x.*y)    ]
    #[       ...     ...     ...     ...     ] [...   ]      [...          ]
    #[sum(x^n)   sum(x^(n+1)) ... sum(x^(2n))] [a(n+1)]      [sum(x^n .* y)]

    for i = 1 : n + 1
        for j = 1 : n + 1
            A(i,j) = sum(x.^(i + j - 2));
        end
        B(i, 1) = sum(x.^(i-1).*y);
    end

    #A
    #B
    a = A\B;

end