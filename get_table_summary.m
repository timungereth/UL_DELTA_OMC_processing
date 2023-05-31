function [T3] = get_table_summary(moc, patientID, side, savingFolder)
data = cell(numel(moc), 1);
for i = 1:numel(moc)
    ReachingStartTime{i} = moc(i).phase.ReachingStartTime;

    ForwardStartTime{i}   = [moc(i).phase.ForwardStartTime];
    DrinkingStartTime{i}  = [moc(i).phase.DrinkingStartTime];
    BackStartTime{i}      = [moc(i).phase.BackStartTime];
    ReturningStartTime{i} = [moc(i).phase.ReturningStartTime];
    RestStartTime{i}      = [moc(i).phase.RestStartTime];
    ShoulderAbduction{i} = moc(i).parameters.ShoulderAbduction;
    elbowVelocity{i}     = moc(i).parameters.ElbowAngularV;
    trunkDisplacementMM{i} = moc(i).parameters.TrunkDisplacementMM;
    phasecheck{i} = moc(i).PhaseCheck;
end

T3 = table;
%T3.trial = T.trial;
T3.arm(1:length(moc))   = side;
%T3.compensation = T.compensation;
%T3.video = T.video;
T3.ReachingStart  = ReachingStartTime';
T3.ForwardStart   = ForwardStartTime';
T3.DrinkingStart  = DrinkingStartTime';
T3.BackStart      = BackStartTime';
T3.ReturningStart = ReturningStartTime';
T3.RestStart      = RestStartTime';
T3.shoulderAbduction = ShoulderAbduction';
T3.elbowVelocity     = elbowVelocity';
T3.trunkDisplacementMM = trunkDisplacementMM';
T3.phasecheck = phasecheck';
%T3.trunkDisplacementDeg = tdd;
writetable(T3,[patientID,'_', side , '_trialVectors.csv']);

end