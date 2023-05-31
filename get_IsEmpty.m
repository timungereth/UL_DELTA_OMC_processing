function [is_empty] = get_IsEmpty(varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
is_empty = 0;
for i = 1:numel(varargin)    
    if isempty(varargin{i})
        is_empty = 1;
    end
end
end