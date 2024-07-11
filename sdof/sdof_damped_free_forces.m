function sdof_damped_free_forces
% Visualization of the forces acting on a SDOF  oscillator in
% free-vibration motion.
    %
    % The forces are shown as complex numbers (vectors) in the complex
    % plane. Note that the time dependence, that is the rotation of the
    % forces with uniform speed (the angular velocity), is not visualized.
    
Gray =[0.72, 0.72, 0.72];
X=1 + 1i*0;

f=figure;
set (f,'DeleteFcn',@close_down_callback);

    function slider_callback(perc)
        zeta=perc/100;
        m=sym('m','real'); k=sym('k','real'); c=sym('c','real');
        alph=sym('alph');
        omega_n =sqrt(k/m);
        c_cr=2*m*omega_n;
        c=zeta*c_cr;
        sol=solve(alph*alph*m+alph*c+k,alph);
        k = 1; m =0.1;
        sol = vpa(subs(sol));
        % Choose the root of the characteristic equation
        if (imag(sol(1))<0)
            alph=sol(1);
        else
            alph=sol(2);
        end
        Fk=double(vpa(subs(k*X)));
        Fc=double(vpa(subs(alph*c*X)));
        Fm=double(vpa(subs(alph*alph*m*X)));
        ArrowSize =abs(Fk)/4;
        figure(f); clf;
        All=GPath_group();
        All.group ={};
        Glyph= glyph_circle(2*X,Gray,'none');
        All= append(All,Glyph);
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
        %         Glyph =translate (Glyph,[-1.6,-1.3]);
        figure(f); hold on
        set(gca,'Units','centimeter')
        render(All)
        set(gca,'xlim', [-2,1.06])
        set(gca,'ylim', 1.06*[-1,1])
        axis equal
        grid on
        axis on
        title('Free-vibration forces');
        %         %     line(sol(:,1),sol(:,2), 'linewidth', 2, 'color', 'red', 'marker', 'none')
        %         %     xlabel('Solution component 1');
        %         line(real(sol(1)), imag(sol(1)), 'linewidth', 2, 'color', 'red', 'marker', 'x')
        %         hold on
        %         line(real(sol(2)), imag(sol(2)), 'linewidth', 2, 'color', 'green', 'marker', 'x')
        xlabel('Re');
        ylabel('Im');
    end

sf=SliderControl(0,'Percent critical damping',0,100,0,[],@slider_callback);
slider_callback(0);

    function close_down_callback(hObject, eventdata)
        try,delete (sf);catch,end
    end

end