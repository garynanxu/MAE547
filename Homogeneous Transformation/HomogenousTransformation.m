function HomogenousTransformation
%Author Ibrahim Hasan
%This function finds the homogeneous transformation matrix

global R;

disp('Enter the Number of Frame you want to transfer from:')
From=input('');
disp('Enter the Number of Frame You want to transfer to:')
To=input('');
disp('Enter the Values of The Joint Variables between these Frames as a Row Vector [qFrom, ... , qTo] angles in deg and distance in m:')
Q=input('');


TA=eye(4);
i=R.n;
q=zeros(1,i);

j=1;
if To<From
    m=From;
for k=To:From
   q(m)=Q(j);
   j=j+1;
   m=m-1;
end
TA=R.fkine(q,'deg');
TA=inv(TA)
else
for k=From:To
    q(k)=Q(j);
    j=j+1;
end
TA=R.fkine(q,'deg')
end
assignin('base','TA',TA)
end