function yf=dfrelay(c,param)
%
% function yf=dfrelay(c,param)
% describing function for a symmetric relay with hysteresis
% c is the amplitude
% param=[d,h] where d=half hysteresis width, h=output magnitude
d=param(1);
h=param(2);
yf=4*h*( sqrt(1-d^2*ones(size(c))./c.^2)-i*d*ones(size(c))./c  )./(pi*c);

