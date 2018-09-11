clear
close all
clc

% plotting specifications
line_width = 2;
font_size  = 18;
mkr_size   = 8;
set(0,'DefaultLineLineWidth' ,line_width);
set(0,'DefaultAxesFontSize'  ,font_size);
set(0,'DefaultLineMarkerSize',mkr_size);
set(0,'defaultTextInterpreter','latex'); %trying to set the default

strat = [-1e-3, -1e-2, -1e-1, -1e0, -1e1, -1e2, -2.5e2, -5e2, -7.5e2, -1e3];
names = {'Strat1e-3','Strat1e-2','Strat1e-1','Strat1e0','Strat1e1','Strat1e2','Strat2_5e2','Strat5e2','Strat7_5e2','Strat1e3'};

maindirectory = '../../../ServerCode/06_speed_vs_strat_sc1000/Results/';

Uback = zeros(1,length(strat));
U = zeros(1,length(strat));

for k = 1:length(names)
    directory = [maindirectory names{k} '/'];
    [Uback(k), U(k)] = analyzeRun(directory);
end

f1 = figure('pos',[10 10 900 600]);
loglog(-strat,Uback,'*-')
hold on
grid on
slopes = log(Uback(2:end)./Uback(1:end-1))./(log(strat(2:end)./strat(1:end-1)));
legend([num2str(min(slopes)) '< slope < ' num2str(max(slopes))],'Location','Best');
xlabel('$-\partial\rho / \partial z$ [kg m$^{-4}$]')
ylabel('Wedge Speed [m s$^{-1}$]')
title('Steady Speed vs. Stratification (Sc = 1000)')
saveas(f1,[maindirectory 'speed_vs_strat_dim2'],'epsc')

f2 = figure('pos',[10 10 900 600]);
loglog(-strat,U,'*-')
hold on
grid on
slopes = log(U(2:end)./U(1:end-1))./(log(strat(2:end)./strat(1:end-1)));
legend([num2str(min(slopes)) '< slope < ' num2str(max(slopes))],'Location','Best');
xlabel('$-\partial\rho / \partial z$ [kg m$^{-4}$]')
ylabel('Nondimensional Wedge Speed')
title('Steady Speed (nondimensional) vs. Stratification (Sc = 1000)')
saveas(f2,[maindirectory 'speed_vs_strat_nondim2'],'epsc')