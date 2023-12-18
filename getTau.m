function tau = getTau(G, scale)
    if ~exist('scale','var')
     % third parameter does not exist, so default it to something
      scale = 10;
    end
    [v,t] = step(G, scale);
    fv = v(end);
    tau = 0;
    for n = 1 : length(v)
        val = v(n);
        ratio = val/fv;
        if ratio >= 0.632
            tau = t(n);
            break
        end
    end

