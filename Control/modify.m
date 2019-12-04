function modify(X)
%This function is to modify the dynamic parameters and the parmeters of the
%controller
%Author: Ibrahim Hasan
clc
disp('Note this function cannot run unless you run Parameters Initialization Function')
disp('*** Parameters Numbering ***')
disp('1-Mass of the first link')
disp('2-Mass of the second link')
disp('3-Moment of inertia of the first link')
disp('4-Moment of inertia of the second link')
disp('5-Length of the first link')
disp('6-Length of the second link')
disp('7-Mass of the first motor')
disp('8-Mass of the second motor')
disp('9-Moment of inertia of the first motor')
disp('10-Moment of inertia of the second motor')
disp('11-The gear ratio of the first motor')
disp('12-The gear ratio of the second motor')
disp('13-The gravitation acceleration')

disp('Enter the number of the parameter you want to modify:')
X=input('');
disp('Enter the new value of the parameter:')
V=input('');

%% Passing parmeters from the workspace
ml1=evalin('base','ml1');
ml2=evalin('base','ml2');
a1=evalin('base','a1');
a2=evalin('base','a2');
L1=evalin('base','L1');
L2=evalin('base','L2');
Il1=evalin('base','Il1');
Il2=evalin('base','Il2');
mm1=evalin('base','mm1');
mm2=evalin('base','mm2');
Im1=evalin('base','mm2');
mm2=evalin('base','mm2');
Im1=evalin('base','Im1');
Im2=evalin('base','Im2');
kr1=evalin('base','kr1');
kr2=evalin('base','kr2');
g=evalin('base','g');

%% Logic array
if X==1
    ml1=V;
    assignin('base','ml1',ml1);
elseif X==2
    ml2=V;
    assignin('base','ml2',ml2);
elseif X==3
    Il1=V;
    assignin('base','Il1',Il1);
elseif X==4
    Il2=V;
    assignin('base','Il2',Il2);
elseif X==5
    a1=V;
    assignin('base','a1',a1);
elseif X==6
    a2=V;
    assignin('base','a2',a2);
elseif X==7
    mm1=V;
    assignin('base','mm1',mm1);
elseif X==8
    mm2=V;
    assignin('base','mm2',mm2);
elseif X==9
    Im1=V;
    assignin('base','Im1',Im1);
elseif X==10
    Im2=V;
    assignin('base','Im2',Im2);
elseif X==11
    kr1=V;
    assignin('base','kr1',kr1);
elseif X==12
    kr2=V;
    assignin('base','kr2',kr2);
elseif X==13
    g=V;
    assignin('base','g',g);
end
%%
%Position on the center of gravity of each link
L1=a1/2;
assignin('base','L1',L1);
L2=a2/2;
assignin('base','L2',L2);
%Friction matrix
Kr = diag([kr1 kr2]);
assignin('base','Kr',Kr);
Fv = Kr*diag([Im1 Im2])*Kr;
assignin('base','Fv',Fv);

%C Matrix Calculations
c11=-2*ml2*a1*L2;
assignin('base','c11',c11);
c12=-ml2*a1*L2;
assignin('base','c12',c12);
c21=ml2*a1*L2;
assignin('base','c21',c21);

%Augmented Dynamic Parameter for Inertia Matrix
b11a=Il1+ml1*L1^2+kr1^2*Im1+Il2+ml2*a1^2+ml2*L2^2+Im2+mm2*a1^2;
assignin('base','b11a',b11a);
b11b=2*ml2*a1*L2;
assignin('base','b11b',b11b);
b12a=Il2+ml2*L2^2+kr2*Im2;
assignin('base','b12a',b12a);
b12b=ml2*a1*L2;
assignin('base','b12b',b12b);
b22=Il2+ml2+L2^2+kr2^2*Im2;
assignin('base','b22',b22);

%Gravity Dynamic Parameters
G1a=(ml1*L1+mm2*a1+ml2*a1)*g;
assignin('base','G1a',G1a);
G1b=ml2*L2*g;
assignin('base','G1b',G1b);
G2=ml2*L2*g;
assignin('base','G2',G2);