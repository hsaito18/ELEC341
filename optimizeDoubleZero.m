function [zero1,zero2,PM] = optimizeDoubleZero(start,pdy,resR, resA)
% optimizeDoubleZero Optimizes two zeros for given partial dynamics system.
% Author: Henrique Saito
% 
%   PARAMS:
%
%       start: Real number representing initial point of search. Should be
%       negative of crossover frequency.
%       
%       pdy: Partial dynamics LTI system. pdy = K0*Dp*Gp*H
%       
%       resR (def: 0.1): Search resolution for real values and polar
%       radius.
%
%       resA (def: deg2rad(1)): Search resolution for polar angle. In
%       radians.

    if ~exist('res','var')
      resR = 0.1; % default resolution
      resA = deg2rad(1); % default angle resolution
    end
    [dzero, ~] = optimizeRealDoubleZero(start,pdy,resR);
    [sep, ~, ~] = optimizeSeparation(dzero, 2.52, pdy, resR);
    if sep > 0
        [zero1,zero2,PM] = optimizeRealOnly(dzero, sep, pdy, resR);
    else
        [zero1,zero2,PM] = optimizeComplex(-1*dzero,0,pdy,resR, resA);
    end % if
end


function [z,pm] = optimizeRealDoubleZero(start,pdy,res)
    currPM = getPM(start,start,pdy);
    zero = start;
    done = false;
    haveChecked = [zero];
    while ~done
        inc = zero + res;
        if ~isin(haveChecked, inc)
            haveChecked(end+1) = inc;
            incPM = getPM(inc,inc,pdy);
            if (incPM > currPM)
                zero = inc;
                currPM = incPM;
                continue
            end % if
        end % if
        dec = zero - res;
        if ~isin(haveChecked, dec)
            haveChecked(end+1) = dec;
            decPM = getPM(dec,dec,pdy);
            if (decPM > currPM)
                zero = dec;
                currPM = decPM;
                continue
            end % if
        end % if
        done = true;
    end % while
    z = zero;
    pm = currPM;
    disp(['Double real zero: ', num2str(zero), ' | PM: ', num2str(pm)])
end

function [separation,pm,changed] = optimizeSeparation(center, initSep, pdy, res)
    z1 = center + initSep;
    z2 = center - initSep;
    sep = initSep;
    currPM = getPM(z1,z2,pdy);
    done = false;
    changed = false;
    haveChecked = [initSep];
    while ~done
        incSep = sep + res;
        if ~isin(haveChecked, incSep)
            haveChecked(end+1) = incSep;
            incZ1 = center + incSep;
            incZ2 = center - incSep;
            incPM = getPM(incZ1,incZ2,pdy);
            if (incPM > currPM)
                changed = true;
                sep = incSep;
                currPM = incPM;
                continue
            end % if
        end % if
        decSep = sep - res;
        if ~isin(haveChecked, decSep)
            if (decSep < 0)
                decSep = 0;
            end % if
            haveChecked(end+1) = decSep;
            decZ1 = center + decSep;
            decZ2 = center - decSep;
            decPM = getPM(decZ1, decZ2, pdy);
            if (decPM > currPM)
                changed = true;
                sep = decSep;
                currPM = decPM;
                if (sep == 0)
                    done = true;
                end % if
                continue
            end % if
        end % if
        done = true;
    end % while
    separation = sep;
    pm = currPM;
    disp(['Separation: ',num2str(sep), ' | PM: ', num2str(pm)]);
end
    
function [zero1,zero2,PM] = optimizeRealOnly(initCenter, initSep, pdy, res)
    center = initCenter;
    sep = initSep;
    changed = true;
    tuningCenter = true;
    while changed
        if tuningCenter
            [center, pm, changed] = optimizeRealCenter(center, sep, pdy, res);
            tuningCenter = false;
        else
            [sep, pm, changed] = optimizeSeparation(center, sep, pdy, res);
            tuningCenter = true;
        end % if
    end % while
    zero1 = center + sep;
    zero2 = center - sep;
    PM = pm;
    disp(['Optimized Real Zeros: ', num2str(zero1), ' ', num2str(zero2), ' | PM: ', num2str(pm)]);
end

function [centerOut, pm, changed] = optimizeRealCenter(initCenter, sep, pdy, res)
    z1 = initCenter + sep;
    z2 = initCenter - sep;
    center = initCenter;
    currPM = getPM(z1,z2,pdy);
    done = false;
    changed = false;
    haveChecked = [initCenter];
    while ~done
        incCenter = center + res;
        if ~isin(haveChecked, incCenter)
            haveChecked(end+1) = incCenter;
            incZ1 = incCenter + sep;
            incZ2 = incCenter - sep;
            incPM = getPM(incZ1,incZ2,pdy);
            if (incPM > currPM)
                changed = true;
                center = incCenter;
                currPM = incPM;
                continue
            end % if
        end % if
        decCenter = center - res;
        if ~isin(haveChecked, decCenter)
            haveChecked(end+1) = decCenter;
            decZ1 = sep + decCenter;
            decZ2 = decCenter - sep;
            decPM = getPM(decZ1, decZ2, pdy);
            if (decPM > currPM)
                changed = true;
                center = decCenter;
                currPM = decPM;
                continue
            end % if
        end % if
        done = true;
    end % while
    centerOut = center;
    pm = currPM;
    disp(['Center: ',num2str(center), ' | PM: ', num2str(pm)]);  
end

function [angle, pm, changed] = optimizeComplexAngle(radius, initAngle, pdy, res)
    ang = initAngle;
    ang1 = pi - ang;
    z1 = radius.*exp(ang1*1i);
    z2 = conj(z1);
    currPM = getPM(z1,z2,pdy);
    done = false;
    changed = false;
    haveChecked = [initAngle];
    while ~done
        incAng = ang + res;
        if ~isin(haveChecked, incAng)
            haveChecked(end+1) = incAng;
            incAng1 = pi - incAng;
            incZ1 = radius.*exp(incAng1*1i);
            incZ2 = conj(incZ1);
            incPM = getPM(incZ1,incZ2,pdy);
            if (incPM > currPM)
                changed = true;
                ang = incAng;
                currPM = incPM;
                continue
            end % if
        end % if
        decAng = ang - res;
        if ~isin(haveChecked, decAng)
            if (decAng < 0)
                decAng = 0;
            end % if
            haveChecked(end+1) = decAng;
            decAng1 = pi - decAng;
            decZ1 = radius.*exp(decAng1*1i);
            decZ2 = conj(decZ1);
            decPM = getPM(decZ1, decZ2, pdy);
            if (decPM > currPM)
                changed = true;
                ang = decAng;
                currPM = decPM;
                if (ang == 0)
                    done = true;
                end % if
                continue
            end % if
        end % if
        done = true;
    end % while
    angle = ang;
    pm = currPM;
    disp(['Angle: ', num2str(ang), ' | PM: ',  num2str(pm)]);
end

function [radius, pm, changed] = optimizeComplexRadius(initRadius, angle, pdy, res)
    rad = initRadius;
    ang1 = pi - angle;
    z1 = rad.*exp(ang1*1i);
    z2 = conj(z1);
    currPM = getPM(z1,z2,pdy);
    done = false;
    changed = false;
    haveChecked = [initRadius];
    while ~done
        incRad = rad + res;
        if ~isin(haveChecked, incRad)
            haveChecked(end+1) = incRad;
            incZ1 = incRad.*exp(ang1*1i);
            incZ2 = conj(incZ1);
            incPM = getPM(incZ1,incZ2,pdy);
            if (incPM > currPM)
                changed = true;
                rad = incRad;
                currPM = incPM;
                continue
            end % if
        end % if
        decRad = rad - res;
        if ~isin(haveChecked, decRad)
            if (decRad < 0)
                decRad = 0;
            end % if
            haveChecked(end+1) = decRad;
            decZ1 = decRad.*exp(ang1*1i);
            decZ2 = conj(decZ1);
            decPM = getPM(decZ1, decZ2, pdy);
            if (decPM > currPM)
                changed = true;
                rad = decRad;
                currPM = decPM;
                if (rad == 0)
                    done = true;
                end % if
                continue
            end % if
        end % if
        done = true;
    end % while
    radius = rad;
    pm = currPM;
    disp(['Radius: ',num2str(radius), ' | PM: ', num2str(pm)]);  
end

function [zero1, zero2, PM] = optimizeComplex(initRad, initAngle, pdy, resR, resA)
    rad = initRad;
    ang = initAngle;
    changed = true;
    tuningAngle = true;
    while changed
        if tuningAngle
            [ang, pm, changed] = optimizeComplexAngle(rad, ang, pdy, resA);
            tuningAngle = false;
        else
            [rad, pm, changed] = optimizeComplexRadius(rad, ang, pdy, resR);
            tuningAngle = true;
        end % if
    end % while
    ang1 = pi - ang;
    zero1 = rad.*exp(ang1*1i);
    zero2 = conj(zero1);
    PM = pm;
    disp(['Optimized Complex Zeros: ', num2str(zero1), ' ', num2str(zero2), ' | PM: ', num2str(pm)]);
end

function pm = getPM(z1,z2,pdy)
    s = tf('s');
    Dz = (s-z1)*(s-z2)/(z1*z2);
    openloop = Dz * pdy;
    [~,bbb] = margin(openloop);
    pm = abs(bbb);
end