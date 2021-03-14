function [b] = loadBuilder(mesh, f)
    n = length(mesh) - 1;
    b = zeros(n+1, 1);
    for i = 1 : n
        h = mesh(i+1) - mesh(i);
        b(i) = b(i) + f(mesh(i))*h/2;
        b(i+1) = b(i+1) + f(mesh(i+1))*h/2;
    end
end