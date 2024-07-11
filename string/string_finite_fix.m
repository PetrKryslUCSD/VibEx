function string_finite_fix
% Visualization of the reflection
% of a wave at the fixed  end of a string.
%
% The actual  string is shown with black markers. The individual
% constituent waves that travel in opposite directions are shown in  red
% and blue.
%
% The wave is Ricker wavelet.

Gray =[0.72, 0.72, 0.72];

f=figure;
set (f,'DeleteFcn',@close_down_callback);

c=100;
T=10;
    function v=ffun(x,t)
        arg=x - c*(t-T/2);
        sig=50;
        v=(1-arg.^2/sig^2).*exp(-arg.^2/2/sig^2);  
    end
function v=gfun(x,t)
      arg=x + c*(t-T/2);
        sig=50;
        v=-(1-arg.^2/sig^2).*exp(-arg.^2/2/sig^2);  
end

    function slider_callback(progress)
        
        figure(f); clf;
        xr=[-c*T,c*T];
        x=linspace(xr(1), xr(2),1000);
        x2=linspace(0, xr(2),1000);
        t=(progress)*(T)/100;
        patch('xdata',[xr(1),0,0,xr(1)],'ydata',[-2,-2,2,2], ...
            'edgecolor', 'w', 'Facecolor', Gray);
        line(x2, ffun(x2,t)+gfun(x2,t), 'linewidth', 2, 'color', 'k', 'marker', 'o','markersize',4);
        hold on
        line(x, ffun(x,t), 'linewidth', 2, 'color', 'red', 'marker', 'none');
        line(x, gfun(x,t), 'linewidth', 2, 'color', 'b', 'marker', 'none');
        set(gca,'xlim',xr);
        set(gca,'ylim',[-2,2]);
        xlabel('x');
        ylabel('y');
    end

sf=SliderControl(0,'Percent progress',0,100,0,[],@slider_callback);
slider_callback(0);

    function close_down_callback(hObject, eventdata)
        try,delete (sf);catch,end
    end

end