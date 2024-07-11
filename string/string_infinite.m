function string_infinite
% Visualization of the interaction of two waves on  a string.
    
Gray =[0.72, 0.72, 0.72];

f=figure;
set (f,'DeleteFcn',@close_down_callback);

c=100;
T=10;
    function v=ffun(x,t)
        arg=x - c*t;;
        sig=50;
        v=(1-arg.^2/sig^2).*exp(-arg.^2/2/sig^2);
    end
function v=gfun(x,t)
        arg=x + c*(t-T);
        sig=30;
        v=-2*(1-arg.^2/sig^2).*exp(-arg.^2/2/sig^2);
end

    function slider_callback(progress)
        
        figure(f); clf;
        xr=[0,c*T];
        x=linspace(xr(1), xr(2),1000);
        t=progress*T/100;
        line(x, ffun(x,t)+gfun(x,t), 'linewidth', 2, 'color', 'k', 'marker', 'o','markersize',4);
        hold on
        line(x, ffun(x,t), 'linewidth', 2, 'color', 'red', 'marker', 'none');
        line(x, gfun(x,t), 'linewidth', 2, 'color', 'b', 'marker', 'none');
        set(gca,'xlim',xr);
        set(gca,'ylim',[-3,3]);
        xlabel('x');
        ylabel('y');
    end

sf=SliderControl(0,'Percent progress',0,100,0,[],@slider_callback);
slider_callback(0);

    function close_down_callback(hObject, eventdata)
        try,delete (sf);catch,end
    end

end