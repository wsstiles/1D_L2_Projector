function o=ch3_2DFEM_L2Projection_main(option)
%% 2D P1-FEM: L2 projection 
% main function: solve Poisson's eqn.
%    Phf \in V_h: (Phf, v) = (f, v), \forall v \in V_h 
% input:
%     option: setting 
% output:
%     o: ... 
% subroutines (m-files) used: (total 7 m-files including main)
%     ch3_2DFEM_L2Projection_option.m
%     ch3_2DFEM_MassAssembler_v1.m
%     ch3_2DFEM_LoadAssembler_v1.m
%     ch3_2DFEM_L2err_v1.m
%     ch3_2DFEM_H1err_v1.m
%     ch3_2DFEM_showrate.m
% Usage: o = ch3_2DFEM_L2Projection_main; 

clear 
close all
TODO = cell(6); nn = 1;
TODO{nn} = 'write a version for 1D P2-FEM: ch2_1D-P2FEM_Poisson_main.m'; nn  = nn + 1;
%% Step 1: pre-processing  
cnt = 1; name = cell(7); name{cnt} = mfilename; 
fprintf('Ch3: 2D P1-FEM -- L2 Projection: %s.m\n', name{cnt}); cnt = cnt + 1; 
if ~exist('option','var'), option = ch3_2DFEM_L2Projection_option; end
% pde setting: domain; load function
pde = option.pde; loadf = pde.loadf; Df = pde.Df; g = pde.geometry; 
name{cnt} = option.name; fprintf('option name: %s.m\n',name{cnt}); cnt = cnt + 1;
fprintf('pde name: %s.m\n',pde.name);
% FEM parameter
h = option.h0max; % initial mesh size  
Nlevel = option.Nlevel; % uniform refinement 
% mesh: p -- 2 * np, e -- 7 * nbe, t -- 4 * nt
[p,e,t] = initmesh(g,'hmax',h);
pdemesh(p,e,t); % view the initial mesh
% initialize err structure
err = struct('DOF',zeros(Nlevel,1), 'h',zeros(Nlevel,1), ...
    'L2',zeros(Nlevel,1), 'H1',zeros(Nlevel,1), 'Linf',zeros(Nlevel,1));

%% Step 2&3: assemble and solve
tic
for i = 1 : Nlevel
    err.DOF(i) = size(p,2); % include bdry DOFs   
    err.h(i) = h/2^(i-1); % uniform refinement ONLY 
    % Assemble the mass matrix M
    [M, name{cnt}] = ch3_2DFEM_MassAssembler_v1(p,t); % _v2,... 
    % Assemble the load vector b
    [f, name{cnt+1}] = ch3_2DFEM_LoadAssembler_v1(p,t,loadf);
    % Solve 
    Pf = M\f; 
    % compute err.L2 and err.H1 if we know the "exact solution"
    [err.L2(i), name{cnt+2}] = ch3_2DFEM_L2err_v1(p,t,loadf,Pf);
    [err.H1(i), name{cnt+3}] = ch3_2DFEM_H1err_v1(p,t,Df,Pf);
    % refine the mesh (uniform refinement) 
    if i < Nlevel % why do we need this?
        [p,e,t] = refinemesh(g,p,e,t);
    end
end
Time.AssembleSolve = toc;
cnt = cnt + 4; % +4 
TODO{nn} = 'write vectorized versions of subroutines in Step 2 and 3'; nn = nn + 1;
TODO{nn} = 'use Gaussian qudrature rules to compute the mass matrix and load vector'; nn = nn + 1;
TODO{nn} = 'test the code for different pde examples'; nn = nn + 1;
TODO{nn} = 'modify the code to show the relative errors in the ERROR table!'; nn = nn + 1;

%% Step 4: post-processing 
% plot picture
figure;
pdesurf(p,t,Pf) % plot the P1-FEM solution
figure; 
Pi_f = loadf(p'); % interpolant 
pdesurf(p,t,Pi_f) % plot the interpolant 
TODO{nn} = 'add lengend, etc to the FEM solution figure'; nn = nn + 1;
% show rate: table and/or figure 
o4 = ch3_2DFEM_showrate(err,option);
name{cnt} = o4.name; cnt = cnt + 1;
o = err;

%% disp Code structure
% also try [fList,pList] = matlab.codetools.requiredFilesAndProducts('ch0_6_main.m');
if option.dispCodeStruct 
    disp(' ')
    disp('Code Structure:')
    L = length(name); fprintf('Main: %s.m\n',name{1});
    for i = 2 : L
        fprintf('      ---- %s.m\n',name{i});
    end
end

disp(' ')
disp('TODO list:')
L = length(TODO); 
for i = 1 : L
    fprintf('    TODO %d: %s\n',i,TODO{i});
end