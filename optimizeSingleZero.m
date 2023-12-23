function [zero, PM] = optimizeSingleZero(start,pdy, res)
    if ~exist('res','var')
      res = 0.1; % default resolution
    end
    currPM = getPM(start, pdy);
    z = start;
    done = false;
    haveChecked = [z];
    while ~done
        disp([num2str(z),' PM: ', num2str(currPM)])
        inc = z + res;
        if ~isin(haveChecked, inc)
            haveChecked(end+1) = inc;
            incPM = getPM(inc, pdy);
            if (incPM > currPM)
                z = inc;
                currPM = incPM;
                continue
            end % if
        end % if
        dec = z - res;
        if ~isin(haveChecked, dec)
            haveChecked(end+1) = dec;
            decPM = getPM(dec, pdy);
            if (decPM > currPM)
                z = dec;
                currPM = decPM;
                continue
            end % if
        end % if
        done = true;
    end
    zero = z;
    PM = getPM(zero, pdy);
end

function pm = getPM(zero,pdy)
    s = tf('s');
    Dz = (s-zero)/(-zero);
    openloop = Dz * pdy;
    [bbb,~] = phsMargin(openloop);
    pm = bbb;
end