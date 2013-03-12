function plotarrow(x,y, c, arrowsize)
% PLOT an arrow at the center of the line

% The purpose of this function is to add a arrow in a line plot to
% indicate the direction of flow.

if length(x) ~= length(y)
    error('PlotArrow:InconsitentInput', ...
        'Input coordinates must have same length');
end

if length(x) == 2
    % Input are two points
    x1 = x(1);
    x2 = x(2);
    y1 = y(1);
    y2 = y(2);
else
    % Inputs are more than two points
    n = length(x);
    lowIdx = floor(n/2);
    highIdx = lowIdx+1;
    x1 = x(lowIdx);
    x2 = x(highIdx);
    y1 = y(lowIdx);
    y2 = y(highIdx);
end

%%
dx = x1 - x2;
dy = y1 - y2;
r = sqrt(dx*dx + dy*dy);
ca = dx/r;
sa = dy/r;

b = pi/6;
sg = sa * cos(b) - ca * sin(b);
cg = ca * cos(b) + sa * sin(b);

sd = sa * cos(b) + ca * sin(b);
cd = ca * cos(b) - sa * sin(b);

xm = (x1 + x2)/2;
ym = (y1 + y2)/2;

%% Draw an arrow shape at the center of the line
newx1 = xm + arrowsize* cg;
newy1 = ym + arrowsize* sg;

newx2 = xm + arrowsize/3 * ca;
newy2 = ym + arrowsize/3 * sa;

newx3 = xm + arrowsize* cd;
newy3 = ym + arrowsize* sd;

%%
fill([xm, newx1,newx2,newx3, xm], [ym, newy1, newy2, newy3, ym], c, ...
    'LineStyle', 'none' );
end
