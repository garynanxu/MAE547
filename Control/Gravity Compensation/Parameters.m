%This function initializes the parameter of the gravity compensation
%cotroller and runs the simulink model
%Author: Ibrahim Hasan

%Parameters Declaration
disp('***This function is for 2 Link Planar Manipulator Control Using Inverse Dynamics***')
global b11a b11b b12a b12b b22 a1 a2 tc;

%Controller Data
disp('Please insert the controller gain kp1:')
kp1=input('');
assignin('base','kp1',kp1);
disp('Please insert the controller gain kp2:')
kp2=input('');
assignin('base','kp2',kp2);

disp('Please insert the controller gain kd1:');
kd1=input('');
assignin('base','kd1',kd1);
disp('Please insert the controller gain kd2:');
kd2=input('');
assignin('base','kd2',kd2);

disp('Please insert the sampling time of the controller in seconds:')
tc=input('');
assignin('base','tc',tc);

%Simulation time
disp('Please insert the simulation time in seconds:')
td=input('');
assignin('base','td',td);

%Desired Position
disp('Please insert the desired joint angles as a row vector in radians [qd1 qd2]:')
qdgrav=input('');
assignin('base','qdgrav',qdgrav);
disp('Please insert the initial joint angles as a row vector [qi1 qi2]:')
qigrav=input('');
assignin('base','qigrav',qigrav);

% controller gains
KDgrav=diag([kd1 kd2]);
assignin('base','KDgrav',KDgrav);
KPgrav=diag([kp1 kp2]);
assignin('base','KPgrav',KPgrav);

Planar2L;