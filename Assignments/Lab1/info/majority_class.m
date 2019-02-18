function [m] = majority_class(data)
% This function computes the majority class of a set of instances
% data : NxM matrix in which the row vector data(i,:) represents
% the i-th instance.
% majority_class assumes that the class is stored in the last column data(:,M)
% Machine Learning course 
% Frank Hoffmann (hoffmann@nada.kth.se)

[n_examples,n_features] = size(data);

classes=unique(data(:,n_features));

n_classes=length(classes);
n_max=0;
for i=1:n_classes
 n=size(find(data(:,n_features)==classes(i)),1);
 if (n > n_max)
   n_max=n;
   m=classes(i);
 end
end 



