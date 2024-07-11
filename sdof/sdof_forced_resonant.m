function  sdof_forced_resonant
% This function illustrates how the forced vibration of an undamped single
% degree of freedom system produces a perceived linear increase in
% amplitude  as the limit of beats.
%
% Cold start (zero initial displacement and zero initial velocity)  is
% going to result in beats. The reason can be found in the mixing  of the
% free vibration  and the forced vibration. As we make the forcing
% frequency approach the natural frequency, the amplitude of the beats
% increases and the frequency of the envelope of the beats drops down
% towards zero. Hence we see how  in the limit  of the forcing frequency
% being equal to the natural frequency we get  just the beginnings  of the
% humongous beat of  almost zero  frequency and therefore of almost
% infinite period.

% Solution of oscillation ODE
k=10; m=10; zeta= 0.0; c=2*m*zeta;
omega_n =sqrt(k/m);
f0=k; 
% omega =  1.1*omega_n;%  First try this frequency: High beating frequency
% omega =  1.05*omega_n;% Next try this one: the beating frequency goes down
omega =  1.01*omega_n;% Now this one:  much larger amplitude, beating
%%  frequency decreased further
omega =  1.001*omega_n;% Now this is beginning to look like linear increase of amplitude
K=[0,1;-k/m,-c/m];
x0=[f0/k/(1-(omega/omega_n)^2);0]; % Start that eliminates the complementary function part of the solution
x0=[0;0]; % Cold start: both disp and velocity zero
tspan =[0,1000];
options=odeset ('InitialStep', 2*pi/max([omega,omega_n])/50);
[t,sol] = odetrap(@(t,x) (K*x+[0;f0/m*cos(omega*t)]), tspan, x0, options);
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

