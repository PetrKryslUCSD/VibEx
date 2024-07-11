clear all
syms k c m real
M=[3*m,0; 0,m];
K=[5*k,-k; -k, k];
C=[c,0; 0,0];
A=[zeros(2),eye(2); -M\K,-M\C]
syms lam
eq=det(A-lam*eye(4))
solve(eq,lam)
m=1.3; k=22; c=6.2;
solve(eval(eq),lam)
[V,D]=eig(eval(A))
M1=[C,M;M,zeros(2)];
K1=[K,zeros(2);zeros(2),-M];
[V1,D1]=eig(eval(K1),eval(M1))