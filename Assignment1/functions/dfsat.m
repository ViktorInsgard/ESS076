function yf=dfsat(c,p)
%
% function yf=dfsat(c,p)
% describing function for symmetric saturation
%
% c - amplitude of sine at input, can be a vector
% p - vector of the form [d,h]
%     d - input value when saturation starts,
%     h - output value when saturated
%
d=p(1);
cc=max(c,d);
yf=2*p(2)*(asin(d*cc.^(-1))+d*sqrt(1-d^2*cc.^(-2))./cc)/(pi*d);

