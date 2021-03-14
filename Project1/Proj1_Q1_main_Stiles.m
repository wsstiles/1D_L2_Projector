function out = Proj1_Q1_main_Stiles(option)
    clear 
    close all
    
    %% Step 1: Pre processing
    if ~exist('option','var')
        option = options();
    end   
    
    % Error tolerance object to hold error information for each refinement
    err = projectionError(option.refinements); 
    
    %% Step 2: Build the mass matrix and the load vector and solve the linear system.
    
    % For every level of refinement
    for i = 1 : option.refinements
        % Double the number of subintervals
        err.Nvec(i) = 2^(i - 1) * option.n;
        % Determine step size
        err.h(i) = (option.pde.b - option.pde.a) / err.Nvec(i);
        
        % Set current state of the mesh
        mesh = linspace(option.pde.a, option.pde.b, err.Nvec(i) + 1)';
        
        % Construct the mass matrix
        M = massBuilder(mesh);

        % Construct the load vector
        b = loadBuilder(mesh, option.pde.loadf);
        
        % Solve the linear system of equations 
        free_idx = 2 : (length(mesh) - 1);
        approxu = ones(length(mesh), 1);
        approxu(free_idx) = M(free_idx, free_idx) \ b(free_idx);
    
        % Plot the approximation from L2 projection against the actual function
        figure;
        plot(mesh, approxu, 'b.')
        hold on 
        Pif = option.pde.loadf(mesh);
        plot(mesh, Pif, 'r-')
        
        % Compute L2 and H1 errors
        err.L2(i) = L2error(mesh, option.pde.exactu, approxu);
        err.H1(i) = H1error(mesh, option.pde.uprime, approxu);
    end
    
    % TODO - Plot the L2 and H1 error
end

