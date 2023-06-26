function C = valorC(x, y1, y2, f_y1, f_y2, f_y3, a, b, n, D)
    #Vamos determinar o valor de C (valor da condição inicial desconhecida) a partir
    #da função erro calculada sobre a condição de contorno conhecida D
    #fErro_CC = valor calculado - valor conhecido = y2(n+1) - D
    #fErro_CC é uma função do chute inicial C: f(C) = 0
    
    Ci = 0.2 #Condição inicial y''(x=0) = C = 0.2; Valor chutado
    deltaC = 1;
    contador = 0;
    
    while abs(deltaC) > 1e-10 && contador < 100
        contador = contador + 1
        
        y3(1) = Ci;
        [x, y1, y2, y3] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, n);
        fErro_CC1 = y2(n+1) - D;
        
        y3(1) = Ci + deltaC;
        [x, y1, y2, y3] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, n);
        fErro_CC2 = y2(n+1) - D;
        
        derivada_fErroCC = (fErro_CC2 - fErro_CC1)/deltaC;
        deltaC = -fErro_CC1/derivada_fErroCC
        C = Ci + deltaC
        Ci = C;
    end
    
end