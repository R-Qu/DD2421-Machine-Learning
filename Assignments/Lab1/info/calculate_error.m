function [err] = calculate_error(T,data)
[n,m]=size(data);
cerr=trace_err(T,data);
[t_size,dummy]=size(cerr);
err=cerr(t_size,3)/n;
