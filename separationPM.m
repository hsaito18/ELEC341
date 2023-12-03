function pm = separationPM(separation, center, gol)
    az1 = center + separation;
    az2 = center - separation;
    [gm, pm, wxo] = marginZero(az1, az2, gol);
end