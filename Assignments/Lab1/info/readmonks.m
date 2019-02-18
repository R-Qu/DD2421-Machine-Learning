fid=fopen('monks-1.train','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,124)';
monks_1_train=[tmp2(:,2:7) tmp2(:,1)];
fid=fopen('monks-1.test','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,432)';
monks_1_test=[tmp2(:,2:7) tmp2(:,1)];

%monks_1_train_ds=dataset(monks_1_train(:,1:6),monks_1_train(:,7)+1);
%monks_1_test_ds=dataset(monks_1_test(:,1:6),monks_1_test(:,7)+1);

fid=fopen('monks-2.train','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,169)';
monks_2_train=[tmp2(:,2:7) tmp2(:,1)];
fid=fopen('monks-2.test','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,432)';
monks_2_test=[tmp2(:,2:7) tmp2(:,1)];


%monks_2_train_ds=dataset(monks_2_train(:,1:6),monks_2_train(:,7));
%monks_2_test_ds=dataset(monks_2_test(:,1:6),monks_2_test(:,7));

fid=fopen('monks-3.train','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,122)';
monks_3_train=[tmp2(:,2:7) tmp2(:,1)];
fid=fopen('monks-3.test','r');
tmp=fscanf(fid,'%d%d%d%d%d%d%d%*s\n');
fclose(fid);
tmp2=reshape(tmp',7,432)';
monks_3_test=[tmp2(:,2:7) tmp2(:,1)];

%monks_3_train_ds=dataset(monks_3_train(:,1:6),monks_3_train(:,7));
%monks_3_test_ds=dataset(monks_3_test(:,1:6),monks_3_test(:,7));








