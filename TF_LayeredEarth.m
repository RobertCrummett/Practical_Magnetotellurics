function [C_n] = TF_LayeredEarth(conductivity,interface_depths)
% Calculates transfer functions for a layered half space
%
% Input arguments:
% conductivity - The conductivity of each layer. [S m^-1]
%                n layers total
% interface_depths - The depth to each layer interface. [m]
%                    n layer interfaces total, including the 0m surface
%                    interface.
%
% For both input arguments, the inputs should be structured as collumn
% vecotrs with n inputs. Index one should be the top layer/surface contact
% respectively. The last index is the final halfspace/final contact.
%
% Output:
% C_n - The Schmucker-Weidelt transfer function for the top of each layer 
%       solved by Wait's recursion method. [m]
%       Output is returned as a cell. One for each contact interface,
%       including the surface interface, there is a transfer function
%       given as the function of omega, a specific angular frequency.
%       C_n{1} is the surface contact transfer function.
%       C_n{end} is the final contact transfer function.

n = length(conductivity); % number of layers

% magnetic permeability of free space
mu_0 = 1.2566*10^(-6); % [H m^-1]

% preallocating output cell
C_n = cell(n,1);

% layer n, a homogenous half space
q_n = @(omega, n) sqrt(1i*conductivity(n)*mu_0*omega);
C = @(omega) 1/q_n(omega, n);
C_n{n} = C;

% layer n-1 through 1, by Wait's recursion method
for i = 1:n-1
    C = @(omega) (1/q_n(omega,n-i))*(q_n(omega,n-i)*C(omega) + ...
        tanh(q_n(omega,n-i)*(interface_depths(n-i+1) - ...
        interface_depths(n-i)))/(1 + q_n(omega,n-i)*C(omega)*...
        tanh(q_n(omega,n-1)*(interface_depths(n-i+1) - ...
        interface_depths(n-i)))));
    C_n{n - i} = C;
end

end
