function [ret_err,nodes_so_far] = trace_err(T,data,nodes_so_far,position,err,open_err)

[n_nodes, max_stat] = size(T);

[n_examples,features] = size(data);
features = features - 1;

if nargin < 6
  open_err = [0 0];
end  

if nargin < 5
  err = [];
end  

if nargin < 4
  position = 1;
end  

if nargin < 3
  nodes_so_far = 0;
end



nodes_so_far = nodes_so_far + 1;

if (isempty(data))
  err = [err;nodes_so_far open_err(1) open_err(2)];      
  if (T(position,13) == 0)
    ret_err = err;    
    return
  else    
    %disp('gah')    
    for i = 1:T(position,13)
      [err,nodes_so_far] =...
	  trace_err(T,data,nodes_so_far,T(position,i),err,open_err);
    end
    ret_err = err;    
    return
  end    
end
  

prediction = T(position,15);


cur_err = [sum(data(:,features+1)==prediction)...
  sum(data(:,features+1)~=prediction)];

new_err = open_err + cur_err;
err = [err;nodes_so_far new_err(1) new_err(2)];

%step through each child
for i = 1:T(position,13)
  s_v = [];
  for j = 1:n_examples
    if (data(j,T(position,11)) == i)
      s_v = [s_v; data(j,:)];
    end

  end
  %subtract out the misclassified  
  if ~(isempty(s_v))    
 %   size(s_v)        
    sub_err = [sum(s_v(:,features+1)==prediction)...
	  sum(s_v(:,features+1)~=prediction)];
%    sub_err  
    open_err = new_err - sub_err;   
    [err,nodes_so_far] =...
	trace_err(T,s_v,nodes_so_far,T(position,i),err,open_err);
    new_err = err(nodes_so_far,2:3);    
  else
    [err,nodes_so_far] =...
	trace_err(T,s_v,nodes_so_far,T(position,i),err,open_err);
  end    
	

end

ret_err = err;