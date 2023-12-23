function plotSettleLines(values)
    fv = values(end);
    lower = fv * 0.98;
    upper = fv * 1.02;
    yline(lower);
    yline(upper);
end
