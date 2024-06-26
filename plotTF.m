function plotTF(G, endTime, figNum, color)
    if ~exist('endTime','var')
     % third parameter does not exist, so default it to something
     endTime = 1;
    end
    if ~exist('figNum', 'var')
        figNum = 1;
    end
    if ~exist('color', 'var')
        color = 'k-'
    end
    [v_func,t_func] = step(G, endTime);
    t_func = t_func*1000;
    figure(figNum); hold on; grid on;
    plot(t_func, v_func, color,  'Linewidth', 3);
    title('Node Voltage');
    ylabel('Voltage (V)');
    xlabel('Time (s)')
    legend('Node 1', 'Location', 'East');
    set(gca, 'FontSize', 14);