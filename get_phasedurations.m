function [phasedurations] = get_phasedurations(table)
% calculate phase durations from phase starting and stopping points 

phasedurations.reaching = table.ForwardStart - table.ReachingStart;
phasedurations.forward = table.DrinkingStart - table.ForwardStart;
phasedurations.drinking = table.BackStart - table.DrinkingStart;
phasedurations.backtransport = table.ReturningStart - table.BackStart;
phasedurations.returning = table.RestStart - table.ReturningStart;
end