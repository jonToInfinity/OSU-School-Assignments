    function[y] = controlalg(T, T_set, P,I,D,N)
% P = proportional to current error
% I = proportional to integral of last several errors
% D = proportional to difference between last two error values
x = T-T_set;
if length(x) == 1
    y = P*x(end);
    
elseif length(x)>1&length(x)<N
        y = P*x(end)+ D*(x(end)-x(end-1))+I*sum(x);
        
elseif length(x)>=N
            y = P*x(end)+ D*(x(end)-x(end-1))+I*sum(x(end-N+1:end));
%else y = P*x(end)+I*sum(x)
end
end