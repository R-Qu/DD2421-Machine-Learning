addpath '../prtools3.1.6';
addpath '../ID3';

%Assignment 1
pos=[];
neg=[];
gbound(1,:)=[0 0 9 9];
lbound=[];
plot_clearn(pos,neg,gbound,lbound);
pause
oracle(3,3);
pos(1,:)=[3 3];
lbound(1,:)=[3 3 3 3];
plot_clearn(pos,neg,gbound,lbound);
pause
oracle(5,5)
pos(2,:)=[5 5];
lbound(1,:)=[3 3 5 5];
plot_clearn(pos,neg,gbound,lbound);
pause
oracle(1,2)
neg(1,:)=[1 2];
gbound(1,:)=[3 3 5 5];
plot_clearn(pos,neg,gbound,lbound);
pause


return
	 
%Assignment 2


readmonks;
fprintf('entropy monk-1 = %.2f\n',entropy(monks_1_train));
fprintf('entropy monk-2 = %.2f\n',entropy(monks_2_train));
fprintf('entropy monk-3 = %.2f\n',entropy(monks_3_train));



%Assignment 2

inf_gain_monks_1=gain(monks_1_train);
inf_gain_monks_2=gain(monks_2_train);
inf_gain_monks_3=gain(monks_3_train);

fprintf('\n');
  
fprintf('information gain monk-1 = %.2f %.2f %.2f %.2f %.2f %.2f\n',inf_gain_monks_1);
fprintf('information gain monk-2 = %.2f %.2f %.2f %.2f %.2f %.2f\n',inf_gain_monks_2);
fprintf('information gain monk-3 = %.2f %.2f %.2f %.2f %.2f %.2f\n',inf_gain_monks_3);

fprintf('\n');

[dummy, split_attribute_1]=max(inf_gain_monks_1);
[dummy, split_attribute_2]=max(inf_gain_monks_2);
[dummy, split_attribute_3]=max(inf_gain_monks_3);
fprintf('split attribute monk-1 = %d\n',split_attribute_1);
fprintf('split attribute monk-2 = %d\n',split_attribute_2);
fprintf('split attribute monk-3 = %d\n',split_attribute_3);

fprintf('\n');

vals=values(monks_1_train,split_attribute_1);
for i=1:length(vals)
  Si=subset(monks_1_train,split_attribute_1,vals(i));
  if (entropy(Si)==0)
    fprintf('split of attribute %d with value %d is leaf node\n', ...
	    split_attribute_1,vals(i));
      fprintf('majority class for split with value %d is %d\n',vals(i), ...
	      majority_class(Si));
      fprintf('\n');
  else
  g=gain(Si);  
  [dummy, split_attribute]=max(g);
  fprintf('monk-1 : split attribute %d with value %d\n',split_attribute_1,i);
  fprintf('information gain = %.2f %.2f %.2f %.2f %.2f %.2f\n', g);
  fprintf('next split attribute for monk-1 = %d\n', split_attribute);
  vals2=values(Si,split_attribute);
  for j=1:length(vals2)
   fprintf('majority class for split with value %d is %d\n',vals2(j), majority_class(subset(Si,split_attribute,vals2(j))));
  end
  fprintf('\n');
  end
end

fprintf('\n');

vals=values(monks_2_train,split_attribute_2);
for i=1:length(vals)
  Si=subset(monks_2_train,split_attribute_2,vals(i));
  if (entropy(Si)==0)
    fprintf('split of attribute %d with value %d is leaf node\n', ...
	    split_attribute_2,vals(i));
  else
  fprintf('monk-2 : split attribute %d with value %d\n',split_attribute_2,i);
  g=gain(Si);  
  [dummy, split_attribute]=max(g);
  fprintf('information gain = %.2f %.2f %.2f %.2f %.2f %.2f\n', g);
  fprintf('next split attribute for monk-2 = %d\n', split_attribute);
  
  end
  fprintf('\n');
end
fprintf('\n');


vals=values(monks_3_train,split_attribute_3);
for i=1:length(vals)
  Si=subset(monks_3_train,split_attribute_3,vals(i));
  if (entropy(Si)==0)
    fprintf('split of attribute %d with value %d is leaf node\n', ...
	    split_attribute_3,vals(i));
  else
  fprintf('monk-3 : split attribute %d with value %d\n',split_attribute_3,i);
  g=gain(Si);  
  [dummy, split_attribute]=max(g);
  fprintf('information gain = %.2f %.2f %.2f %.2f %.2f %.2f\n', g);
  fprintf('next split attribute for monk-3 = %d\n', split_attribute);
  
  end
  fprintf('\n');
end

max_depth=2;
T1=build_tree(monks_1_train);
%disp_tree(T);
max_depth=10;

%Assignment 3


T1=build_tree(monks_1_train);
T2=build_tree(monks_2_train);
T3=build_tree(monks_3_train);
fprintf('\nfull tree\n');
fprintf('train error monk1 = %f, test error monk-1 = %f\n', ...
	calculate_error(T1,monks_1_train),calculate_error(T1,monks_1_test));
fprintf('train error monk2 = %f, test error monk-2 = %f\n', ...
	calculate_error(T2,monks_2_train),calculate_error(T2,monks_2_test));
fprintf('train error monk3 = %f, test error monk-3 = %f\n', ...
	calculate_error(T3,monks_3_train),calculate_error(T3,monks_3_test));


errors_monk_3=zeros(6,10);
for i=1:10
[n,m]=size(monks_3_train);
p=randperm(n);
for k=3:8;
frac=0.1*k;
monks_3_train_new=monks_3_train(p(1:floor(n*frac)),:);
monks_3_prune=monks_3_train(p(floor(n*frac)+1:n),:);
T3=build_tree(monks_3_train_new);
T3p=prune_tree(T3,monks_3_prune);
fprintf('\npruned tree %d - %d training - pruning\n',k*10,100-k*10);
fprintf('train error monk-3 = %f, test error monk-3 = %f\n', ...
	calculate_error(T3p,monks_3_train),calculate_error(T3p,monks_3_test));
errors(k-2,i)=calculate_error(T3p,monks_3_test);
end
end
plot(0.3:0.1:0.8,sum(errors(:,:)/10,2),'r-');

return;

[n,m]=size(monks_1_train);
p=randperm(n);
for k=5:9;
frac=0.1*k;
monks_1_train_new=monks_1_train(p(1:floor(n*frac)),:);
monks_1_prune=monks_1_train(p(floor(n*frac)+1:n),:);
T1=build_tree(monks_1_train_new);
T1p=prune_tree(T1,monks_1_prune);
fprintf('\npruned tree %d - %d training - pruning\n',k*10,100-k*10);

fprintf('train error monk-1 = %f, test error monk-1 = %f\n', ...
	calculate_error(T1p,monks_1_train),calculate_error(T1p,monks_1_test));
end


