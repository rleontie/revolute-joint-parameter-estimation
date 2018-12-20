classdef TestOdeRevoluteF < matlab.unittest.TestCase
    % TestOdeRevoluteF unit testing for odeRevoluteF
    
    properties
    end
    
    methods (Test)
        function testatRest(testCase)
            % tests for the at rest case
            mass = 0;
            sphere_radius = 1;
            ui = [-1; 0; 0];
            vi = [0; 1; 0];
            vj = [0; 1; 0];

            % Moment of inertia tensor for a hollow sphere of radius r and mass m
            J = getHollowSphereInertiaTensor(mass, sphere_radius);
            init = [0; 0; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0];

            actSol = odeRevoluteF(init, mass, J, ui, vi, vj);
            expSol = zeros(13,1);
            testCase.verifyEqual(actSol, expSol, 'AbsTol', sqrt(eps));
        end 
        
        function testnoRotation(testCase)
            % Tests for no rotation
            mass = 1;
            sphere_radius = 1;
            ui = [-1; 0; 0];
            vi = [0; 1; 0];
            vj = [0; 1; 0];
            % Moment of inertia tensor for a hollow sphere of radius r and mass m
            J = getHollowSphereInertiaTensor(mass, sphere_radius);
            pose = [0 0 0 1 0 0 0]';
            velocity = [0 0 0 0 0 0]';
            init = [pose; velocity];
            actSol = odeRevoluteF(init, mass, J, ui, vi, vj);
            %expSol = [velocity; 
            %testCase.verifyEqual(actSol, expSol, 'AbsTol', sqrt(eps));
        end 
        
        function test90Rotation(testCase)
            % Tests for 90 degrees rotation
            mass = 1;
            sphere_radius = 1;
            ui = [-1; 0; 0];
            vi = [0; 1; 0];
            vj = [0; 1; 0];

            % Moment of inertia tensor for a hollow sphere of radius r and mass m
            J = getHollowSphereInertiaTensor(mass, sphere_radius);
            pose = [0 0 0 0.7071068 0 0.7071068 0]';
            velocity = [0 0 0 0 0 0]';
            init = [pose; velocity];
            
            actSol = odeRevoluteF(init, mass, J, ui, vi, vj);
            %not sure how to test this
            %expSol = 
            %testCase.verifyEqual(actSol, expSol, 'AbsTol', sqrt(eps));
        end 
    end
end
