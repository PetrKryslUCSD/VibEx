function sdof_damped_forced_forces
    % Visualization of the forces acting on a SDOF  oscillator in
    % forced harmonic vibration motion.
    %
    % The forces are shown as complex numbers (vectors) in the complex
    % plane. Note that the time dependence, that is the rotation of the
    % forces with uniform speed (the angular velocity), is not visualized.
    
    
    Gray =[0.72, 0.72, 0.72];
    X=1 + 1i*0;
    omult_global =0;
    dperc_global =0;
    k = 1; m =0.1;
    omega_n =sqrt(k/m);
    c_cr=2*m*omega_n;
    f0=1;
    
    function damping_slider_callback(dperc)
        dperc_global =dperc;
        Do_it(dperc_global,omult_global);
    end
    
    function frequency_slider_callback(omult)
        omult_global =omult;
        Do_it(dperc_global,omult_global);
    end
    
    f=figure;
    set (f,'DeleteFcn',@close_down_callback);
    
    function Do_it(dperc,omult)
        zeta=dperc/100;
        omega=omult*omega_n;
        c=zeta*c_cr;
        if (omult==1)&&(c==0)% Resonance for undamped vibration
            H=1i/eps;
        else
            H=1./double(((-omega.^2*m-1i*omega.*c+k)));
        end
        X = f0*H;
        Fk=double(((k*X)));
        Fc=double(((-1i*omega*c*X)));
        Fm=double(((-omega.^2*m*X)));
        ArrowSize =max([f0,abs(Fk),abs(Fc),abs(Fm)])/8;
        figure(f); clf;
        All=GPath_group();
        All.group ={};
        Glyph= glyph_circle(2*f0,Gray,'none');
        All= append(All,Glyph);
        g= glyph_vector( [0, 0],[f0, 0], ArrowSize);
        g.linewidth =3;
        g.edgecolor ='k';
        All= append(All,g);
        g= GPath_text([f0, 0]*1.05, 'Force');
        All= append(All,g);
        if (abs(Fk)>0)
            g= glyph_vector( [0, 0],[real(Fk), imag(Fk)], ArrowSize);
            g.linewidth =2;
            g.edgecolor ='r';
            All= append(All,g);
            g= GPath_text([real(Fk), imag(Fk)]*1.05, 'Stiffness');
            if (real(Fk)<0),g.horizontalalignment ='right';end
            All= append(All,g);
        end
        if (abs(Fc)>0)
            g= glyph_vector( [0, 0],[real(Fc), imag(Fc)], ArrowSize);
            g.linewidth =2;
            g.edgecolor ='g';
            All= append(All,g);
            g= GPath_text([real(Fc), imag(Fc)]*1.05, 'Damping');
            if (real(Fc)<0),g.horizontalalignment ='right';end
            All= append(All,g);
        end
        if (abs(Fm)>0)
            g= glyph_vector( [0, 0],[real(Fm), imag(Fm)], ArrowSize);
            g.linewidth =2;
            g.edgecolor ='b';
            All= append(All,g);
            g= GPath_text([real(Fm), imag(Fm)]*1.05, 'Inertia');
            if (real(Fm)<0),g.horizontalalignment ='right';end
            All= append(All,g);
        end
        figure(f); hold on
        set(gca,'Units','centimeter')
        render(All)
        set(gca,'xlim', [-1,1]*max([f0,abs(Fk),abs(Fc),abs(Fm)]))
        set(gca,'ylim', [-1,1]*max([f0,abs(Fk),abs(Fc),abs(Fm)]))
        axis equal
        grid on
        axis on
        title('Forced-vibration forces');
        xlabel('Re');
        ylabel('Im');
    end
    
    dsf=SliderControl(0,'Percent critical damping',0,100,0,[],@damping_slider_callback);
    osf=SliderControl(0,'Frequency multiplier',0,3,0,0.01,@frequency_slider_callback);
    Do_it(dperc_global,omult_global);;;
    
    function close_down_callback(hObject, eventdata)
        try,delete (dsf);catch,end
        try,delete (osf);catch,end
    end
    
end