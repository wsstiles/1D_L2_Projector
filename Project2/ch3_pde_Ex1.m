function pde = ch3_pde_Ex1
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

% load function: f = x
    function f = loadf(p)
        x = p(:,1); y = p(:,2);
        f = x; 
    end

% gradient of the load function: 
%  y = [1, 0]
    function fprime = Df(p)
        x = p(:,1); y = p(:,2);
        fprime(:,1) = 1;
        fprime(:,2) = 0;
    end

end