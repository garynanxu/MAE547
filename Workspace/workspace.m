function workspace

% Author: Nan Xu
% First Modified: Nov. 20
%{
Inputs
Robot: Given a Serial Robot

Require User Input: 
q: Cell Input contains constrains for 
   all variables from Link 1 to n
%}

% Plz using toolbox version of 10.2 and older
global R

while(1)
    
n = R.n;
disp('Plz input constrains for Link 1 to N (i.e. {(-pi/6:0.05:pi/6), (-pi/6:0.05:pi/6)})');
q = input('');
np = max(size(q));

if isa(q, 'cell') && np == n
    
    break;
    
else
    
    warning('Dimension mismatch with DH parameters or Not a Cell type, Try Again');
    
end

end

var = sym('q', [n 1]);

[Q{1:numel(q)}] = ndgrid(q{:}); 

T = simplify(vpa(R.fkine(var),3));
Pos = T.tv;

x(var(:)) = Pos(1);
X = matlabFunction(x);
X = X(Q{:});

N1 = max(size(X(:)));

y(var(:)) = Pos(2);
Y = matlabFunction(y);
Y = Y(Q{:});

N2 = max(size(Y(:)));

z(var(:)) = Pos(3);
Z = matlabFunction(z);
Z = Z(Q{:});

N3 = max(size(Z(:)));
N = max([N1, N2, N3]);

if N1 == 1
    
    X = X*ones(N, 1);
    
end

if N2 == 1
    
    Y = Y*ones(N, 1);
    
end

if N3 == 1xe = xe(t);
    
    Z = Z*ones(N, 1);
    
end

plot3(X(:), Y(:), Z(:), 'r.')
xlabel('X')
ylabel('Y')
ylabel('Z')
title('3D Workspace of Given Serial Robot')
grid on

end