%% Routine to solve transfer functions for layered Earth Model
clear; clf; close all;

% 5 layers
conductivity = [10^(-3.5), 10^(-3), 10^(-2.5), 10^(-1.5), 10^(-1)];
interface_depths = [0, 50, 500, 750, 1050];

[C_n, ares] = TF_LayeredEarth(conductivity, interface_depths);

T = logspace(-3,3);
rho = ares{1};
C = C_n{1};

figure(1)
subplot(2,1,1)
hold on
for i = 1:length(T)
    plot(T(i), rho(period_2_freq(T(i))),'*r')
end
hold off
ylabel('Apparent Resistivity [\Omega m]')
xlabel('Period [s]')
set(gca,'XScale','log')
set(gca,'YScale','log')
set(gca,'YLim',[10,10^4])

subplot(2,1,2)
hold on
for i = 1:length(T)
    plot(T(i), rad2deg(C_2_phi(C(period_2_freq(T(i))))), '*b')
end
yline(45,'--k')
hold off
xlabel('Period [s]')
ylabel('Degrees [^{\circ}]')
set(gca,'XScale','log')
set(gca,'YLim',[0, 90])