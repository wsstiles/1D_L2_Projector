function b = ch3_2DFEM_LoadAssembler_v1_Stiles(mesh, elements, loadf)
    % Total number of nodes in the mesh
    totalNodes = size(mesh, 2);
    % Total number of triangular elements defined on the mesh
    totalElements = size(elements, 2);
    
    % Initialize load vector
    b = zeros(totalNodes, 1);
    
    % Loop through each element
    for i = 1:totalElements
        % Map local element to global element position
        loc2glb = elements(1:3, i);
        % Coordinates
        x = mesh(1, loc2glb);
        y = mesh(2, loc2glb);
        
        % Calculate area of the triangular element
        area = polyarea(x, y);
        
        % Calculate local element load vector
        b_local = [loadf([x(1),y(1)]);
                   loadf([x(2),y(2)]);
                   loadf([x(3),y(3)])]/3*area;
                   
        % Modify global load vector
        b(loc2glb) = b(loc2glb) + b_local;
    end
end