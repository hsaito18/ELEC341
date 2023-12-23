function compareTF(tf1, tf2, endTime, figNum)
    if ~exist('endTime','var')
     % third parameter does not exist, so default it to something
     endTime = 1;
    end
    if ~exist('figNum', 'var')
        figNum = 1;
    end
    [v1, t1] = step(tf1, endTime);
    [v2, t2] = step(tf2, endTime);
    figure(figNum); clf; hold on; grid on;
    plot(t1, v1, 'k-',  'Linewidth', 3);
    plot(t2, v2, 'r-',  'Linewidth', 3);
    title('Node Voltage');
    ylabel('Voltage (V)');
    xlabel('Time (s)')
    legend('Node 1', 'Location', 'East');
    set(gca, 'FontSize', 14);
end