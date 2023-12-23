function pm = getSinglePM(z1, pdy)
    s = tf('s');
    Dz = (s-z1)/(-z1);
    openloop = Dz * pdy;
    [pm,~] = phsMargin(openloop);
    pm = abs(pm);
end
