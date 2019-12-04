function DHParameter
% Author: Nan Xu
% First Modifed: Nov. 11th
% Second Modifed: Nov. 14th 

%{
Input:
    User Prompt Input
Output:
    R:  Serial Robot;
    Td: Robot End-effector Pose (4X4);
    qq: Final Position of Each Joint; 
    dh: DH parameter matrix. 
    type: List of each joint type.
%}
global R Td qd dh type q0
disp('Do you have DH parameters? (Y/N)')
YN = input('', 's');

if YN == 'Y'
    
    disp('Please input Your DH Matrix:');
    dh = input('');
    assignin('base', 'dh', dh);
    [nLink, ~] = size(dh);  % If user input DH matrix
    
    for i = 1:nLink
        
        prompt = sprintf('Please input the type of joint %d (R or P):', i);
        disp(prompt);
        type(i) = input('', 's');
        
        if type(i) == 'R'
        
            L{i} = Revolute('d', dh(i,2), 'a', dh(i,3), 'alpha', dh(i,4)); 
        
        elseif type(i) == 'P'
        
            L{i} = Prismatic('a', dh(i,3), 'alpha', dh(i,4)); 
            L{i}.qlim = [0, 1];
        end
        
    end
    
    assignin('base', 'type', type);
    disp('Please input initial position of each joint, i.e.[0.2, pi/4]:');
    q0  = input('');
    assignin('base', 'q0', q0);
    disp('Please input final position of each joint, i.e.[0.2, pi/4]:');
    qd  = input('');
    assignin('base', 'qd', qd);
    R = SerialLink([L{:}]);
    assignin('base', 'R', R);

elseif YN == 'N'
    
    disp('Please input the number of links:')
    nLink = input('');
    type = zeros(nLink+1, 1);
    z_joints = zeros(nLink, 3);
    a = zeros(nLink, 1); % Set initial values 
    d = zeros(nLink, 1); % Set initial values 
    theta = zeros(nLink, 1); % Set initial values 
    qq = []; % Initial q set
    
    
    for i = 1:nLink+1
        
        while(1)
            
            prompt = sprintf('Please input the type of joint %d (R or P):', i);
            disp(prompt);
            type(i) = input('', 's');
        
            if type(i) == 'R' || type(i) == 'P'
           
                break
            
            else
            
                warning('Not a valid input, please input R or P');
            
            end
        
        end
        
        while(1)
            
            prompt = sprintf('- - Plz input the input z direction of joint %d (i.e. [0 0 1]):', i);
            disp(prompt);
            z_j = input('');
        
            if max(size(z_j)) == 3 && min(size(z_j)) == 1
            
                z_joints(i, :) = z_j;
                break
            
            else 
            
                warning('Not a valid input, plz give a 3x1 or 1x3 direction');
        
            end
        
        end
        
        if i > 1
        
            if type(i-1) == 'R'
           
                if ~isequal(z_joints(i-1, :), z_joints(i, :))
                
                    prompt = sprintf('***** Working on Link %d *****', i-1);
                    disp(prompt);
                    prompt = sprintf('- - Plz input distance of joint %d to joint %d:', i-1, i);
                    disp(prompt);
                    a1 = input('');
                    disp('- - Plz input the initial/final position angle in deg, i.e [0, 20]:')
                    theta1 = input('');
                    theta(i-1) = theta1(2)/180 * pi;
                    qq(end+1, :) = theta1/180 * pi;
                    d(i-1) = a1;
                    a(i-1) = 0;
               
                else 
                
                    prompt = sprintf('***** Working on Link %d *****', i-1);
                    disp(prompt)
                    prompt = sprintf('- - Plz input distance joint %d to joint %d:', i-1, i);
                    disp(prompt);
                    a1 = input('');
                    disp('- - Plz input the initial/final position angle in deg, i.e [0, 20]:');
                    theta1 = input('');
                    theta(i-1) = theta1(2)/180 * pi;
                    qq(end+1, :) = theta1/180 * pi;
                    a(i-1) = a1;
                    d(i-1) = 0;
               
                end
            
            elseif type(i-1) == 'P'
            
                prompt = sprintf('***** Working on Link %d *****', i-1);
                disp(prompt);
                prompt = sprintf('- - Plz input the initial/final distance of joint %d to joint %d, i.e. [0, 0.5]:', i-1, i);
                disp(prompt);
                d1 = input('');
                qq(end+1, :) = d1;
                a(i-1) = 0;
                d(i-1) = d1(2);
            
            end
        
        end
                
    end

    
    assignin('base', 'type', type);
    alpha = zeros(nLink, 1);

    for i = 2:nLink+1
    
        u = z_joints(i-1, :);
        v = z_joints(i, :);
        c = cross(u, v);
    
        if c(2) >= 0

            alpha(i-1) = -atan2d(norm(cross(u,v)),dot(u,v))/180*pi;
        
        else
            
            alpha(i-1) = atan2d(norm(cross(u,v)),dot(u,v))/180*pi;
        
        end
    
    end
    
    dh = [theta d a alpha]; 
    assignin('base', 'dh', dh);
    %%%%% Plot Robotic Arm %%%%%
    for i = 1:nLink
        if type(i) == 'R'
        
            L{i} = Revolute('d', dh(i,2), 'a', dh(i,3), 'alpha', dh(i,4)); 
        
        elseif type(i) == 'P'
        
            L{i} = Prismatic('a', dh(i,3), 'alpha', dh(i,4)); 
            qllim = qq(i, :)';
            L{i}.qlim = qllim';  
            
        end
    end

    R = SerialLink([L{:}]);
    q0 = qq(:, 1)';
    qd = qq(:, 2)'; 
    assignin('base', 'q0', q0);
    assignin('base', 'qd', qd);
    assignin('base', 'R', R);

end

Td = R.fkine(qd);
assignin('base', 'Td', Td);


end