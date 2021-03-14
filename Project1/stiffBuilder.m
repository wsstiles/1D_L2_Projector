% Builds the stiffness matrix for the given nodes
%
% @param nodes := mesh used in construction of the stiffness matrix
%
% @return A := the stiffness matrix after construction
%
function [A] = stiffBuilder(mesh)
    % Number of subintervals
    n = length(mesh) - 1;
    % Stiffness matrix
    A = sparse(n+1, n+1);
    
    % For each subinterval element
    for i = 1 : n
        % Determine the length of the element
        h = mesh(i+1) - mesh(i);
        % Construct the 2x2 matrix and incorporate into the stiffness
        % matrix
        A(i,i) = A(i,i) + 1/h; 
        A(i,i+1) = A(i,i+1) - 1/h;
        A(i+1,i) = A(i+1,i) - 1/h;
        A(i+1,i+1) = A(i+1,i+1) + 1/h;
    end
end