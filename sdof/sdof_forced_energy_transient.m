function sdof_forced_energy_transient
%  This function displays the balance of energies for a damped oscillator.  
%
% The potential, kinetic, total  (i. e.  the sum of potential and kinetic)
% energy  and the work performed  by the applied force  are shown as
% colored curves. The kinetic energy is red,  the potential energy is blue,
% the total energy is black, and the work performed  by the applied force
% is green.

% Solution of oscillation ODE
k=10; m=10; zeta= 0.05; c=2*m*zeta;
omega_n =sqrt(k/m);
f0=k; omega =  1.5*omega_n;
K=[0,1;-k/m,-c/m];
% x0=[f0/k/(1-(omega/omega_n)^2);0]; % Start that eliminates the complementary function part of the solution
x0=[0;0]; % Cold start: both disp and velocity zero
tspan =[0,80];
options=odeset('InitialStep', 2*pi/max([omega,omega_n])/2500);
[t,sol] = odetrap(@(t,x) (K*x+[0;f0/m*cos(omega*t)]), tspan, x0, options);
f=f0*cos(omega*t);

% figure;
% hold on
% plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'none')
% plot(t,sol(:,2), 'linewidth', 3, 'color', 'm', 'marker', 'none')
% plot(t,f/f0*max(sol(:,2)), 'linewidth', 3, 'color', 'g', 'marker', 'none')
% labels('$t$','$x,\dot{x},f/f0*|\dot{x}|$');
% labels('$t$','$x,\dot{x}$');
% labels('$t$','$x$');

figure;
Pk =1/2*m*sol(:,2).^2;
Pp =1/2*k*sol(:,1).^2;
plot(t,Pk, 'linewidth', 2, 'color', 'red', 'marker', 'none')
hold on
plot(t,Pp, 'linewidth', 2, 'color', 'b', 'marker', 'none')
plot(t,Pp+Pk, 'linewidth', 2, 'color', 'k', 'marker', 'none')
Wf=0*t;
for j=2:length(t)
    Wf(j) =Wf(j-1)+(f(j)+f(j-1))/2*(sol(j,1)-sol(j-1,1));
end
plot(t,Wf, 'linewidth', 2, 'color', 'g', 'marker', 'none')
labels('$t$','$P_k,P_p,W_f,P_t$');
grid on
end

