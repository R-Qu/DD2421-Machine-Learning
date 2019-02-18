function plot_clearn(pos,neg,gbound,lbound)
% pos : set of positive examples specified by a vector of (x,y)-pairs
% neg : set of negative examples specified by a vector of (x,y)-pairs
% gbound : set of general hypotheses (rectangles)
% specified by a vector of (x_1,y_1,x_2,y_2)-quadruples
% lbound : set of specific hypotheses (rectangles)
% specified by a vector of (x_1,y_1,x_2,y_2)-quadruples
clf;
hold on;
grid on;
axis([-0.5 9.5 -0.5 9.5]);
title('candidate elimination');
set(gca,'ytick',[0 1 2 3 4 5 6 7 8 9]);
set(gca,'xtick',[0 1 2 3 4 5 6 7 8 9]);

[n,m]=size(gbound);
if (n>0)
gbound_(:,1)=min(gbound(:,1),gbound(:,3))-0.1;
gbound_(:,2)=min(gbound(:,2),gbound(:,4))-0.1;
gbound_(:,3)=abs(gbound(:,1)-gbound(:,3))+0.2;
gbound_(:,4)=abs(gbound(:,2)-gbound(:,4))+0.2;
end
for i=1:n
r=rectangle('Position',gbound_(i,:),'LineWidth',3,'EdgeColor','g');
end

[n,m]=size(lbound);
if (n>0)
lbound_(:,1)=min(lbound(:,1),lbound(:,3))-0.1;
lbound_(:,2)=min(lbound(:,2),lbound(:,4))-0.1;
lbound_(:,3)=abs(lbound(:,1)-lbound(:,3))+0.2;
lbound_(:,4)=abs(lbound(:,2)-lbound(:,4))+0.2;
end
for i=1:n
  r=rectangle('Position',lbound_(i,:),'LineWidth',3,'EdgeColor','c');
end

[n,m]=size(pos);
for i=1:n
  h=plot(pos(i,1),pos(i,2),'r+','MarkerSize',20);
end

[n,m]=size(neg);
for i=1:n
  h=plot(neg(i,1),neg(i,2),'bo','MarkerSize',20);
end
hold off;
return

