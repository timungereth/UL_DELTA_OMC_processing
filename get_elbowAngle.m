function [ElbowAngle] = get_elbowAngle(shoulder, elbow, wrist)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    LowerArm = wrist-elbow;
    UpperArm = shoulder-elbow;
    
    % Elbow Angle
    % angle = acosd( dot(LowerArmR,UpperArmR,2) ./ (vecnorm(LowerArmR,2,2).*vecnorm(UpperArmR,2,2)) );
    % the above method is inprecise for small angles
    % https://ch.mathworks.com/matlabcentral/answers/101590-how-can-i-determine-the-angle-between-two-vectors-in-matlab
    ElbowAngle = atan2d(vecnorm(cross(LowerArm,UpperArm,2),2,2), dot(LowerArm,UpperArm,2));
    %ElbowAngleRV= gradient(ElbowAngleR)./moc(i).FrameDuration;

end