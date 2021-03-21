function option=ch3_2DFEM_L2Projection_option
%% ...
% ...
%%

option = struct();
option.name = mfilename;%('fullpath');
option.pde = ch3_pde_Ex1; % include the load function
option.h0max = 1; % initial mesh size, change here if necessary 
option.dispCodeStruct = true; % false 
option.Nlevel = 6; % number of refinements = Nlevel - 1