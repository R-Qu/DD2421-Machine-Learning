function [ret_err] = calc_error(T,data,position,err)

[n_nodes, max_stat] = size(T);

[n_examples,features] = size(data);
features = features - 1;

if nargin < 4
  err = zeros(n_nodes,2);
end  

if nargin < 3
  position = 1;
end  


%go 
prediction = (sum(data(:,features+1)==1) > sum(data(:,features+1)==0));
cur_err = [sum(data(:,features+1)==prediction)...
  sum(data(:,features+1)~=prediction)];

err(position,1:2) = cur_err;

for i = 1:T(position,13)
  s_v = [];
  for j = 1:n_examples
    if (data(j,T(position,11)) == i)
      s_v = [s_v; data(j,:)];
    end
  end
  if ~(isempty(s_v))  
    err = calc_error(T,s_v,T(position,i),err);
  end    
end

ret_err = err;