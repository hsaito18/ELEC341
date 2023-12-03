function [gm, pm, wx] = marginZero(z1, z2, Gol)
    s = tf('s');
    Dz = (s-z1)*(s-z2)/(z1*z2);
    ol = Gol*Dz;
    [gm, pm, wx] = margin(ol);
 end 