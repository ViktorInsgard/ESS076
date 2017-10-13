%nxplot.m
%
%Plots x and F in figure 2, 
%  erasing old curves
%
figure(2)
subplot(2,1,1)
hold off
plot(t,x)
title('x')
subplot(2,1,2)
hold off
plot(t,F)
title('F')
