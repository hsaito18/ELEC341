function tfOut = removePole(pole, tfIn)
    s = tf('s');
    dc = -1/(pole);
    p = (s-pole);
    tfOut = tfIn * p;
end
