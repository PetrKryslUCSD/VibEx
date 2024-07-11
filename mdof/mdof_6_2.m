
%% 
% Calculation of the  mass-normalized modes
syms m k real

K= [5*k,-k;-k,k];;
M = [3*m,0; 0,m];
[V,D] =eig(double(K/k),double(M/m));
format  compact
% Eigenvector and eigenvalue solution of the numerical problem
V,D
% The  natural frequencies are
Om = sqrt(diag(D)*k/m)
% Now we are going to calculate  mass-normalized  modes
P=V/diag(sqrt(abs(diag(V'*M*V))))
% Here is the check:  we should get an identity matrix back (and we do)
P'*M*P


%% 
% Here are some initial conditions
U0  =[1;1];
dUdt0= [0;0];
% We are going to calculate the constants Dj, Ej using formula 6.26b
Dhat=P'*M*U0
Ehat=diag(Om)\P'*M*dUdt0

%% 
% Introduce some numbers
k=20; m=5;
Om=eval(Om); 
P=eval(P); 
Dhat=eval(Dhat); 
Ehat=eval(Ehat); 
% The periods of  free vibration are
Tn =2*pi./Om
% So the time step should be at most  about a 20th of the shortest period
dt=min(Tn/20);
% So the solution to the free vibration is
% tspan=  [0,5*max(Tn)];
tspan=  [0,30];
t=linspace(tspan(1),tspan(2),abs(diff(tspan))/dt);
u=Dhat(1)*P(:,1)*cos(Om(1)*t)+Dhat(2)*P(:,2)*cos(Om(2)*t)...
    +Ehat(1)*P(:,1)*sin(Om(1)*t)+Ehat(2)*P(:,2)*sin(Om(2)*t);
% Plot  the solution in terms of the  original variables.  Compare with
% Figure 6.2
plot(t,u); 
grid on; set(gca,'linewidth',2);
xlabel('Time'); ylabel('Solution components');


%% 
% Find the initial values of the normal coordinates
y0 = P'*M*U0;
dydt0 = diag(Om)\P'*M*dUdt0;


%% 
% Plot the solution in terms of the normal coordinates
y0=eval(y0); dydt0=eval(dydt0);
clear y; 
y=[y0(1)*cos(Om(1)*t)+dydt0(1)*sin(Om(1)*t);
   y0(2)*cos(Om(2)*t)+dydt0(2)*sin(Om(2)*t)];
figure;
plot(t,y); 
grid on; set(gca,'linewidth',2);
xlabel('Time'); ylabel('Normal coordinates');


%% 
% Reconstruct  the solution in the original coordinates
ur = 0*y;% preallocate size
for j=1:size(y, 2)
    ur(:,j) =P*y(:,j);
end 
figure;
plot(t,ur); 
grid on; set(gca,'linewidth',2);
xlabel('Time'); ylabel('Reconstructed solution');
% %%
%
% syms m k real
%
% K= [5*k,-k;-k,k];;
% M = [3*m,0; 0,m];
%
% [V,D] =eig(M\K);
% ix=[2,1];
% V=V(:,ix); D=D(ix,ix);
% format  compact
% V,D
% V\eye(2)
%
% V\M*V*D-V\K*V
%
% V =[
% [ 1, 1]
% [ 3,  -1]]
% % K=double(subs(K/k)),M=double(subs(M/m));
% % [V,D] =eig(K,M);
% % V,D
% % V\eye(2)
% % V'*M*V*D-V'*K*V
%
%
% syms y1 y2 real
% syms x1 x2 real
% syms m k real
% y=V\[x1;x2]
% x=V*[y1;0]
% -(k/m)*D(1,1)*m*M*x+k*K*x
% x=V*[0;y2]
% -(k/m)*D(2,2)*m*M*x+k*K*x
%
% K=double(subs(K/k)),M=double(subs(M/m));
% [V,D] =eig(K,M);
% V,D
% V'*M*V
% V'*K*V
%
%
%
%
% %%
% % Computation of  potential energy in terms of the normal coordinates
% syms x1 x2 real
% syms y1 y2 real
% syms m k real
%
% K= [5*k,-k;-k,k];;
% M = [3*m,0; 0,m];
% V =1/4*[[ 1, 1]
% [ 3,  -1]]
% Pp =1/2*  [x1,x2]*K*[x1;x2]
% simple(Pp)
% x=V*[y1;y2]
% simple(subs(subs(Pp,x1,x(1)),x2,x(2)))


