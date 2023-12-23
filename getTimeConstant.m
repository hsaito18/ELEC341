function tau = getTimeConstant(time,values)
    fv = values(end);
    for n = 1 : length(time)
        if values(n) >= fv * 0.632
            prev = values(n-1);
            ratio = (fv*0.632 - prev)/(values(n)-prev);
            tau = (time(n)-time(n-1)) * ratio + time(n-1);
            break
        end % if
    end % for