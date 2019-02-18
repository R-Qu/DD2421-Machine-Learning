function [new_T] = correct_t(old_T);

[n_nodes,junk] = size(old_T);

new_T = old_T;

for i = 1:n_nodes
  new_T(i,1:10) = new_T(i,1:10) + (new_T(i,1:10) > 0) * (i-1);
end