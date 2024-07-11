function sdof_damped_Nyquist_GEN
% Visualization of solution of the Frequency Response Function (FRF) and
% the mobility function of a damped linear single degree of freedom
% oscillator.
%
    % The three elements, mass, spring, damper,  may be modified using
    % sliders. Mass and spring can be turned on (1) or off (0).  Damper
    % strength may be chosen by  selecting the damping ratio.
    %
    % The static deflection and the natural frequency is always taken from
    % the UNDAMPED  oscillator WITH  the  SPRING PRESENT. So even when the
    % spring is absent, the static deflection used in the definition of the
    % transfer function is finite. And, when the mass is absent, the
    % natural frequency is taken to be finite, not infinite.
    %
    % Thus, the transfer function is calculated with respect to the
    % UNDAMPED oscillator.  The  magnification factor is the ratio of the
    % amplitude of the dynamic displacement compared to the study
    % displacement.  The phase shift is between  the applied force and the
    % displacement.

    
    % Assume an undamped system as a default
    monoff_Global=1;
    cperc_Global=0;
    konoff_Global=1;
    
    % Numerical  parameters. This defines the base (undamped) system.
    m1=0.1;
    k1 = 1;
    omega_n =sqrt(k1/m1);
    % Range for the frequency
    omega  =[linspace(0,2/3*omega_n,100),linspace(2/3*omega_n,3/2*omega_n,1000),linspace(3/2*omega_n,4*omega_n,100)];
    
    function Damping_slider_callback(dperc)
        cperc_Global=dperc;
        Do_it(monoff_Global,dperc,konoff_Global);
    end
    
    function Mass_slider_callback(mperc)
        monoff_Global=mperc;
        Do_it(mperc,cperc_Global,konoff_Global);
    end
    
    function Stiffness_slider_callback(kperc)
        konoff_Global=kperc;
        Do_it(monoff_Global,cperc_Global,kperc);
    end
    
    f=figure;
    set (f,'DeleteFcn',@close_down_callback);
    
    function Do_it(monoff,dperc,konoff)
        zeta=dperc/100;
        m =monoff*m1;
        k =konoff*k1;
        if (m>0) %  Natural frequency is zero or positive
            if (k>0) % Natural frequencies positive: the general case
                c_cr=2*sqrt(k*m);
                c=zeta*c_cr;
            else% Natural frequency zero
                c_cr=2*sqrt(k1*m1);
                c=zeta*c_cr;
            end
        else % Natural frequency is infinite or indeterminate
            c_cr=2*sqrt(k1*m1);
            c=zeta*c_cr;
        end
        H=1./double(vpa(subs(-omega.^2*m-1i*omega.*c+k)));
        
        figure(f); clf; hold on
        set(gca,'Units','centimeter')
        subplot(2,1,1);
        plot(omega/omega_n,real(H), 'linewidth', 2, 'color', 'red', 'marker', 'none');
        hold on
        plot(omega/omega_n,imag(H), 'linewidth', 2, 'color', 'g', 'marker', 'none');
        set(gca,'ylim',[-max(abs(H)),max(abs(H))]);
        grid on
        axis on
        xlabel('Frequency ratio \beta');
        ylabel('Re H, Im H');
        subplot(2,1,2);
        plot(real(-1i*omega.*H),imag(-1i*omega.*H), 'linewidth', 2, 'color', 'red', 'marker', 'none')
        grid on
        axis on equal
        xlabel('Re M');
        ylabel('Im M');
        
    end
    
    csf=SliderControl(0,'Percent critical damping',0,100,0,[],@Damping_slider_callback);
    msf=SliderControl(0,'Mass present (1) or absent (0)',0,1,1,1,@Mass_slider_callback, true);
    ksf=SliderControl(0,'Spring present (1) or absent (0)',0,1,1,1,@Stiffness_slider_callback,true);
    Do_it(monoff_Global,cperc_Global,konoff_Global);
    
    function close_down_callback(hObject, eventdata)
        try,delete (csf);catch,end
        try,delete (msf);catch,end
        try,delete (ksf);catch,end
    end
    
end