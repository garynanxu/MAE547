function B=InertiaMatrix(q2)
%This function construct the Inertia Matrix of a 2-D RR Planar Arm
%q2 is the angle of the second joint
%Author: Ibrahim Hasan
global b11a b11b b12a b12b b22
C2=cos(q2);

b11=b11a+b11b*C2;
b12=b12a+b12b*C2;
b21=b12;

B=[b11 b12;b21 b22];
end