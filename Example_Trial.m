%% Routine to solve transfer functions for Earth Model
clear

% 5 layers
conductivity = [800, 2000, 1000, 200, 100];
interface_depths = [0, 50, 500, 750, 1050];

C_n = TF_LayeredEarth(conductivity, interface_depths);

% n = length(conductivity); % number of layers
% 
% % magnetic permeability of free space
% mu_0 = 1.2566*10^(-6); % [H m^-1]
% 
% Ccell = cell(n,1);
% 
% % layer n
% q_n = @(omega, n) sqrt(1i*conductivity(n)*mu_0*omega);
% C = @(omega) 1/q_n(omega, n);
% Ccell{n} = C;
% 
% for i = 1:n-1
%     C = @(omega) (1/q_n(omega,n-i))*(q_n(omega,n-i)*C(omega) + ...
%         tanh(q_n(omega,n-i)*(interface_depths(n-i+1) - ...
%         interface_depths(n-i)))/(1 + q_n(omega,n-i)*C(omega)*...
%         tanh(q_n(omega,n-1)*(interface_depths(n-i+1) - ...
%         interface_depths(n-i)))));
%     Ccell{n - i} = C;
% end