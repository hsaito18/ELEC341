function tr = getRiseTime(time, values)
    fv = values(end);
    for n = 1 : length(time)
        if values(n) >= fv
            prev = values(n-1);
            ratio = (fv - prev)/(values(n)-prev);
            tr = (time(n)-time(n-1)) * ratio + time(n-1);
            break
        end % if
    end % for