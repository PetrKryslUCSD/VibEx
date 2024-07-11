function [ output_args ] = sdof_forced_direct( input_args )
%  This function illustrates beats as a result of  the mixing of the free
%  vibration and the forced vibration of a damped single degree of freedom
%  system.  

% Solution of oscillation ODE
k=10; m=10; zeta= 0.0; c=2*m*zeta;
omega_n =sqrt(k/m);
f0=k; omega =  1.000121*omega_n;
K=[0,1;-k/m,-c/m];
w0=[f0/k/(1-(omega/omega_n)^2);0]; % Start that eliminates the complementary function part of the solution
w0=[0;0]; % Cold start: both disp and velocity zero
tspan =[0,1000];
options=odeset ('InitialStep', 2*pi/max([omega,omega_n])/50);
[t,sol] = odetrap(@(t,w) (K*w+[0;f0/m*cos(omega*t)]), tspan, w0, options);
f=f0*cos(omega*t);

figure;
hold on
plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'none')
% plot(t,sol(:,2), 'linewidth', 3, 'color', 'm', 'marker', 'none')
% plot(t,f, 'linewidth', 3, 'color', 'g', 'marker', 'none')
% labels('$t$','$x,\dot{x},f$');
labels('$t$','$x,\dot{x}$');
labels('$t$','$x$');

% figure;
% Pk =1/2*m*sol(:,2).^2;
% Pp =1/2*k*sol(:,1).^2;
% plot(t,Pk, 'linewidth', 3, 'color', 'red', 'marker', 'none')
% hold on
% plot(t,Pp, 'linewidth', 3, 'color', 'b', 'marker', 'none')
% plot(t,Pp+Pk, 'linewidth', 3, 'color', 'k', 'marker', 'none')
% Wf=0*t;
% for j=2:length(t)
%     Wf(j) =Wf(j-1)+(f(j)+f(j-1))/2*(sol(j,1)-sol(j-1,1));
% end
% plot(t,Wf, 'linewidth', 3, 'color', 'g', 'marker', 'none')
% labels('$t$','$P_k,P_p,W_f,P_t$');
end

