function [e] = entropy(data)

[n_examples] = max(size(data));

e = 0;

p1 = sum(data) / n_examples;
p2 = 1 - p1;

if (p1 == 0) | (p1 == 1)
  e = 0;
else  
  e = (0-p1) * log2(p1) + (0-p2) * log2(p2);
end

