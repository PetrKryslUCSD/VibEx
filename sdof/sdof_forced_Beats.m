function sdof_forced_Beats
%  This function illustrates beats as a result of  the mixing of the free
%  vibration and the forced vibration of a damped single degree of freedom
%  system.  

% Solution of oscillation ODE
k=100; m=10; zeta= 0.01; c=2*m*zeta;
omega_n =sqrt(k/m);
f0=2; omega =  0.9*omega_n;
K=[0,1;-k/m,-c/m];
x0=[0;0];
tspan =[0,1000];
options=odeset ('InitialStep', 2*pi/max([omega,omega_n])/50);
[t,sol] = ode45(@(t,x) (K*x+[0;f0*cos(omega*t)]), tspan, x0, options);
figure;
hold on
plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'none')
labels('$t$','$x$');
end

