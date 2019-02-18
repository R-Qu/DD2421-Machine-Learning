function [new_T] = prune_tree(T,prune_set,position,err)
    
data = prune_set;

[n_nodes, max_stat] = size(T);

[n_examples,features] = size(data);
features = features - 1;

if nargin < 4
  err = calc_error(T,prune_set);  
end  

if nargin < 3
  position = 1;
end  





for i = 1:T(position,13)
  s_v = [];
  for j = 1:n_examples
    if (data(j,T(position,11)) == i)
      s_v = [s_v; data(j,:)];
    end
  end
  if ~(isempty(s_v))  
    T = prune_tree(T,s_v,T(position,i),err);    
  end    
end

sum_err = 0;
classy = 0;
%calculate collective error of population
for i = 1:T(position,13)
  sum_err = sum_err + sum(err(T(position,i),1));
  ack = err(T(position,i),1);
end

se = sum_err;
e = err(position,1);


%prune!
if (sum_err < err(position,1))
  T(position,:) = zeros(1,15);
  T(position,15) = (sum(data(:,features+1)==1) > sum(data(:,features+1)==0));  
end  

new_T = T;