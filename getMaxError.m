function max_err = getMaxError(G1, G2, base, time)
% getMaxError Gets max error between two transfer functions.
% Author: Henrique Saito
% 
%   PARAMS:
%       
%       base (def: FV): Value to divide max absolute error by. If empty,
%                       uses the final value of G1.
%
%       time (def: 0->10s 1ms step): Array of time values to use for step
%                                    response.
    if ~exist('time', 'var')
        time = 0:0.001:10;
    end
    max_abs_err = 0;
    [v1, ~] = step(G1, time);
    [v2, ~] = step(G2, time);
    for n = 1 : length(v1)
        err = abs(v1(n) - v2(n));
        if err > max_abs_err
            max_abs_err = err;
        end
    end
    if ~exist('base','var')
     % third parameter does not exist, so default it to something
      base = v1(end);
      disp(base)
    end
    max_err = max_abs_err/base;
end
