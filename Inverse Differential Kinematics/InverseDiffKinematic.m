function InverseDiffKinematic

% Author: Nan Xu
%{
Input:
    xe: end-effector pos function w.r.t. time, given function handle;
    xe_dot: end-effector velocity function w.r.t. time, given function
            handle;
    q0: Initial Position of Each Joints, given vector
%}
global R q0

disp('Plz input the final time in second, i.e. 4:');
tf = input('');
disp('Plz input the function of your end-effector, i.e. @(t) [0.25*(1-cos(pi*t)); 0.25*(2+sin(pi*t));  sin(pi*t/24)]');
xe = input('', 's');
xe = str2func(xe);
disp('Plz input the function of your end-effector, i.e. @(t) [(pi*sin(pi*t)); (pi*cos(pi*t/24)); pi*cos(pi*t/24)]');
xed = input('', 's');
xe_dot = str2func(xed);

t = 0:0.001:tf;
n = R.n;
q = zeros(n, length(t));
q(:, 1) = q0;
xe = xe(t);
xe_dot = xe_dot(t);

for i = 1:length(t)

    Ja = R.jacobn(q(:, i));
    h = sum(any(Ja, 2));
    rk = rank(Ja);
    nk = max(size(Ja));
    
    if nk == rk
        
        invJ = inv(Ja);
        
    else
        
        invJ = pinv(Ja);
        invJ = invJ';
        invJ = invJ(any(invJ, 2),:);    
        invJ = invJ';
        [nx, ny] = size(invJ);
        
        if ny ~= 3
            
            invJ(:, 4:end) = [];
            
        end
        
    end
    
    xd_dot= xe_dot(:, i);
    qdot = invJ* xd_dot;
    q(:,i+1) = q(:,i) + qdot*0.001;
    
end

for i = 1:n
   
    infor = sprintf("Joint %d", i);
    leg(i) = infor;
    
end
plot(t, q(:, 2:end));
xlabel('Time');
ylabel('Amp');
legend(leg);

end