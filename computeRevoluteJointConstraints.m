function revoluteConstraints = computeRevoluteJointConstraints(ui, vi, vj, pose)
% computeRevoluteJointConstraints(ui, vi, vj, pose) computes the revolute joint 
% constraints as spherical joint constraints with two additional constraints.
% The two additional constraints are for vector vi and vj to be parallel. 
%   ui is a 3x1 vector representing local position vector on body i 
%   vi is a 3x1 unit vector for the revolute joint in the body i frame.
%   vj is a 3x1 unit vector for the revolute joint in the body j frame (fixed to the world).
%   pose is a 7x1 vector representing the:
%       position: values 1:3 in pose in the format ex ey ez and
%       orientation: values 4:7 in pose in a quaternion format qw qx qy qz

    quat = pose(4:7); % quaternion components
    wRi = quat2R(quat);
    wRj = eye(3); % body j fixed to the world
    
    % Compute global vectors.
    viw = wRi * vi; 
    vjw = wRj * vj; 

    [v1iw, v2iw] = computeBasisFromAxis(viw);
    
    % Formulate the parallelism condition of the two vectors viw and vjw
    % v1iw' * vjw  = 0 and v2iw' * vjw = 0�
    revoluteParallelVect = [v1iw' * vjw; v2iw' * vjw];
    
    sphericalConstraints = computeSphericalJointConstraints(ui, pose);
    
    revoluteConstraints = [sphericalConstraints; revoluteParallelVect];
end