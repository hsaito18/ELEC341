function b = plotControl(K,Kp,Kd,Ki,p,Gp,H, factor)
    if ~exist('factor','var')
     % third parameter does not exist, so default it to something
      factor = 1;
    end
    s = tf('s');
    PID = K*(Kp + Ki*1/s + Kd*(-p*s)/(s-p))
    Gcl = feedback(PID*Gp, H)*factor;
    G = Gcl;
    plotTF;
    b = 1;
end