function [d2xdt2, d2ydt2, d2zdt2, d2roll, d2pitch, d2yaw] = rigbdy_trans_v3(r, d2xdt20, d2ydt20, d2zdt20, d2roll, d2pitch, d2yaw)
%   rigbdy_trans_v3.m
%   S. Krug
%   ~8/1/17
%   Notes: 8/14/18 Replaced x,y,z coordinates with r vector, with format: r
%   = [(x2-x1),(y2-x1),(z2-z1)];

% http://mathworld.wolfram.com/EulerAngles.html
psi=d2roll;
theta=d2pitch;
phi=d2yaw;
%Rotation Matrix
R(1,1)=cos(theta)*cos(phi);
R(1,2)=cos(theta)*sin(phi);
R(1,3)=-sin(theta);
R(2,1)=sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi);
R(2,2)=sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi);
R(2,3)=cos(theta)*sin(psi);
R(3,1)=cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi);
R(3,2)=cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi);
R(3,3)=cos(theta)*cos(psi);

d2s = (R*r' + [d2xdt20; d2ydt20; d2zdt20]);

d2xdt2 = d2s(1,1);
d2ydt2 = d2s(2,1);
d2zdt2 = d2s(3,1);
end