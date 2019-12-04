function JA=InverseJacobianA(q1,q2)
%This function finds the inverse of the analytical jaccobian matrix of a 2D
%2 link planar manipulator
%Author: Ibrahim Hasan

C1=cos(q1);
C2=cos(q2);
S1=sin(q1);
S2=sin(q2);
C12=cos(q1+q2);
S12=sin(q1+q2);

global a1 a2;
J=[-a1*S1-a2*S12 -a2*S12; a1*C1+a2*C12 +a2*C12];
JA=inv(J);
end