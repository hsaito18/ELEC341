function [x,y] = getFigData(figNum)
    fig = figure(figNum);
    axObjs = fig.Children;
    dataObjs = axObjs.Children;
    x = dataObjs(1).XData;
    y = dataObjs(1).YData;
end