function Ym = getSimpleYm(Bt,Jt,Kt)
    s = tf('s');
    Ym = 1/(Bt + s*Jt + Kt/s);
end