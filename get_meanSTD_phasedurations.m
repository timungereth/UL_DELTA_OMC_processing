function [phasedurations] = get_meanSTD_phasedurations(phasedurations_X)
%calculate mean and std of phases durations 
%   Detailed explanation goes here
phasedurations.reaching.mean = mean(phasedurations_X.reaching);
phasedurations.reaching.std = std(phasedurations_X.reaching);

phasedurations.forward.mean = mean(phasedurations_X.forward);
phasedurations.forward.std = std(phasedurations_X.forward);

phasedurations.drinking.mean = mean(phasedurations_X.drinking);
phasedurations.drinking.std = std(phasedurations_X.drinking);

phasedurations.drinking.mean = mean(phasedurations_X.drinking);
phasedurations.drinking.std = std(phasedurations_X.drinking);

phasedurations.backtransport.mean = mean(phasedurations_X.backtransport);
phasedurations.backtransport.std = std(phasedurations_X.backtransport);

phasedurations.returning.mean = mean(phasedurations_X.returning);
phasedurations.returning.std = std(phasedurations_X.returning);

end