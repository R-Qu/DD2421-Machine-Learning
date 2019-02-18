function [T] = build_tree(data,cur_depth);
%recursively builds tree

if (nargin < 2)
  cur_depth = 0;
end

global max_depth;

if isempty(max_depth)
  max_depth = 10;  
end  

[n_examples,features] = size(data);
features = features - 1;


%format for T
%T(i,1:10) = child nodes
%T(i,11) = splitting attribute
%T(i,12) = information gain
%T(i,13) = leaf node/number of children
%T(i,15) = classify yes or no?


T = [];


[n_examples,features] = size(data);
features = features - 1;

if (cur_depth == max_depth)
  %maximum  
  T = zeros(1,15);
  T(15) = (sum(data(:,features+1)==1) > sum(data(:,features+1)==0));  
  return;  
end  



if (sum(data(:,features+1)) == n_examples)
  T = zeros(1,15);
  T(15) = 1;  
  return;  
end

if (sum(data(:,features+1)) == 0)
  T = zeros(1,15);
  T(15) = 0;  
  return; 
end


T(15) = (sum(data(:,features+1)==1) > sum(data(:,features+1)==0));  




%calculate entropy
gain = info_gain(data);

%pick attribute with maximum gain
[max_gain, splitting_attribute] = max(gain);

if (max_gain <= -1)
  %no information gain
  T = zeros(1,15);
  T(15) = (sum(data(:,features+1)==1) > sum(data(:,features+1)==0));  
  return;  
end  

if (max_gain==0)
  for k=1:features
    if length(unique(data(:,k)))>1
      splitting_attribute=k;
      break;
    end
  end
end

%set up current node in tree
T = zeros(1,15);
%identify the splitting attribute
T(11) = splitting_attribute;

%identify the maximum gain
T(12) = max_gain;

%identify number of child nodes
T(13) = max(data(:,splitting_attribute));

%label depth
T(14) = cur_depth;

%call build tree recursively for child nodes
for i = 1:T(13)
  %generate matrix of all examples split by appropriate attribute  
  s_v = [];  
  for j = 1:n_examples
    if (data(j,splitting_attribute) == i)
      s_v = [s_v; data(j,:)];
    end
  end
  %s_v  
  %matrix is empty, generate empty leaf node  
  if (isempty(s_v))
    sub_T = zeros(1,15);
    sub_T(13) = 0;    
  else    %matrix not empty, run build_tree recursively
    [sub_T] = build_tree(s_v,cur_depth+1);
  end    
  %add subtrees
  [max_node,junk] = size(T);  
  T = [T;sub_T];  
  T(1,i) = max_node+1;
end


if (cur_depth == 0)
  T = correct_t(T);
end