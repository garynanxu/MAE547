%This fucntion plots the results of the inverse dynamics control 
%Author: Ibrahim Hasan
figure(1)
  plot(tinv, Tin(:,1));
  xlabel('time [s]');
  ylabel('Output Force [N]');
  title('Forces in X-direction of the Operational Space');

  
figure(2)
plot(tinv, Tin(:,2));
  xlabel('time [s]');
  ylabel('Output Force [N]');
  title('Forces in Y-direction of the Operational Space');
  
figure(3)
plot(tinv, Vin(:,1),'--',tinv,Vout(:,1));
  xlabel('time [s]');
  ylabel('Velocity [m/s]');
  title('Velocity');
  legend('Vin1','Vout1','location','best')
  
figure(4)
plot(tinv, Vin(:,2),'--',tinv,Vout(:,2));
  xlabel('time [s]');
  ylabel('Velocity [m/s]');
  title('Velocity');
  legend('Vin2','Vout2','location','best')
  
figure(5)
plot(tinv, Xin(:,1),'--',tinv,Xout(:,1));
  xlabel('time [s]');
  ylabel('Position [m]');
  title('Position');
  legend('Xin1','Xout1','location','best')
  
figure(6)
plot(tinv, Xin(:,2),'--',tinv,Xout(:,2));
  xlabel('time [s]');
  ylabel('Position [m]');
  title('Position');
  legend('Xin2','Xout2','location','best')