function M = ch3_2DFEM_MassAssembler_v1_Stiles(mesh, elements)
    % Total number of nodes in the mesh
    totalNodes = size(mesh, 2);
    % Total number of triangular elements defined on the mesh
    totalElements = size(elements, 2);
    
    % Allocate space for mass matrix
    M = sparse(totalNodes, totalNodes);
    
    % Loop over each element
    for i = 1:totalElements
        % Mapping local element to global element entry
        loc2glb = elements(1:3, i);
        % Node coordinates
        x = mesh(1, loc2glb);
        y = mesh(2, loc2glb);
        
        % Area of the triangular element
        area = polyarea(x, y);
        
        % Current element's mass matrix
        M_local = [2 1 1;
                   1 2 1;
                   1 1 2]/12*area;
        
        % Add element masses to the global mass matrix
        M(loc2glb, loc2glb) = M(loc2glb, loc2glb) + M_local;
    end
end