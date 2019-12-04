function singularity
% Author: Michael Tucker
% First Modifed: Nov. 24th
% Last Modifed: Dec. 2nd
%{
Input:
    User Prompt Input
Output:
    J:  Symbolic Jacobian;
    Jp: Symbolic Prismatic part of Jacobian;
    Jo: Symbolic Rotational part of Jacobian;
    sp: determinant of Jp;
    so: determinant of Jo;
    SCp: conditions that relevant DH parameters needs to be for singularity to occur in Det(Jp);
    SCo: conditions that relevant DH parameters needs to be for singularity to occur in Det(Jo);
%}
global SCp SCo

disp('Please input the number of links:');
n=input('');
% Creating symbolic variables
theta = sym('theta',[1 n],'real');
d = sym('d',[1 n],'real');
a = sym('a',[1 n],'real');
alpha = sym('alpha',[1 n],'real');
disp('Current DH Parameters:')

for i=1:n
    dh(i,:)=[theta(i) d(i) a(i) alpha(i)];
end
disp(dh)

% Change theta DH parameters
for i=1:n
    while(1)
        disp(sprintf('Replace theta%d : (Y/N)', i));
        YN = input('','s');
        if YN == 'Y'
            disp('Please input value to replace theta:')
            dh(i,1) = input('');
            break
            
        elseif YN == 'N'
            % Do Nothing
            break
            
        else
            warning('Not a valid input, please input Y or N');
        end
    end
end

% Change d DH parameters
for i=1:n
    while(1)
        disp(sprintf('Replace d%d : (Y/N)', i));
        YN = input('','s');
        if YN == 'Y'
            disp('Please input value to replace d :')
            dh(i,2) = input('');
            break
            
        elseif YN == 'N'
            % Do Nothing
            break
            
        else
            warning('Not a valid input, please input Y or N');
        end
    end
end

% Change a DH parameters
for i=1:n
    while(1)
        disp(sprintf('Replace a%d : (Y/N)', i));
        YN = input('','s');
        if YN == 'Y'
            disp('Please input value to replace a :')
            dh(i,3) = input('');
            break
            
        elseif YN == 'N'
            % Do Nothing
            break
            
        else
            warning('Not a valid input, please input Y or N');
        end
    end
end

% Change alpha DH parameters
for i=1:n
    while(1)
        disp(sprintf('Replace alpha%d : (Y/N)', i));
        YN = input('','s');
        if YN == 'Y'
            dh(i,4) = input('Please input value to replace alpha :');
            break
            
        elseif YN == 'N'
            % Do Nothing
            break
            
        else
            warning('Not a valid input, please input Y or N');
        end
    end
end

disp('Your new DH Parameters')
disp(dh)

% Get A for each Joint
A=sym(zeros(4,4,1,n));   % A
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

% define z
for i=1
    while(1)
        z_joints=zeros(3);
        prompt = sprintf('- - Plz input the input z0-direction of joint %d (i.e. [0 0 1]):', i)
        z_j = input(prompt);
        
        if max(size(z_j)) == 3 && min(size(z_j)) == 1
            
            z_joints = z_j;
            break
            
        else
            
            warning('Not a valid input, plz give a 3x1 or 1x3 direction');
            
        end
    end
end

z=sym(zeros(3,n));
z(:,1)=z_joints;
Td=T(:,:,:,n);
disp('Td=')
disp(simplify(Td))
for i=1:n-1
        disp(fprintf('Looking at Td, please input which column (n) to pull z%d from:',i))
        N = input('Please input index of desired column:');
        z(:,i+1)=[Td(1,N); Td(2,N); Td(3,N)];
end
%Compute Jabobians
for i = 1:n
    
    while(1)
        
        disp(sprintf('Please input the type of joint %d (R or P):',i))
        RP = input('','s');
        
        if RP == 'R'
            J(:,i)=[cross(z(:,i),P(:,n+1)-P(:,i)); z(:,i)];
            break
            
        elseif RP == 'P'
            J(:,i)=[z(:,i); 0; 0; 0];
            break
            
        else
            warning('Not a valid input, please input R or P');
        end
    end
end

% Get determinants
Jp=[J(1,:); J(2,:); J(3,:)];
Jo=[J(4,:); J(5,:); J(6,:)];

disp('Geometric Jacobian, J')
disp(simplify(J))
disp('Jp')
disp(simplify(Jp))
disp('Jo')
disp(simplify(Jo))

sp=det(Jp);
so=det(Jo);

disp('Determinants for Jp and Jo')
disp(sp)
disp(so)
disp('Simplified version of determinants of Jp and Jo')
disp(simplify(sp))
disp(simplify(so))

% Finding Values of Variables that will lead to Singularity
disp('Now let us find the conditions for when the determinants equal zero')
disp('Variables in the determinant of Jp')
Symbp=symvar(simplify(sp));
disp(Symbp)
disp('enter number of variables present in the determinant of Jp :')
mp=input('');

if mp==0
    disp('No variables to solve for')
else
    for i=1:mp
        disp('with variable')
    disp(Symbp(i))
        SCp = solve(sp==0,Symbp(i));
        disp('Variable must equal the following to have singularity (blank if no condition)')
    disp(SCp)
    end
end

disp('Variables in the determinant of Jo')
Symbo=symvar(simplify(so));
disp(Symbo)
disp('enter number of variables present in the determinant of Jo :')
mo=input('');

if mo==0
    disp('No variables to solve for')
else
    for i=1:mo
        disp('with variable')
    disp(Symbo(i))
        SCo = solve(sp==0,Symbo(i));
        disp('Variable must equal the following to have singularity (blank if no condition)')
    disp(SCo)
    end
end
end