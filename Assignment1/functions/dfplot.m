function dfplot(dfun,param,crange,g,wrange)
%
% function dfplot(dfun,param,crange,g,wrange)
% 
% Plots -1/Yf(c) for a describing  function Yf(c) given by dfun, together
% with the Nyquist plot of g.
% dfun is one of dfcube,dfrelay,...
% param is a parameter vector sent to dfun, its function varies with
% the type of nonlinearity, see help files for dfcube, dfrelay etc.
% crange is a vector of c-values; a continuous curve will be plotted for
% c-values between the first and last one; in addition all c-values in
% crange will be marked on the curve;
% wrange is a vector of frequency values handled in the same way as crange

c=min(crange)+(0:0.01:1)*(max(crange)-min(crange));
yf=max(eval([dfun,'(c,param)']),0.0001);
yfcurve=-ones(size(c))./yf;
wc=logspace(log10(min(wrange)),log10(max(wrange)),200);
[reN,imN]= nyquist(g,wc);
re=squeeze(reN(1,1,:)); im=squeeze(imN(1,1,:));
plot(real(yfcurve),imag(yfcurve),re,im,'r')
hold on;
yfval=max(eval([dfun,'(crange,param)']),0.0001);
yfst=-ones(size(crange))./yfval;
plot(real(yfst),imag(yfst),'*')
for j=1:length(crange), 
 text(real(yfst(j)),imag(yfst(j))+0.05,['C=',num2str(crange(j))])
end
[restN,imstN]=nyquist(g,wrange);
rest=squeeze(restN(1,1,:));
imst=squeeze(imstN(1,1,:));
plot(rest,imst,'o')
for j=1:length(wrange), 
 text(rest(j)+0.05,imst(j),['w=',num2str(wrange(j))])
end
hold off;
