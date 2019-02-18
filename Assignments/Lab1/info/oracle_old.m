function [o]=oracle(x,y)
if ( (x>=3) & (x<=7) & (y>=2) & (y<=6) )
  fprintf('(%d,%d) is a positive example\n',x,y);
  o=1;
else
   fprintf('(%d,%d) is a negative example\n',x,y);
  o=0;
end 