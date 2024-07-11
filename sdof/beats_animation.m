function beats_animation
    % Visualization of beats.

    Gray =[0.72, 0.72, 0.72];
    Amplitude_1 = 3;
    Amplitude_2 = 2;
    Omega = 3*2*pi;

    f=figure;
    set (f,'DeleteFcn',@close_down_callback);

    function slider_callback(percdiff)
        Omega_ratio =1+percdiff/100;
        ArrowSize =abs(Amplitude_1+ Amplitude_2)/8;
        figure(f); clf; hold on
        set(gca,'Units','centimeter')
        nT=1.5;
        ts=linspace(0,nT*2*pi/(max([0.001,abs(1-Omega_ratio)])*Omega),min([1000,nT*2*100/(Omega_ratio-1)]));
        x1s=real(Amplitude_1*exp(-1i*Omega*ts));
        x2s=real(Amplitude_2*exp(-1i*Omega_ratio*Omega*ts));
        for step=1:length(ts)
            if isvalid(f)
                figure(f);
            end
            t=ts(step);
            subplot(2,1,1); cla; a=gca;
            All=GPath_group();
            All.group ={};
            x1  =Amplitude_1*[cos(Omega*t), sin(Omega*t)];
            g= glyph_vector( [0, 0], x1, ArrowSize);
            g.linewidth =2;
            g.edgecolor ='r';
            All= append(All,g);
            x2 =Amplitude_2*[cos(Omega_ratio*Omega*t), sin(Omega_ratio*Omega*t)];
            g= glyph_vector( [0, 0], x2, ArrowSize);
            g.linewidth =2;
            g.edgecolor ='b';
            All= append(All,g);
            g= glyph_vector( [0, 0], x1+x2, ArrowSize);
            g.linewidth =3;
            g.edgecolor ='k';
            All= append(All,g);
            axis equal
            grid on
            axis on
            set(a,'xlim',(Amplitude_1+ Amplitude_2)*[-1,1]);
            set(a,'ylim',(Amplitude_1+ Amplitude_2)*[-1,1]);
            render(All)
            xlabel('Re');
            ylabel('Im');
            subplot(2,1,2); cla; a=gca;
            plot(x1s(1:step),ts(1:step),'r-'); hold on
            plot(x2s(1:step),ts(1:step),'b-'); hold on
            plot(x1s(1:step)+x2s(1:step),ts(1:step),'k-'); hold on
            set(a,'xlim',(Amplitude_1+ Amplitude_2)*[-1,1]);
            set(a,'ylim',[min(ts),max(ts)]);
            grid on
            axis on
            xlabel('Amplitude');
            ylabel('Time');
            pause(0.001);
        end
    end

    % The STOP button.
    h = findobj(f,'Tag','stop');
    if isempty(h)
      ud.stop = 0;
      pos = get(0,'DefaultUicontrolPosition');
      pos(1) = pos(1) - 15;
      pos(2) = pos(2) - 15;
      str = 'ud=get(gcf,''UserData''); ud.stop=1; set(gcf,''UserData'',ud);';
      uicontrol( ...
          'Style','push', ...
          'String','Stop', ...
          'Position',pos, ...
          'Callback',str, ...
          'Tag','stop');
    else
      set(h,'Visible','on');
      if ishold
        oud = get(f,'UserData');
        ud.stop = oud.stop; 
      else
        ud.stop = 0;
      end
    end
    set(f,'UserData',ud);

    sf=SliderControl(0,'Percent difference in angular velocities',10,100,10,1/9,@slider_callback,true);
    slider_callback(10);

    function close_down_callback(hObject, eventdata)
        try,delete (sf);catch,end
    end

end