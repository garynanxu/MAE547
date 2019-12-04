%This code intializes the the inverse dynamics control parameters and runs
%the simulink model
%Author: Ibrahim Hasan

global b11a b11b b12a b12b b22 a1 a2 tc;
disp('***This function is for 2 Link Planar Manipulator Control Using Inverse Dynamics***')
%Controller Data
disp('Please insert the controller gain kp1:')
kp1i=input('');
assignin('base','kp1i',kp1i);
disp('Please insert the controller gain kp2:')
kp2i=input('');
assignin('base','kp2i',kp2i);

disp('Please insert the controller gain kd1:');
kd1i=input('');
assignin('base','kd1i',kd1i);
disp('Please insert the controller gain kd2:');
kd2i=input('');
assignin('base','kd2i',kd2i);

disp('Please insert the sampling time of the controller in seconds:')
tc=input('');
assignin('base','tc',tc);

% controller gains
KDinv=diag([kd1i kd2i]);
assignin('base','KDinv',KDinv);
KPinv=diag([kp1i kp2i]);
assignin('base','KPinv',KPinv);

%Simulation time
disp('Please insert the simulation time in seconds:')
td=input('');
assignin('base','td',td);

%Initial Angles
disp('Please insert the initial joint angles in rads as [q1 q1] (Never insert [0 0] SINGULARITY):')
qiinv=input('');
assignin('base','qiinv',qiinv);
disp('Please insert the initial joint angular velocities in rad/s as [qd1 qd2]:')
qdi=input('');
assignin('base','qdi',qdi);

%Desired Position
disp('Please insert the desired end effector position in m as [xe1 xe1]:')
Xd=input('');
assignin('base','Xd',Xd);
disp('Please insert the desired end effector velocity in m/s as [ve1 ve2]:')
Xdotd=input('');
assignin('base','Xdotd',Xdotd);
disp('Please insert the desired end effector acceleration in m/s^2 [ae1 ae2]:')
Xddotd=input('');
assignin('base','Xddotd',Xddotd);

PlanarInv;