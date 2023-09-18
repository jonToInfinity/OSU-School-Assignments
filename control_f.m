
function y = control_f(T,t_Set,P,D,I,N)
x = T - t_Set;
if length(x)==1
    
    y= P*x(end);
    
elseif length(x)> 1&& length(x)< N
    
    y= P*x(end) + D*(x(end)- x(end-1)) + I*sum(x);
    
elseif length(x) >= N
    
    y= P*x(end) + D*(x(end)- x(end-1)) + I*sum(x(end-N+1:end));
end
    
end
 
 

