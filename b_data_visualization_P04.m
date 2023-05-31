clear;
close all;
%% load data (phase times and parameters)
Paul_R = readtable('P04_R_trialVectors.csv');
Paul_R = Paul_R(1:40,:);
Paul_L = readtable('P04_L_trialVectors.csv');

%% calcualte phase duration 
phasedurations.R.trials = get_phasedurations(Paul_R);
phasedurations.L.trials = get_phasedurations(Paul_L);

%% calculate mean and std of phases 
phasedurations.R.MeanStd = get_meanSTD_phasedurations(phasedurations.R.trials);
phasedurations.L.MeanStd = get_meanSTD_phasedurations(phasedurations.L.trials);

%% calculate mean std parameters 
figure;

% reaching
subplot(1,3,1)
boxplot([Paul_R.shoulderAbduction , Paul_L.shoulderAbduction],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('angle [°]');
title('max shoulder abduction while drinking ')

subplot(1,3,2)
boxplot([Paul_R.elbowVelocity,Paul_L.elbowVelocity],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('angle velocity [°/s]');
title('max elbow velocity while reaching')

subplot(1,3,3)
trunkDisplacementMM_R = Paul_R.trunkDisplacementMM(~isnan(Paul_R.trunkDisplacementMM));
trunkDisplacementMM_L = Paul_L.trunkDisplacementMM(~isnan(Paul_L.trunkDisplacementMM));
boxplot([trunkDisplacementMM_R,trunkDisplacementMM_L],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('displacement [mm]');
title('trunk displacement forward while drinking')

%% Boxplots of phase durations 
figure;

% reaching
subplot(1,5,1)
boxplot([phasedurations.R.trials.reaching,phasedurations.L.trials.reaching],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - reaching')

% forward 
subplot(1,5,2)
boxplot([phasedurations.R.trials.forward,phasedurations.L.trials.forward],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - forward')

% drinking 
subplot(1,5,3)
boxplot([phasedurations.R.trials.drinking,phasedurations.L.trials.drinking],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - drinking')

% backtransport 
subplot(1,5,4)
boxplot([phasedurations.R.trials.backtransport,phasedurations.L.trials.backtransport],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - forward')

% backtransport 
subplot(1,5,4)
boxplot([phasedurations.R.trials.backtransport,phasedurations.L.trials.backtransport],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - backtransport')

% returning
subplot(1,5,5)
boxplot([phasedurations.R.trials.returning,phasedurations.L.trials.returning],'Labels',{'R - dominat','L - affected'});
xlabel('Hand')
ylabel('duration [s]');
title('Phase duration - returning')


