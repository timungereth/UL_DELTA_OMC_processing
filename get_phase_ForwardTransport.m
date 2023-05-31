function [ForwardStart, ForwardStartTime] = get_phase_ForwardTransport(CupPos, framerate)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    

    CupPosMag = vecnorm(CupPos,2,2);
    CupVel    = abs( gradient(CupPosMag,1/framerate) );

    % Alt Murpy
    CupVelI = find(CupVel>50,1); %(CupVel>15,1) changed by tim
    ForwardStart     = CupVelI;
    ForwardStartTime = CupVelI*1/framerate; % number of frames to movement start * time per frame
    
end