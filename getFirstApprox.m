function approx = getFirstApprox(G, scale)
    if ~exist('scale','var')
     % third parameter does not exist, so default it to something
      scale = 10;
    end
    s = tf('s');
    tau = getTau(G, scale);
    a = 1/tau;
    k = dcgain(G) * a;
    approx = k/(s+a);
end