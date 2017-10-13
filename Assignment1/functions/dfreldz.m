function yf=dfreldz(c,p)
%
% function yf=dfreldz(c,p)
% describing function for symmetric relay with dead zone
%
% c - amplitude of sine at input, can be a vector
% p - vector of the form [d,h]
%     d - half width of dead zone
%     h - amplitude when on
%
d=p(1);
cc=max(c,d);
yf=(4*p(2)/pi)*sqrt(1-d^2*cc.^(-2))./cc;

