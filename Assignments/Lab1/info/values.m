function [val] = values(data,i)
% This function computes the vector of unique values for the i-th
% attribute (column).
% data : NxM matrix in which the row vector data(i,:) represents
% the i-th instance.
% Machine Learning course 
% Frank Hoffmann (hoffmann@nada.kth.se)
val=unique(data(:,i));
