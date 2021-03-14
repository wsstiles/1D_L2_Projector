% Defines an error object that tracks number of subintervals, number of 
% refinements, as well as various error calculations
%
% @param  refinements := defines the number of entries that will exist in
%                        the error object array
% @return err := the error object that is built
function [err] = projectionError(refinements)
    % Error tolerance object to hold error information for each refinement
    err = struct();
    % Number of subintervals for each refinement
    err.Nvec = zeros(refinements, 1);
    % Step size for the current refinement
    err.h = zeros(refinements, 1);
    % L2, H1, and L-infinity error
    err.L2 = zeros(refinements, 1);
    err.H1 = zeros(refinements, 1);
    err.Linf = zeros(refinements, 1);
end