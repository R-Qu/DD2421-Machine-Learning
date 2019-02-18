function [retval] = info_gain(data);

[n_examples,features] = size(data);
features = features - 1;

e = entropy(data(:,features+1));

gah = zeros(1,features);

for i = 1:features
  feat_vect = data(:,i);
  max_feat_val = max(feat_vect);
  for j = 1:max_feat_val  
    %calculate matrix of     
    sv_dex = (feat_vect == j);
    s_mat = [];    
    for k = 1:n_examples
      if (sv_dex(k) == 1)
	s_mat = [s_mat;data(k,:)];
      end
    end
    if (isempty(s_mat))
      gah(i) = 0;
    else      
      s_e = entropy(s_mat(:,features+1));
      gah(i) = gah(i) + (sum(sv_dex) / n_examples) * s_e;
    end      
  end
end

retval = e - gah;

%for i = 1:features
%  feat_vect = data(:,i);
%  max_feat_val = max(feat_vect);
%  feat_count = zeros(1,max_feat_val);  
%  for j = 1:max_feat_val  
%    %calculate matrix of     
%    feat_count(j) = feat_count(j) + 1;
%  end
%  normed_count = feat_count / sum(feat_count);
%  split_info(i) = normed_count * log2(normed_count)';
%end

%split_info = 0 - split_info;
%g = retval
%s = split_info
%retval = retval ./ split_info;

%gr = retval
