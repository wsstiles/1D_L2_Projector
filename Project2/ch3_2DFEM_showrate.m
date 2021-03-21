function o=ch3_2DFEM_showrate(err,option)
%%
% ...
%%

%
o = struct('name',mfilename);

%% table 
level = [1:option.Nlevel]';
rate.L2 = zeros(option.Nlevel,1); rate.H1 = zeros(option.Nlevel,1);
for j = 2 : option.Nlevel
    rate.L2(j) = log(err.L2(j-1)/err.L2(j))/log(2);
    rate.H1(j) = log(err.H1(j-1)/err.H1(j))/log(2);
end
disp(' ')
disp('----- with exact solution -----') 
disp(' ')
Table = table(level, err.L2, rate.L2, err.H1, rate.H1, ...
    'VariableNames',{'level','errL2','rateL2','errH1','rateH1'});
disp(Table)

%% figure
idx_start = 2; % change here if necessary 
figure;
loglog(err.h(idx_start:end),err.L2(idx_start:end),'o-r', ...
    err.h(idx_start:end),err.H1(idx_start:end),'s-b', ...
    err.h(idx_start:end),3*err.h(idx_start:end).^2,'k-', ...
    err.h(idx_start:end),50*err.h(idx_start:end),'g-');
legend('L2 error', 'H1 error', 'O(h^2)', 'O(h)')
xlabel('h'); ylabel('errors');