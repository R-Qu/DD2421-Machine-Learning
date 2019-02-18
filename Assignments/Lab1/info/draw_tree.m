function draw_tree(T,xmin,xmax,ystart,position,att_key,val_key)

T(position,:);

global count;

xnode = (xmin + xmax)/2;
ynode = ystart;


if ~(isempty(att_key))
  n_atts = max(size(att_key));
  n_vals = max(size(val_key)) / n_atts;
end

%text(xnode+0.2,ynode+0.2,num2str(count));

%number of subtrees?
n_subnodes = T(position,13);

if (n_subnodes == 0)
  if (T(position,15) == 1)  
    text(xnode,ynode,'yes');
  else
    text(xnode,ynode,'no');
  end    

else  
  plot(xnode,ynode,'wo');  

  if isempty(att_key)
    st = num2str(T(position,11));    
  else
    st = att_key(T(position,11),:);
  end    
  text(xnode+1,ynode,st);

  increment = (xmax-xmin) / n_subnodes;

  %draw arcs
  
  cur_xmin = xmin;
  
  for i = 1:n_subnodes
    cur_xmax = cur_xmin + increment;
    
    %recursively draw tree    
    draw_tree(T,cur_xmin,cur_xmax, ystart-1,T(position,i),att_key,val_key);  
    
    %fill in line  
    new_xnode = (cur_xmin +cur_xmax)/2;
    new_ynode = ystart -1;
    plot([xnode,new_xnode],[ystart,ystart-1],'r');

    if isempty(val_key)    
      st = num2str(i);
    else      
      st = val_key(n_vals * (T(position,11) -1) + T(position,i),:);
    end
    text(mean([xnode new_xnode]),mean([ynode new_ynode]),st);
    
    cur_xmin = cur_xmin + increment;
  end  
end
