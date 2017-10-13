function animate(theta,x,step) 
 
%%*************************************************************% 
%%  Animation of an inverted pendulum.			       %
%%  							       %
%%  animate(theta,x,step,t)        			       %
%%	                                                       %
%%	theta - the angle of the pendulum                      % 
%%      x     - cart position       		               %
%%	step  - 0: advance the animation manualy               %
%%	  time vector: advance the animation automatically     %
%%							       %
%%  Animates the pendulum in figure(2)                         %
%%     							       %
%%  Jonas Fredriksson 					       %
%%  Control Engineering					       %
%%  Department of Signals and systems			       %
%%  							       %
%%  Rev. Fredrik Bruzelius                                     %
%%*************************************************************% 

%Pendulum and cart data%     
      cart_length=0.2; 
      cl2=cart_length/2; 
       
      ltime=length(x); 
       
      cartl=x-cl2; 
      cartr=x+cl2; 
       
      pendang=theta; 
      pendl=0.7; 
     
      pendx=pendl*sin(pendang)+x; 
      pendy=pendl*cos(pendang)+0; 

 
%Plot the first frame of the animation%           
      figure(2); 
      cla; 
      hold off;
      L = plot([x(1) pendx(1)], [0 pendy(1)], 'b', 'EraseMode', ...
      'xor', 'LineWidth',[7]); 
      hold on; 
      J = plot([cartl(1) cartr(1)], [0 0], 'r', 'EraseMode', 'xor', ...
		  'LineWidth',[20]);
	  axis([-1 1 -1 1]);
	  axis equal;
	  title('Inverted Pendulum Animation');
	  xlabel('X Position (m)');
	  ylabel('Y Position (m)');
  
       
%Run the animation%       
     for i = 2:ltime-1, 
         
         if step==0
         	pause
         else
	   pause(step(i+1)-step(i))
         end
         
         set(J,'XData', [cartl(i) cartr(i)]); 
         set(L,'XData', [x(i) pendx(i)]); 
         set(L,'YData', [0.03 pendy(i)]);  
		 % The following line added by Magnus Nilsson. Makes it
		 % possible to follow the cart when it goes outside [-1,1].
		 axis([2*floor((x(i)+1)/2)-1 2*floor((x(i)+1)/2)+1 -1 1]);
         drawnow;         
     end


