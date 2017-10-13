function yf=dfcube(c,a)
%
% function yf=dfcube(c,param)
% describing function of cubic nonlinearity
% c - amplitude of sine at input, can be a vector
% a - gain: y = a u^3

yf=a*3*c.^2/4;
