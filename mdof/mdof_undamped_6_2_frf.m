%% 
% Introduce some numbers
k=20; m=5;

%% 
% System matrices
K= [5*k,-k;-k,k];;
M = [3*m,0; 0,m];
[V,D] =eig(K,M);
format  compact
% Eigenvector and eigenvalue solution of the numerical problem
V,D
% The  natural frequencies are
Om = sqrt(diag(D))


% The periods of  free vibration are
fn =Om./(2*pi)
% So the frequency range could be to about twice the highest frequency
omegas = logspace(0,log10(2*(2*pi)*max(fn)),200);


%% 
% We are assuming the load  is on mass 1
f=eye(2);
%% 
% Now sweep the frequencies
H =zeros([size(K),length(omegas)]);

for freq=1:length(omegas)
    omega =omegas(freq);
    u=(-omega^2*M+K)\f;
    H(:,:,freq) = u;
end 

%% 
% Plot the transfer function
for i=1:2
    for j=1:2
        figure;
        plot(omegas,squeeze(H(i,j,:)));
        grid on; set(gca,'linewidth',2);
        xlabel('Angular frequency'); ylabel(['FRF H_{',num2str(i),num2str(j),'}(\omega)']);
    end
end

