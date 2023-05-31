function [ReachingStart,ReachingStartTime] = get_phase_Reaching(HandPos, framerate, forwardStartFrame,MocFrames)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

    HandPosMag = vecnorm(HandPos,2,2);
    HandVel    = abs( gradient(HandPosMag,1/framerate) );
    
    % Alt Murpy
    ind = [1:MocFrames]';
    HandVelMax = max(HandVel);
    HandVelMaxI = find(HandVel==HandVelMax);
    StartI = max( find( HandVel<HandVelMax*0.02 & ind<forwardStartFrame) );
    if isempty(StartI)
       StartI = 1; % find(HandVel<HandVelMax*0.05 & ind<forwardStartFrame,1,'first'); 
    end
    
    % Peaks
    [pks,plocs] = findpeaks(HandVel);
    [trg,tlocs] = findpeaks(-HandVel);
    
    peakI = min(find(pks>4.5));
    if isempty(peakI)
        peakI = max(find(pks>1.5));
    end
    peak1I = plocs(peakI);
    trgID = max(find(tlocs<peak1I));
    StartID = tlocs(trgID);
    
    if isempty(StartID)
        StartID = max( find(HandVel(1:peak1I)<15) );
    end
    if isempty(StartID)
        StartID = 1;
    end
%     if i == 1
%         StartID = StartI; % this is a cheat. in trial 1 the movement started before the led was on
%     end
    
    ReachingStart     = StartID;
    ReachingStartTime = StartID*1/framerate;
end