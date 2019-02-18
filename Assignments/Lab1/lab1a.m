%ds_train=dataset(monks_3_train(:,1:6),monks_3_train(:,7)+1);
%ds_prune=dataset(monks_3_prune(1:20,1:6),monks_3_prune(1:20,7)+1);
%ds_test=dataset(monks_3_test(:,1:6),monks_3_test(:,7)+1);

for i=0:10
W=treec(monks_1_train_ds,'infcrit',i);
monk_1_error(i+1)=testd(monks_1_test_ds,W);
W=treec(monks_2_train_ds,'infcrit',i);
monk_2_error(i+1)=testd(monks_2_test_ds,W);
W=treec(monks_3_train_ds,'infcrit',i);
monk_3_error(i+1)=testd(monks_3_test_ds,W);
end
plot(0:10,monk_1_error,'r-',0:10,monk_2_error,'b-',0:10,monk_3_error,'g-');

