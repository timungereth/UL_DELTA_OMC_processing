function [TrunkDiplacementMM] = get_TrunkDisplacementMM(chest)
% change in trunk position in sagittal plane, ie change in y direction,
% in [mm]

is_empty = get_IsEmpty(chest);

if is_empty
    TrunkDiplacementMM = nan;
else
    TrunkDiplacementMM_all = chest - mean(chest(1:5,:),1);
    TrunkDiplacementMM = TrunkDiplacementMM_all(:,2);
end

end