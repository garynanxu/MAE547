function Jacob
% Author: Michael Tucker
% First Modifed: Nov. 24th
% Last Modifed: Dec. 2nd
%{
Input:
    User Prompt Input
Output:
    J:  Jacobian;
%}
global R Td dh z_joints J

n = R.n;
A=zeros(4,4,1,n);   % A
T=zeros(4,4,1,n);   % T
% dh = [theta d a alpha];

% Get A for each Joint
for i=1:n
    A(:,1,1,i)=[cos(dh(i,1)), sin(dh(i,1)), 0, 0];
    A(:,2,1,i)=[-sin(dh(i,1))*cos(dh(i,4)), cos(dh(i,1))*cos(dh(i,4)), sin(dh(i,4)), 0];
    A(:,3,1,i)=[sin(dh(i,1))*sin(dh(i,4)), -cos(dh(i,1))*sin(dh(i,4)), cos(dh(i,4)), 0];
    A(:,4,1,i)=[dh(i,3)*cos(dh(i,1)), dh(i,3)*sin(dh(i,1)) dh(i,2) 1];
end

% Get T for each Joint
T(:,:,1,1)=A(:,:,1,1);
for j=1:n-1
    T(:,:,1,j+1)=T(:,:,1,j)*A(:,:,1,j+1);
end


% Get P for each Joint
P=sym(zeros(3,n+1));
for i=1:n
    Pa(:,i)=T(:,4,:,i);
    Pb(:,i)=[Pa(1,i); Pa(2,i); Pa(3,i)];
    P(:,1)=[0 0 0];
    P(:,i+1)=Pb(:,i);
    % P(:,i+1)=P(:,i);
end

% define z from z_joints
z=sym(zeros(3,n));
z(:,1)=z_joints;
Td=T(:,:,:,n);
disp('Td=')
disp(Td);
for i=1:n-1
        disp(sprintf('Looking at Td, please input which column (n) to pull z%d from:',i))
        N = input('Please input index of desired column:');
        z(:,i+1)=[Td(1,N); Td(2,N); Td(3,N)];
end
%Compute Jabobians
for i = 1:n
    
    while(1)
        
        disp(sprintf('Please input the type of joint %d (R or P):',i))
        RP = input('','s');
        
        if RP == 'R'
            J(:,i)=[cross(z(:,i),P(:,i+1)-P(:,i)); z(:,i)];
            break
            
        elseif RP == 'P'
            J(:,i)=[z(:,i); 0; 0; 0];
            break
            
        else
            warning('Not a valid input, please input R or P');
        end
    end
end
J
end