function JAdot=DervJacobianA(q1,q2,qdot1,qdot2)
%This function find the derivative of the analytical jaccobian matrix with
%respect to time
%Author: Ibrahim Hasan

C1=cos(q1);
C2=cos(q2);
S1=sin(q1);
S2=sin(q2);
C12=cos(q1+q2);
S12=sin(q1+q2);

global a1 a2;

j11=(-a1*C1-a2*C12)*qdot1-a2*C12*qdot2;
j12=(-a2*C12*qdot1)-(a2*C12*qdot2);
j21=(-a1*S1-a2*S12)*qdot1-a2*S12*qdot2;
j22=(-a2*S12*qdot1)-(a2*S12*qdot2);


JAdot=[j11 j12; j21 j22];
end