function Ye = getSimpleYe(Rw,Lw)
    s = tf('s');
    Ye = 1/(s*Lw + Rw);
end