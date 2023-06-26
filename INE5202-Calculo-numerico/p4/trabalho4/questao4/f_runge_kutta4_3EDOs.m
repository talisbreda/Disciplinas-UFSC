function [x, y1, y2, y3] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, n)
    
    h = (b-a)/n;
    
    for i = 1 : n
        K1_y1 = f_y1(x(i)      ,y1(i)            ,y2(i)            ,y3(i)            ); #K1 é a derivada no início do intervalo de cada h
        K1_y2 = f_y2(x(i)      ,y1(i)            ,y2(i)            ,y3(i)            ); #K1 é a derivada no início do intervalo de cada h
        K1_y3 = f_y3(x(i)      ,y1(i)            ,y2(i)            ,y3(i)            ); #K1 é a derivada no início do intervalo de cada h
        
        K2_y1 = f_y1(x(i)+0.5*h,y1(i)+0.5*h*K1_y1,y2(i)+0.5*h*K1_y2,y3(i)+0.5*h*K1_y3); #K2 é a derivada no meio do intervalo de cada h
        K2_y2 = f_y2(x(i)+0.5*h,y1(i)+0.5*h*K1_y1,y2(i)+0.5*h*K1_y2,y3(i)+0.5*h*K1_y3); #K2 é a derivada no meio do intervalo de cada h
        K2_y3 = f_y3(x(i)+0.5*h,y1(i)+0.5*h*K1_y1,y2(i)+0.5*h*K1_y2,y3(i)+0.5*h*K1_y3); #K2 é a derivada no meio do intervalo de cada h

        K3_y1 = f_y1(x(i)+0.5*h,y1(i)+0.5*h*K2_y1,y2(i)+0.5*h*K2_y2,y3(i)+0.5*h*K2_y3); #K3 é a derivada no meio do intervalo de cada h com o K2
        K3_y2 = f_y2(x(i)+0.5*h,y1(i)+0.5*h*K2_y1,y2(i)+0.5*h*K2_y2,y3(i)+0.5*h*K2_y3); #K3 é a derivada no meio do intervalo de cada h com o K2
        K3_y3 = f_y3(x(i)+0.5*h,y1(i)+0.5*h*K2_y1,y2(i)+0.5*h*K2_y2,y3(i)+0.5*h*K2_y3); #K3 é a derivada no meio do intervalo de cada h com o K2
        
        K4_y1 = f_y1(x(i)+    h,y1(i)+    h*K3_y1,y2(i)+    h*K3_y2,y3(i)+    h*K3_y3); #K4 é a derivada no final do intervalo de cada h com o K3
        K4_y2 = f_y2(x(i)+    h,y1(i)+    h*K3_y1,y2(i)+    h*K3_y2,y3(i)+    h*K3_y3); #K4 é a derivada no final do intervalo de cada h com o K3
        K4_y3 = f_y3(x(i)+    h,y1(i)+    h*K3_y1,y2(i)+    h*K3_y2,y3(i)+    h*K3_y3); #K4 é a derivada no final do intervalo de cada h com o K3

        K_medio_y1 = (K1_y1 + 2*(K2_y1 + K3_y1) + K4_y1)/6;
        K_medio_y2 = (K1_y2 + 2*(K2_y2 + K3_y2) + K4_y2)/6;
        K_medio_y3 = (K1_y3 + 2*(K2_y3 + K3_y3) + K4_y3)/6;
        
        x(i+1) = x(i) + h;
        y1(i+1) = y1(i) + K_medio_y1*h;
        y2(i+1) = y2(i) + K_medio_y2*h;
        y3(i+1) = y3(i) + K_medio_y3*h;
    end
    
    
end