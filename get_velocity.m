function [V] = get_velocity(value, frameduration)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
 V = gradient(value)./frameduration;
end