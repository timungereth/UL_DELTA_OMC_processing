function [ShoulderAbduction] = get_shoulderAbduction(Shoulder,UpperArm)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
ShoulderP = Shoulder.*[1 1 0];
% Normal
ShoulderN = Shoulder-ShoulderP;

UpperArmF = UpperArm.*[1 0 1];
ShoulderAbduction = atan2d(vecnorm(cross(ShoulderN,UpperArmF,2),2,2), dot(ShoulderN,UpperArmF,2));

end