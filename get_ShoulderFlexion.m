function [ShoulderFlexion] = get_ShoulderFlexion(Shoulder,UpperArm)

    ShoulderP = Shoulder.*[1 1 0];
    ShoulderN = Shoulder-ShoulderP;% Normal
    UpperArmS = UpperArm.*[0 1 1];
    ShoulderFlexion = atan2d(vecnorm(cross(ShoulderN,UpperArmS,2),2,2), dot(ShoulderN,UpperArmS,2));

end