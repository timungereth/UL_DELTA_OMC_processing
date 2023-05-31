function [moc] = get_parameters(moc, side)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Shoulder Abduction (max angle in drinking phase)
for i = 1:length(moc)
    sa = moc(i).kinematics.(side).ShoulderAbduction;
    intStart = moc(i).phase.DrinkingStart;
    intStop  = moc(i).phase.BackStart;
    sam(i,1) = max( sa(intStart:intStop) );
    moc(i).parameters.ShoulderAbduction = max( sa(intStart:intStop) );
end

%% Angular Vel of Elbow (max vel in reaching phase)
for i = 1:length(moc)
    ev = moc(i).kinematics.(side).ElbowAngleV;
    intStart = moc(i).phase.ReachingStart;
    intStop  = moc(i).phase.DrinkingStart;
    evm(i,1) = max( ev(intStart:intStop) );
    moc(i).parameters.ElbowAngularV = abs( max( ev(intStart:intStop) ) ); % to be corrected, negative values without abs
end

%% trunk displacement
for i = 1:length(moc)
    td = moc(i).kinematics.(side).TrunkDisplacementMM;
    if isnan(td)
        moc(i).parameters.TrunkDisplacementMM = nan;
    else
    intStart = moc(i).phase.ReachingStart;
    intStop  = moc(i).phase.RestStart;
    tdm(i,1) = max( abs( td(intStart:intStop) ) );
    moc(i).parameters.TrunkDisplacementMM = max( abs( td(intStart:intStop) ) );
    end
end

%% trunk displacement in deg
% for i = 1:length(moc)
%    td = moc(i).kinematics.(side).TrunkDisplacementDeg;
%     intStart = moc(i).phase.ReachingStart;
%     intStop  = moc(i).phase.RestStart;
%     tdd(i,1) = max( abs( td(intStart:intStop) ) );
%     moc(i).parameters.TrunkDisplacementDeg = max( abs( td(intStart:intStop) ) );
% end


end