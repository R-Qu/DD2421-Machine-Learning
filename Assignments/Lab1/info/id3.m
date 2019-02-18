function [T, P_T, train_acc, test_acc, pruned_train_acc,pruned_test_acc, train_set] = id3(data_file,...
train_size, test_size, prune_size, r_seed, depth)



%add testing/training/pruning accor.

tree = [];

if (nargin < 6)
  depth = 7;
end


if (nargin < 5)
  r_seed = 999;
end


if (nargin < 2)
  train_size = 100;
end

if (nargin < 3)
  test_size = 0;
end

if (nargin < 4)
  prune_size = 0;
end


global max_depth;
max_depth = depth;



%initialize random number generator
rand('seed',r_seed);

load(data_file);
l = length(data_file);
l = l-4;
stripped_file = data_file(1:l);

data = eval(stripped_file);


[n_examples,features] = size(data);

%scramble data
rando = rand(1,n_examples);
[q,dex] = sort(rando);

for i = 1:n_examples
  new_data(i,:) = data(dex(i),:);
end

data = new_data;

n_training = ceil(n_examples * (train_size / 100));

train_set = data(1:n_training,:);

n_test = ceil(n_examples * (test_size / 100));

if (n_test > 0)
  test_set = data(n_training+1:n_training+n_test,:);
end  

n_prune = ceil(n_examples * (train_size / 100));

if (n_prune > 0)
  prune_set = data(n_training+n_test+1:n_examples,:);
end  

[T] = build_tree(train_set,0);




train_acc = trace_err(T,train_set);
train_acc = train_acc(:,2) / sum(train_acc(1,2:3));


if not(isempty(test_set))
  test_acc = trace_err(T,test_set);
  test_acc = test_acc(:,2) / sum(test_acc(1,2:3));
else
  test_acc = [];
end  



if not(isempty(prune_set))
  P_T = prune_tree(T,prune_set);
  pruned_train_acc = trace_err(P_T,train_set);
  pruned_train_acc = pruned_train_acc(:,2) / sum(pruned_train_acc(1,2:3));
  pruned_test_acc = trace_err(P_T,test_set);
  pruned_test_acc = pruned_test_acc(:,2) / sum(pruned_test_acc(1,2:3));
else
  P_T = T;
  prune_acc = [];  
end  


