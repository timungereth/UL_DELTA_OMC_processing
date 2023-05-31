function [ReturningStart,ReturningStartTime] = get_phase_Returning(CupPos,framerate,Mocframes,BackstartFrame)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

CupPosMag = vecnorm(CupPos,2,2);
CupVel    = abs( gradient(CupPosMag,1/framerate) );

% Alt Murpy
ind = [1:Mocframes]';     
CupVelI = find(CupVel>=20 & ind>BackstartFrame,1,'last'); % changed by tim from 10 to 20
if isempty(CupVelI)
    CupVelI = find(CupVel>=20,1,'last'); % changed by tim from 10 to 20
end
ReturningStart = CupVelI;
ReturningStartTime = CupVelI*1/framerate; % number of frames to movement start
end