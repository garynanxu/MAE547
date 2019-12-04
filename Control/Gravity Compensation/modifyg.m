function modifyg
%This function is to modify the parameters and of the gravity compensation
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
disp('8-Desired joint angles')
disp('Enter the number of the variable you want to modify:')
X=input('');
disp('Enter the new value of the parameter:')
V=input('');

%%
kd1=evalin('base','kd1');
kd2=evalin('base','kd2');
kp1=evalin('base','kp1');
kp2=evalin('base','kp2');

%%
if X==1 
    kp1=V;
    assignin('base','kp1',kp1);
elseif X==2
    kp2=V;
    assignin('base','kp2',kp2);
elseif X==3
    kd1=V;
    assignin('base','kd1',kd1);
elseif X==4
    kd2=V;
    assignin('base','kd2',kd2);
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
    qd=V;
    assignin('base','qd',qd);
end
%%
% controller gains
KDgrav=diag([kd1 kd2]);
assignin('base','KDgrav',KDgrav);
KPgrav=diag([kp1 kp2]);
assignin('base','KPgrav',KPgrav);
end