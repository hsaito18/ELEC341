function pm = getPM(z1,z2,pdy)
    s = tf('s');
    Dz = (s-z1)*(s-z2)/(z1*z2);
    openloop = Dz * pdy;
    [~,bbb] = margin(openloop);
    pm = abs(bbb);
end