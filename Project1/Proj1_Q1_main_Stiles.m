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
        
        % Assemble the stiffness matrix A
        A = stiffBuilder(mesh);
        M = massBuilder(mesh);
        
        % Combine the stiffness matrix and mass matrix and adjust to 
        % maintain the first and last basis function
        A = A + M; 
        A(1,:) = 0;
        A(1,1) = 1;
        A(length(mesh),:) = 0;
        A(length(mesh), length(mesh)) = 1;
        
        % Assemble the load vector b
        b = loadBuilder(mesh, option.pde.loadf);
        % Force the Derichlet boundary conditions
        b(1) = option.pde.leftBC;
        b(length(mesh)) = option.pde.rightBC;
        b(2:length(mesh)) = b(2:length(mesh)) - A(2:length(mesh), 1) * option.pde.leftBC;
        b(1:length(mesh)-1) = b(1:length(mesh)-1) - A(1:length(mesh)-1, length(mesh)) * option.pde.rightBC;
        
        
        % Solve the linear system of equations 
        free_idx = 2 : (length(mesh) - 1);
        approxu = zeros(length(mesh), 1);
        approxu(1) = option.pde.leftBC;
        approxu(length(mesh)) = option.pde.rightBC;
        approxu(free_idx) = A(free_idx, free_idx) \ b(free_idx);
    
        % Plot the approximation from L2 projection against the actual function
        figure;
        plot(mesh, approxu, 'b.')
        hold on 
        Pif = option.pde.exactu(mesh);
        plot(mesh, Pif, 'r-')
        
        % Compute L2 and H1 errors
        err.L2(i) = L2error(mesh, option.pde.exactu, approxu);
        err.H1(i) = H1error(mesh, option.pde.uprime, approxu);
    end
    
    % TODO - Plot the L2 and H1 error
end

