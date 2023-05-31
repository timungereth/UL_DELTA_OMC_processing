function [TrunkDisplacementDeg] = get_TrunkDisplacementDeg(chest, hip_L, hip_R)
 % change in trunk position in sagittal plane, in [deg]
    % chest, left hip, right hip
    P = chest;
    A = hip_L;
    B = hip_R;
    % chest projected on hip line, point between left and right hip
    H = A + ( (dot((P-A),(B-A),2)./dot((B-A),(B-A),2)) .*(B-A) );
    % use coordinates in saggital plane
    P2  = P(:,[2 3]);
    H2  = H(:,[2 3]);
    % vector from the two points
    HP2 = P2-H2;
    % vector from 1st frame as reference
    HP2f= repmat(HP2(1,:),size(HP2,1),1);
    % https://ch.mathworks.com/matlabcentral/answers/180131-how-can-i-find-the-angle-between-two-vectors-including-directional-information
    TrunkDisplacementDeg = atan2d(HP2(:,1).*HP2f(:,2)-HP2f(:,1).*HP2(:,2), HP2(:,1).*HP2f(:,1)-HP2(:,2).*HP2f(:,2));
    TrunkDisplacementDeg = 180-abs(TrunkDisplacementDeg);
end