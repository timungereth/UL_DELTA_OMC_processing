clear;

%% Load data 
moc = ReadIn_OMC_Data_V2('C:\Users\Tim\Documents\CEFIR\Delta\DELTA_Patients\All_patients\Data\P04\02_drinking_strong'); 
%% set values!  
%set side
patientID = 'P04';
side      = 'L';
SavingFolder = ''; %tbd
saving      =  1;

% set label namens 
chest_label = 'chest';
hip_label_L = 'hip_L' ; 
hip_label_R = 'hip_R'; 
cup_label   = 'cluster_cup_4';
head_label  = 'head';
    
if side == 'R'
    wrist_label    = 'wrist_outer_R';
    elbow_label    = 'elbow_R';
    shoulder_label = 'shoulder_R';
    hand_label     = 'hand_R';
elseif side == 'L'
    wrist_label    = 'wrist_outer_L';
    elbow_label    =  'elbow_L';
    shoulder_label = 'shoulder_L';
    hand_label     = 'hand_L';
end

%% kinematics and phases 
for i = 1:length(moc)
    Wrist    = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),wrist_label)) );
    Elbow    = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),elbow_label)) ); 
    Shoulder = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:), shoulder_label))); 
    chest    = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:), chest_label)));
    hip_L    = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),hip_label_L)) );
    hip_R    = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),hip_label_R)) );
    cup      = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),cup_label)) );
    hand     = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),hand_label)) );
    head     = moc(i).Trajectories.PositionsF(:,:, find(strcmp(moc(i).Trajectories.Labels(:),head_label)) );

    LowerArm = Wrist-Elbow;
    UpperArm = Shoulder-Elbow;
    
    %elbow
    moc(i).kinematics.(side).ElbowAngle        = get_elbowAngle(Shoulder,Elbow,Wrist); %elbow angle 
    moc(i).kinematics.(side).ElbowAngleV       = get_velocity(moc(i).kinematics.(side).ElbowAngle,moc(i).FrameDuration);%elbow velocity
    
    %shoulder
    moc(i).kinematics.(side).ShoulderAngle     = get_ShoulderAngle(Shoulder, UpperArm); % shoulder angle [deg]
    moc(i).kinematics.(side).ShoulderAbduction = get_shoulderAbduction(Shoulder,UpperArm); % shoulder abduction [deg]
    moc(i).kinematics.(side).ShoulderFlexion   = get_ShoulderFlexion(Shoulder,UpperArm); % Shoulder Flexion [deg]

    %trunk 
    moc(i).kinematics.(side).TrunkDisplacementMM = get_TrunkDisplacementMM(chest); % trunk displacement [mm]
    %moc(i).kinematics.(side).TrunkDisplacementDEG = get_TrunkDisplacementDeg(chest,hip_L,hip_R); 
    % change in trunkposition in sagittal plane, in [deg] % not working - toDo need to fix 

    % phases
    % forward transport, glass to mouth
    [moc(i).phase.ForwardStart, moc(i).phase.ForwardStartTime] = get_phase_ForwardTransport(cup,moc(i).FrameRate);
    % reaching including grasping 
    [moc(i).phase.ReachingStart, moc(i).phase.ReachingStartTime] = get_phase_Reaching(hand,moc(i).FrameRate,moc(i).phase.ForwardStart,moc(i).Frames);
    % drinking start and end 
    [moc(i).phase.DrinkingStart, moc(i).phase.DrinkingStartTime, moc(i).phase.BackStart, moc(i).phase.BackStartTime] = get_phase_drinking(cup,head,moc(i).FrameRate);
    % Stop Back Transport and Start Returning
    [moc(i).phase.ReturningStart, moc(i).phase.ReturningStartTime] = get_phase_Returning(cup,moc(i).FrameRate,moc(i).Frames,moc(i).phase.BackStart);
    % rest
    [moc(i).phase.RestStart, moc(i).phase.RestStartTime] = get_phase_Rest(hand,moc(i).FrameRate,moc(i).Frames,moc(i).phase.ReturningStart);
    % phase logical check
    moc(i).PhaseCheck = (moc(i).phase.ReachingStart < moc(i).phase.ForwardStart) && (moc(i).phase.ForwardStart < moc(i).phase.DrinkingStart) && (moc(i).phase.DrinkingStart < moc(i).phase.BackStart) &&  (moc(i).phase.BackStart <moc(i).phase.ReturningStart) && (moc(i).phase.ReturningStart < moc(i).phase.RestStart);
end 

%% get parameters (Alt-Murphy et al. 2018)
moc = get_parameters(moc,side);

%% save results 
if saving 
    save([patientID, '_moc_', side ],'moc'); % SavingFolder , filesep tbd save com array  
    SummaryTable = get_table_summary(moc,patientID, side, SavingFolder); % save summary table 
end

%% Boxplots




