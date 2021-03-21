function pde = ch3_pde_Ex2
%% Define the domain, load function, etc 
%% imput: ...
%% output: ...

%%
pde = struct('name',mfilename,...
    'geometry',geometry,...
    'loadf',@loadf,'Df',@Df); %'exactu',@exactu,'uprime',@uprime);

% geometry, domain def. 
    function g = geometry()
        g = [2 2 2 2
             0 1 1 0
             1 1 0 0
             0 0 1 1
             0 1 1 0
             1 1 1 1
             0 0 0 0];
    end

% load function: f = x*y
    function f = loadf(p)
        x = p(:,1); y = p(:,2);
        f = x.*y; 
    end

% gradient of the load function: 
%  Df = [y, x]
    function fprime = Df(p)
        x = p(:,1); y = p(:,2);
        fprime(:,1) = y;
        fprime(:,2) = x;
    end

end