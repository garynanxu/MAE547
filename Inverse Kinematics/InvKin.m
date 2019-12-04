function InvKin
% Author: Michael Tucker
% First Modifed: Nov. 22th
%  Last Modifed: Nov. 25th
%{
Input:
    User Prompt Input
Output:
    qcomp:  Final Position of End-effector;
    Tcomp: Robot End-effector Pose (4X4);
%}

global R Td q0 qcomp Tcomp
% Answers
qcomp = R.ikunc(Td, q0);
Tcomp = R.fkine(qcomp);
end