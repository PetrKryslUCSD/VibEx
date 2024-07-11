%% 
% Introduce some numbers
k=20; m=5; c=4/10;

%% 
% System matrices
K= [5*k,-k;-k,k];;
M = [3*m,0; 0,m];
C  =[c,0;0,0];
% C  =K/k*c;
[V,D] =eig(K,M);
format  compact
% Eigenvector and eigenvalue solution of the numerical problem
V,D
% The  natural frequencies are
Om = sqrt(diag(D))


% The periods of  free vibration are
fn =Om./(2*pi)
% So the frequency range could be to about twice the highest frequency
omegas = logspace(0,log10(1.2*(2*pi)*max(fn)),50000);


%% 
% We are assuming the load  is on mass 1
f=eye(2);
%% 
% Now sweep the frequencies
H =zeros([size(K),length(omegas)]);

for freq=1:length(omegas)
    omega =omegas(freq);
    u=(-omega^2*M+1i*omega*C+K)\f;
    H(:,:,freq) = u;
end 

%% 
% Plot the transfer function
for i=1:2
    for j=1:2
        figure;
        plot(omegas,squeeze(real(H(i,j,:))),...
            omegas,squeeze(imag(H(i,j,:))),...
             omegas,squeeze(abs(H(i,j,:))));
        grid on; set(gca,'linewidth',2);
        xlabel('Angular frequency [rad/s]'); ylabel(['FRF H_{',num2str(i),num2str(j),'}(\omega)']);
        legend({'Re','Im','Abs'});
    end
end
