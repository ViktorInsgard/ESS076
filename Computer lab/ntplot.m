%ntplot.m
%
%Plots theta and F in figure 1, 
%  erasing old curves
%
figure(1)
subplot(2,1,1)
hold off
plot(t,x1)
title('theta')
subplot(2,1,2)
hold off
plot(t,F)
title('F')
