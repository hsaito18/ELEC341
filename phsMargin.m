%%%%%%%%%%%%%%%%%%%%%%%%
% Find the phase margin WRT -180
% The "margin" function may return phase margin WRT -540
%
% Syntax: 
%   [pm wcp] = phsMargin(KDGH)
%
% Input:
%   KDGH : Open-Loop TF
%
% Output:
%   pm   : Phase margin (deg) WRT -180
%   wcp  : Phase margin x-over frequency
%
%%%%%%%%%%%%%%%%%%%%%%%%
function [pm wcp] = phsMargin(KDGH)

  % Find pm x-over freq
  [x pm x wcp] = margin(KDGH);            % x is a dummy variable

  % Use bode to re-calculate pm WRT -180 (not -540)
  if ~isnan(wcp)
    [x phase] = bode(KDGH, wcp);          % x is a dummy variable
    pm = phase + 180;
  end

end % function
