function ciplot(k1,k2,g,wrange)
%
% function ciplot(k1,k2,g,wrange)
%
% Plots a Nyquist curve and the circle to apply the circle criterion
% 
% k1     - lower slope of nonlinearity
% k2     - upper slope of nonlinearity
% g      - linear system
% wrange - a vector of w-values to be marked on the Nyquist
%          curve; the curve is plotted continuously for w between the
%          highest and lowes values in wrange
%
t=(0:0.01:1)*2*pi;
cre=(-k1-k2+(k2-k1)*cos(t))/(2*k1*k2);
cim=(k2-k1)*sin(t)/(2*k1*k2);
wc=logspace(log10(min(wrange)),log10(max(wrange)),200);
[reN,imN]= nyquist(g,wc);
re=squeeze(reN(1,1,:)); im=squeeze(imN(1,1,:));
plot(cre,cim,re,im,'r')
hold;
[restN,imstN]=nyquist(g,wrange);
rest=squeeze(restN(1,1,:)); imst=squeeze(imstN(1,1,:));
plot(rest,imst,'o')
for j=1:length(wrange), 
 text(rest(j)+0.05,imst(j),['w=',num2str(wrange(j))])
end
hold;
