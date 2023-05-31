%ponto 1: ponto de partida
%ponto 2: ponto que indica a direção da curva na partida
%ponto 3: ponto que indica a direção da curva na chegada
%ponto 4: ponto de chegada da curva
clear
%figura 1
m=4 %numero de pontos de 6 figuras:
%x=[0 4  4  0];y=[0 0 4  4]; %parabola horizontal
%x=[4 4  0  0];y=[0 9 9  0]; %parabola vertical
%x=[0 5  6  1];y=[3 6 0 -3]; %parabola inclinada
%x=[0 2  2  3];y=[3 1 5 -3]; %parabola distorcida
%x=[0 5  0  5];y=[0 5  5  0]; %cuspide
x=[0 1 -1  0];y=[0 -1 -1 0]; %Gota

numpasso=1000
h=1/numpasso %Espaçamento do parametro t
t=0
cx=3*(x(2)-x(1));bx=3*(x(3)-x(2))-cx;ax=(x(4)-x(1))-(cx+bx);
cy=3*(y(2)-y(1));by=3*(y(3)-y(2))-cy;ay=(y(4)-y(1))-(cy+by);
xmax=0;ymax=0;
for i=1:numpasso+1
   xx(i)=x(1)+t*(cx+t*(bx+t*ax));
   yy(i)=y(1)+t*(cy+t*(by+t*ay));
   t=t+h;
end%for
%figura 2 -> repetir linhas 14 a 26 para novos 4 pontos

plot(x,y,'*k',x,y,'--g','linewidth',1,xx,yy,'-b','linewidth',10,  0,-1.2)
grid on