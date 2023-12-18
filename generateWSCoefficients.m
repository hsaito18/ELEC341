function [Nws, cs] = generateWSCoefficients(Nw)
    cRaw = ones(Nw-1,1);
    tot = 1;
    for n = 1:Nw-1
        val = exp(-4*n/(Nw-1));
        cRaw(n) = val;
        tot = tot + val;
    end % for
    cs = ones(size(cRaw));
    Nws = 0;
    cs0 = 1/tot;
    for n = 1:Nw-1
        cs(n) = cRaw(n)/tot;
        Nws = Nws + cs(n)*n;
    end % for
    disp(cs(1))
    cs = [cs0, cs'];
end
