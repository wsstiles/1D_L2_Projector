function option = options()
    % Initialize the options object
    option = struct();
    % Define the pde
    option.pde = pde();
    % Number of subintervals
    option.n = 10;
    % Number of refinements
    option.refinements = 10;
end