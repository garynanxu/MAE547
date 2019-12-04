function modifyi
%This function is to modify the parameters and of the inverse dynamic
%cotroller
%Author: Ibrahim Hasan
clc
disp('This function cannot run unless running the Gravity Compensation Control Function')
disp('*** Parameters numbering ***')
disp('1-kp1 gain of the gravity compensation controller')
disp('2-kp2 gain of the gravity compensation controller')
disp('3-kd1 gain of the gravity compensation controller')
disp('4-kd2 gain of the gravity compensation controller')
disp('5-Sampling time')
disp('6-Simulation time')
disp('7-Initial joint angles')
disp('8-Initial joint angular velocities')
disp('9-Desired end effector position')
disp('10-Desired end effector velocity')
disp('11-Desired end effector acceleration')

disp('Enter the number of the variable you want to modify:')
X=input('');
disp('Enter the new value of the parameter:')
V=input('');

%%
kp1i=evalin('base','kp1i');
kp2i=evalin('base','kp2i');
kd1i=evalin('base','kd1i');
kd2i=evalin('base','kd2i');

%%
if X==1 
    kp1i=V;
    assignin('base','kp1i',kp1i);
elseif X==2
    kp2i=V;
    assignin('base','kp2i',kp2i);
elseif X==3
    kd1i=V;
    assignin('base','kd1i',kd1i);
elseif X==4
    kd2i=V;
    assignin('base','kd2i',kd2i);
elseif X==5
    tc=V;
    assignin('base','tc',tc);
elseif X==6
    td=V;
    assignin('base','td',td);
elseif X==7
    qi=V;
    assignin('base','qi',qi);
elseif X==8
    qdi=V;
    assignin('base','qdi',qdi);
elseif X==9
    Xd=V;
    assignin('base','Xd',Xd);
elseif X==10
    Xdotd=V;
    assignin('base','Xdotd',Xdotd);
elseif X==11
    Xddotd=V;
    assignin('base','Xddotd',Xddotd);
end

%%
% controller gains
KDinv=diag([kd1i kd2i]);
assignin('base','KDinv',KDinv);
KPinv=diag([kp1i kp2i]);
assignin('base','KPinv',KPinv);
end