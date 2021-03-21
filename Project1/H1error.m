% Calculates the H1 error
function [err] = H1error(mesh, uprime, u)
    n = length(mesh) - 1;
    err_local_square = zeros(n,1);
    for i = 1 : n
        h = mesh(i+1) - mesh(i);
        Du = ( -u(i) + u(i + 1)) / h;
        diff_p1 = (uprime(mesh(i)) - Du)^2;
        diff_p2 = (uprime(mesh(i + 1)) - Du)^2;
        err_local_square(i) = (diff_p1 + diff_p2) * h/2;
    end
    err = sqrt(sum(err_local_square));
end