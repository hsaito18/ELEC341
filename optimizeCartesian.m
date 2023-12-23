function [zero1,changed] = optimizeCartesian(init,pdy,res)
    zero = init;
    tuningReal = true;
    changed = true;
    changed2 = false;
    first = true;
    while changed | first
        if tuningReal
            [zero,changed] = optimizeCartesianReal(zero, pdy, res);
            tuningReal = false;
            if changed
                changed2 = true;
            end
        else
            [zero,changed] = optimizeCartesianImaginary(zero, pdy, res);
            tuningReal = true;
            first = false;
        end
    end
    zero1 = zero;
    zero2 = conj(zero);
    changed = changed2;
    disp(['Optimized Cartesian Complex Zeros: ', num2str(zero1), ' ', num2str(zero2)]);
end

function [out_zero, changed] = optimizeCartesianReal(zero_init, pdy, res)
    currPM = getPM(zero_init,conj(zero_init),pdy);
    zero = zero_init;
    done = false;
    haveChecked = [real(zero)];
    while ~done
        inc = zero + res;
        if ~isin(haveChecked, real(inc))
            haveChecked(end+1) = real(inc);
            incPM = getPM(inc,conj(inc),pdy);
            if (incPM > currPM)
                zero = inc;
                currPM = incPM;
                continue
            end % if
        end % if
        dec = zero - res;
        if ~isin(haveChecked, real(dec))
            haveChecked(end+1) = real(dec);
            decPM = getPM(dec,conj(dec),pdy);
            if (decPM > currPM)
                zero = dec;
                currPM = decPM;
                continue
            end % if
        end % if
        done = true;
    end % while
    out_zero = zero;
    pm = currPM;
    changed = out_zero ~= zero_init;
    disp(['Cartesian real zero: ', num2str(zero), ' | PM: ', num2str(pm)])
end

function [out_zero, changed] = optimizeCartesianImaginary(zero_init, pdy, res)
    currPM = getPM(zero_init,conj(zero_init),pdy);
    zero = zero_init;
    done = false;
    haveChecked = [imag(zero)];
    while ~done
        inc = zero + i*res;
        if ~isin(haveChecked, imag(inc))
            haveChecked(end+1) = imag(inc);
            incPM = getPM(inc,conj(inc),pdy);
            if (incPM > currPM)
                zero = inc;
                currPM = incPM;
                continue
            end % if
        end % if
        dec = zero - i*res;
        if ~isin(haveChecked, imag(dec))
            haveChecked(end+1) = imag(dec);
            decPM = getPM(dec,conj(dec),pdy);
            if (decPM > currPM)
                zero = dec;
                currPM = decPM;
                continue
            end % if
        end % if
        done = true;
    end % while
    out_zero = zero;
    pm = currPM;
    changed = out_zero ~= zero_init;
    disp(['Cartesian imaginary zero: ', num2str(zero), ' | PM: ', num2str(pm)])
end

function pm = getPM(z1,z2,pdy)
    s = tf('s');
    Dz = (s-z1)*(s-z2)/(z1*z2);
    openloop = Dz * pdy;
    [~,bbb] = margin(openloop);
    pm = abs(bbb);
end