function forwkin
% Author: Nan Xu


global Td qd R

Td
%%%%% DH parameters Results %%%%%
W = [-2 2 -2 2 -2 2];
plot(R, qd,'workspace', W, 'tilesize',2);
teach(R)

end