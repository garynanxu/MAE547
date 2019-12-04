function Xe= Fkinematics(q1,q2)
%This function finds the forawrd kinematics of the 2 links planar arm
%Author: Ibrahim Hasan

global a1 a2;

C1=cos(q1);
C2=cos(q2);
S1=sin(q1);
S2=sin(q2);
C12=cos(q1+q2);
S12=sin(q1+q2);

Xe=[a1*C1+a2*C12; a1*S1+a2*S12];
end