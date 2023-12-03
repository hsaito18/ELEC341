function pm = gainPM(gain, DGH)
    gol = gain*DGH;
    [a,pm] = margin(gol);
end
