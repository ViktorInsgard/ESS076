function yf=dfdeadz(c,p)
%
% function yf=dfdeadz(c,p)
% describing function for symmetric deadzone
%
% c - amplitude of sine at input, can be a vector
% p - vector of the form [d,h], where d=half dead zone width,
%     h/d is slope of linear part
%
dd=p(1)*ones(size(c));
cc=max(dd,c);
yf=(p(2)/p(1))*( 1-(2/pi)*(asin(dd./cc)+dd.*sqrt( 1-(dd.^2)./(cc.^2) )./cc) );

