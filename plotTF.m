function plotTF(G, endTime, figNum)
    if ~exist('endTime','var')
     % third parameter does not exist, so default it to something
     endTime = 1;
    end
    if ~exist('figNum', 'var')
        figNum = 1;
    end
    [v_func,t_func] = step(G, endTime);
    figure(figNum); clf; hold on; grid on;
    plot(t_func, v_func, 'k-',  'Linewidth', 3);
    title('Node Voltage');
    ylabel('Voltage (V)');
    xlabel('Time (s)')
    legend('Node 1', 'Location', 'East');
    set(gca, 'FontSize', 14);