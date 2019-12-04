function JA=JacobianA(q1,q2)
%This function finds the analytical jaccobian matrix of a 2D 2 links planar
%manipulator
%Author: Ibrahim Hasan

C1=cos(q1);
C2=cos(q2);
S1=sin(q1);
S2=sin(q2);
C12=cos(q1+q2);
S12=sin(q1+q2);

global a1 a2;
JA=[(-a1*S1)-(a2*S12) -a2*S12; (a1*C1)+(a2*C12) a2*C12];
end