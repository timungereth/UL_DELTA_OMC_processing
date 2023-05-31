function [RestStart, RestStartTime] = get_phase_Rest(HandPos,framerate,MocFrames, ReturningStartFrame)
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
    HandPosMag = vecnorm(HandPos,2,2);
    HandVel    = abs( gradient(HandPosMag,1/framerate) );
    
    % Alt Murpy
    ind = [1:MocFrames]';
    HandVelMax = max(HandVel);
    HandVelMaxI = find(HandVel==HandVelMax);
    
    HandVelI = find(HandVel>=HandVelMax*0.02 & ind>ReturningStartFrame,1,'last');
    if isempty(HandVelI)
        HandVelI = ReturningStartFrame;
    end
    RestStart     = HandVelI;
    RestStartTime = HandVelI*1/framerate;
end