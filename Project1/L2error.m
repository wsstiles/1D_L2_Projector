% Calculates the L2 error of a given mesh approximation against the exact
% function.
function [err] = L2error(mesh, exact, approx)
    n = length(mesh) - 1;
    err_local_square = zeros(n,1);
    for i = 1 : n
        h = mesh(i+1) - mesh(i);
        diff_p1 = ( exact(mesh(i)) - approx(i) )^2;
        diff_p2 = ( exact(mesh(i + 1)) - approx(i + 1) )^2;
        err_local_square(i) = (diff_p1 + diff_p2) * h/2;
    end
    err = sqrt(sum(err_local_square));
end