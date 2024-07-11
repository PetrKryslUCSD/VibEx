function sdof_frequencies
% Animated diagram of the eigenvalues of the linear oscillator

m= 13;    k=  6100; omega_n= sqrt(k/m);
c_cr=2*m*omega_n;

f=figure;
set (f,'DeleteFcn',@close_down_callback);

%
    function slider_callback(zeta)
        figure(f); clf;
        grid on;
        phi =linspace(0,360,37);
        set(gca,'xlim', 1.1*[-2.5,1]);
        set(gca,'ylim', 1.1*[-1,1]);
        axis equal
        hold on
        grid on;
        
        c=zeta*c_cr;
        A = [0, 1; -omega_n^2, -(c/m)];
        [V,D]=eig(A);
        plot(cos(phi/360*2*pi),sin(phi/360*2*pi),'k-','linewidth',2);
        plot(real(D(1,1))/omega_n,imag(D(1,1))/omega_n,'mo','linewidth',4);
        plot(real(D(2,2))/omega_n,imag(D(2,2))/omega_n,'mo','linewidth',4);
        if (imag(D(1,1))~=0)&&(real(D(1,1))~=0)
            text(real(D(1,1))/omega_n/2,0.1,'-\zeta','horizontal', 'center');
            plot([1,1]*real(D(2,2))/omega_n,[1,-1]*imag(D(2,2))/omega_n,'k:','linewidth',2);
            plot([0,1]*real(D(2,2))/omega_n,[1,-1]*0,'k:','linewidth',2);
            text(real(D(2,2))/omega_n,abs(imag(D(2,2)))/omega_n/2,'+\omega_d/\omega_n','horizontal', 'left');
            text(real(D(2,2))/omega_n,-abs(imag(D(2,2)))/omega_n/2,'-\omega_d/\omega_n','horizontal', 'left');
        elseif ((imag(D(1,1))~=0)&&(real(D(1,1))==0))
            plot([1,1]*real(D(2,2))/omega_n,[1,-1]*imag(D(2,2))/omega_n,'k:','linewidth',2);
            plot([0,1]*real(D(2,2))/omega_n,[1,-1]*0,'k:','linewidth',2);
            text(real(D(2,2))/omega_n,abs(imag(D(2,2)))/omega_n/2,'+\omega_n/\omega_n','horizontal', 'left');
            text(real(D(2,2))/omega_n,-abs(imag(D(2,2)))/omega_n/2,'-\omega_n/\omega_n','horizontal', 'left');
        else
            text(real(D(1,1))/omega_n,0.1,'\omega_1/\omega_n','horizontal', 'left');
            text(real(D(2,2))/omega_n,0.1,'\omega_2/\omega_n','horizontal', 'left');
        end
        xlabel('Re\alpha/\omega_n'),ylabel('Im\alpha/\omega_n')
        title(['\zeta=' num2str(zeta)])
        pause(0.1)
        pD=D;
        
    end

sf=SliderControl(0,'Damping ratio',0.0,1.5,0.0,0.01,@slider_callback,~true);
slider_callback(0);

    function close_down_callback(hObject, eventdata)
        try,delete (sf);catch,end
    end

end