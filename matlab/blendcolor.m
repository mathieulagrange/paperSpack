function color = blendcolor(from, to, pos)
%BLENDCOLOR
%   Blend two colours specifying the fractional position.
%   
%   Example:
%   blendcolor([1 .4 .2], [0 1 .8], .2)
% 
%   ans =
% 
%       0.8000    0.5200    0.3200
%
%
%   Author(s): G. Alessandroni, 08-01-13
%   Copyright 2013, University of Urbino

color = from - ((from - to) * pos);

end

% [EOF] - BLENDCOLOR.M