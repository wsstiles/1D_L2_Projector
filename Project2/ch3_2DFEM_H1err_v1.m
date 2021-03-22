function [err,name]=ch3_2DFEM_H1err_v1(p,t,Df,Pf)
%% H1 error between f and Pf (here Pf is the P1-FEM soln.)
%% P1FEM, corner quadrature rule -- think about why.
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
    %area = polyarea(x,y); 
    [area,b,c] = HatGradients(x,y); %% see Ch.4
    Dphi = zeros(3,2); % gradient of the nodal basis function
    Dphi(1,:) = [b(1),c(1)]; Dphi(2,:) = [b(2),c(2)]; Dphi(3,:) = [b(3),c(3)]; 
    DPf = Pf(loc2glb(1))*Dphi(1,:) + Pf(loc2glb(2))*Dphi(2,:) ...
        + Pf(loc2glb(3))*Dphi(3,:); % notice that this is the constant since we are using P1-FEM
    diff1 = Df([x(1),y(1)]) - DPf; % 1*2
    diff2 = Df([x(2),y(2)]) - DPf;
    diff3 = Df([x(3),y(3)]) - DPf;
    err_local_square(k) = sum(diff1.^2 + diff2.^2 + diff3.^2,2)/3*area;
end % end of i-loop 
err = sqrt(sum(err_local_square)); 

function [area,b,c]=HatGradients(x,y)
% comments
area = polyarea(x,y);
b = [y(2) - y(3); y(3) - y(1); y(1) - y(2)]/2/area; % 3*1
c = [x(3) - x(2); x(1) - x(3); x(2) - x(1)]/2/area; % 3*1
end
end