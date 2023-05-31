function [moc] = ReadIn_OMC_Data_V2(FolderPath)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
fn.data = FolderPath;
%fn.data = path_to_data;
matFiles = dir([fn.data filesep '*.mat']);
moc = struct;
[b, a] = butter(2, 6/100/2); % Cutoff frequency 6Hz and with respect to ½ sampling frequency

for i = 1:length(matFiles)
    %% read in
    % get trial metadata
    [~, fName, ext] = fileparts(matFiles(i).name);
    fNameUnder = fName;
    fNameUnder(~isstrprop(fName,'alphanum'))='_';
    Q = load([fn.data filesep matFiles(i).name])%.(fNameUnder); % tim
    Q = Q.(append('qtm_' , fNameUnder)); % tim 

    moc(i).FileNumber    = i;
    moc(i).Timestamp     = datetime(Q.Timestamp(1:24), 'InputFormat', 'yyyy-MM-dd, HH:mm:ss.SSS','Format','HH:mm:ss.SSS'); % datevec(Q.Timestamp(1:24),'yyyy-mm-dd, HH:MM:SS.FFF'); % to calcualte differences use e = etime(t2,t1)
    moc(i).FrameRate     = Q.FrameRate;
    moc(i).Frames        = Q.Frames;
    moc(i).Duration      = Q.Frames*1/Q.FrameRate;
    moc(i).FrameDuration = (1/Q.FrameRate);
    moc(i).Time          = (1/Q.FrameRate):(1/Q.FrameRate):(Q.Frames/Q.FrameRate);
    
    % get positions
    moc(i).Trajectories.Labels    = Q.Trajectories.Labeled.Labels;
    pos = permute( Q.Trajectories.Labeled.Data(:,1:3,:), [3,2,1] );
    
    % take care of nan tim
    pos(isnan(pos))=0;


    moc(i).Trajectories.Positions = pos.*[-1 -1 1]; % reorient coordinate system, flip x and y orientation
    % nx frames, ny xyz, nz markers
    [nx ny nz] = size(moc(i).Trajectories.Positions); 
    PositionsF = filtfilt(b, a, reshape( moc(i).Trajectories.Positions,nx,ny*nz,[]) );
    moc(i).Trajectories.PositionsF = reshape(PositionsF,nx,ny,nz);
    
end
end