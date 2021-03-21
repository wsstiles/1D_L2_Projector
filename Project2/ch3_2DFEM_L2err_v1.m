function [err,name]=ch3_2DFEM_L2err_v1(p,t,f,Pf)
%% L2 error between f and Pf (here Pf is the P1-FEM soln.)
%% P1FEM, corner quadrature rule -- exercise: try midpoint rule.
%% input: p - , ... 
%% output: err - 
%%

name = mfilename;
%%
nt = size(t,2); 
err_local_square = zeros(nt,1);
for k = 1 : nt
    loc2glb = t(1:3,k);
    x = p(1,loc2glb); y = p(2,loc2glb);
    area = polyarea(x,y); 
    diff1 = f([x(1),y(1)]) - Pf(loc2glb(1));
    diff2 = f([x(2),y(2)]) - Pf(loc2glb(2));
    diff3 = f([x(3),y(3)]) - Pf(loc2glb(3));
    err_local_square(k) = (diff1^2 + diff2^2 + diff3^2)/3*area;
end % end of k-loop 
err = sqrt(sum(err_local_square)); 