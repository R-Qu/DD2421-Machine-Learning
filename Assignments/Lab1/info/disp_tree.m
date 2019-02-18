function [junk] = disp_tree(T,key_file)

close all;

if (nargin < 2)
 att_key = []; 
 val_key = [];  
else  
  load(key_file);
end


%clf;
[nodes,x] = size(T);

depth = max(T(:,14));



xmax = 100;
xmin = 0;
ymax = depth + 2;
ymin = 0;

%figure;

axis('off');

axis([xmin xmax ymin ymax]);

hold on;

ystart = ymax - 1;

draw_tree(T,xmin,xmax,ystart,1,att_key,val_key);

