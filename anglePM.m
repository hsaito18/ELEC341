function pm = anglePM(angle, radius, gol)
    angle1 = pi - angle;
    angle2 = pi + angle;
    az1 = radius.*exp(angle1*1i);
    az2 = radius.*exp(angle2*1i);
    [gm, pm, wx] = marginZero(az1, az2, gol);
end
