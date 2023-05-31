function [DrinkingStart,DrinkingStartTime,BackStart , BackStartTime ] = get_phase_drinking(CupPos,FacePos, framerate)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
    DistMag = vecnorm(CupPos-FacePos,2,2);
    [trg,tlocs] = findpeaks(-DistMag); % negative DistMag to find troughs 
    trgReal     = DistMag(tlocs);      % troughs 
    DistMinI    =   tlocs(max(find(trgReal<225))); % threshold for mouth cup distance to define interval fro steady state drinking
    DistMinV    = trgReal(max(find(trgReal<225)));
    DistThresh  = DistMinV*1.15;
    
    DistInt = find(DistMag<DistThresh);
    DrinkStartI = min(DistInt);
    DrinkStopI  = max(DistInt);
    DrinkingStart     = DrinkStartI;
    DrinkingStartTime = DrinkStartI*1/framerate; % number of frames to movement start
    BackStart         = DrinkStopI;
    BackStartTime     = DrinkStopI*1/framerate; % number of frames to movement start
end