%ParamtersInitialization
global b11a b11b b12a b12b b22 a1 a2 tc;
%Links Data
%Mass of the first Link
disp('Please insert the mass of the first link in Kg:')
ml1=input('');
assignin('base','ml1',ml1);
%Mass of the second link
disp('Please insert the mass of the second link in Kg:')
ml2=input('');
assignin('base','ml2',ml2);

%Length of the first link
disp('Please insert the length of the first link in m:')
a1=input('');
assignin('base','a1',a1);
%Length of the second link
disp('Please insert the length of the second link in m:')
a2=input('');
assignin('base','a2',a2);

%Position on the center of gravity of each link
L1=a1/2;
assignin('base','L1',L1);
L2=a2/2;
assignin('base','L2',L2);

%Moment of inertia of the first link
disp('Please insert the centroidal mass moment of inertia of the first link in Kg.m^2:')
Il1=input('');
assignin('base','Il1',Il1);
%Moment of inertia if the second link
disp('Please insert the centroidal mass moment of inertia of the second link in Kg.m^2:')
Il2=input('');
assignin('base','Il2',Il2);

%Motors Data
%Mass of the first motor
disp('Please insert the mass of the first motor in Kg:');
mm1=input('');
assignin('base','mm1',mm1);
%Mass of the second motor
disp('Please insert the mass of the second motor in Kg:');
mm2=input('');
assignin('base','mm2',mm2);

%Moment of inertia of the first motor
disp('Please insert the mass moment of inertia of the first motor in Kg.m^2:')
Im1=input('');
assignin('base','Im1',Im1);
%Moment of inertia of the second motor
disp('Please insert the mass moment of inertia of the second motor in Kg.m^2:')
Im2=input('');
assignin('base','Im2',Im2);

%Gear ratio of the firts motor
disp('Please insert the gear ratio of the first motor:')
kr1=input('');
assignin('base','kr1',kr1);
%Gear ratio of the second motor
disp('Please insert the gear ratio of the second motor:')
kr2=input('');
assignin('base','kr2',kr2);


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
disp('Please insert the value of the gravitational acceleration in m/s^2:')
g=input('');
assignin('base','g',g);

G1a=(ml1*L1+mm2*a1+ml2*a1)*g;
assignin('base','G1a',G1a);
G1b=ml2*L2*g;
assignin('base','G1b',G1b);
G2=ml2*L2*g;
assignin('base','G2',G2);