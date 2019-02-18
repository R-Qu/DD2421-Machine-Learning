function [s] = subset(data,i,j)
% This function computes the subset of instances for which the i-th
% attribute assumes the value j
% data : NxM matrix in which the row vector data(i,:) represents
% the i-th instance.
% Machine Learning course 
% Frank Hoffmann (hoffmann@nada.kth.se)
ind=find(data(:,i)==j);
s=data(ind,:);
