function [ShoulderAngle] = get_ShoulderAngle(Shoulder,UpperArm)
    % Shoulder Angle
    % the vector between shoulder point and the projection of the shoulder point on coronal plane
    % the projection of the shoulder point on the coronal plane are the point's x y components
    ShoulderP = Shoulder.*[1 1 0];
    % Normal
    ShoulderN = Shoulder-ShoulderP;
    % Shoulder angle
    ShoulderAngle = atan2d(vecnorm(cross(ShoulderN,UpperArm,2),2,2), dot(ShoulderN,UpperArm,2));
end