%neplot.m
%
%Plots E and F in figure 3, 
%  erasing old curves
%
figure(3)
subplot(2,1,1)
hold off
plot(t,E)
title('E')
subplot(2,1,2)
hold off
plot(t,F)
title('F')
