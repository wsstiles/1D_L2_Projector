function pde = ch3_pde_Ex4
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

% load function: f = sin(2*pi*x*y)
    function f = loadf(p)
        x = p(:,1); y = p(:,2);
        f = sin(2*pi*x.*y); 
    end

% gradient of the load function: 
%  y = [2*pi*y*cos(2*pi*x*y), 2*pi*x*cos(2*pi*x*y)]
    function fprime = Df(p)
        x = p(:,1); y = p(:,2);
        fprime(:,1) = 2*pi*y.*cos(2*pi*x.*y);
        fprime(:,2) = 2*pi*x.*cos(2*pi*x.*y);
    end

% % exact solution: y = 2*sin(pi*x)*sin(2*pi*y)
%     function y = exactu(p)
%         x = p(:,1); y = p(:,2);
%         y = 2*sin(pi*x).*sin(2*pi*y);
%     end

end