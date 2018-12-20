
mass = 10;
sphere_radius = 3;

% Moment of inertia tensor for a hollow sphere of radius r and mass m
J = getHollowSphereInertiaTensor(mass, sphere_radius);
%   ui is a 3x1 vector from the center-of-mass of body i to the revolute 
%       joint location and expressed in the body i frame 
%   vi is a 3x1 unit vector that points along the axis of the revolute joint 
%       expressed in the body i frame.
%   vj is a 3x1 unit vector that points along the axis of the revolute joint 
%       expressed in the body j frame (fixed to the world).

ui = [-1; 0; 0];
vi = [0; 1; 0];
vj = [0; 1; 0];

% y0rev is the initial conditions 13 x 1 vector containing:
%   position: y0rev(1:3) as x y z
%   orientation: y0rev(4:7) as quaternion qw qx qy qz
%   velocity: as 
%       linear velocity: y0rev(8:10) vx vy vz
%       angulat velocity: y0rev(11:13) wx wy wz
y0rev = [0; 0; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0];

tspan = [0;10];

[t,y3Drev] = ode45(@(t,y)odeRevoluteF(y, mass, J, ui, vi, vj), tspan, y0rev);
% Plot the resulting motion of the joint
plot(y3Drev(1,:),y3Drev(2,:))
xlabel('X') 
ylabel('Y') 