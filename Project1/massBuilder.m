function [M] = massBuilder(mesh)
    % Number of subintervals
    n = length(mesh) - 1;
    % Predefine mass matrix
    M = sparse(n+1, n+1);
    
    % For every subinterval
    for i = 1 : n
        % Determine subinterval length
        h = mesh(i+1) - mesh(i);
        % Build the local entries in the Mass matrix
        M(i,i) = M(i,i) + h/3;
        M(i,i+1) = M(i,i+1) + h/6;
        M(i+1,i) = M(i+1,i) + h/6;
        M(i+1,i+1) = M(i+1,i+1) + h/3;
    end
end