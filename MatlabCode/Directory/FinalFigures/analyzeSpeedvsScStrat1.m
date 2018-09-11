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

Sc = [1 5 10 50 100 500 1000 1500 2000 2500 3000];
names = {'Sc1','Sc5','Sc10','Sc50','Sc100','Sc500','Sc1000','Sc1500','Sc2000','Sc2500','Sc3000'};
maindirectory = '../../../ServerCode/07_speed_vs_sc_strat1/Results/';

Uback = zeros(1,length(Sc));
U = zeros(1,length(Sc));

for k = 1:length(names)
    directory = [maindirectory names{k} '/'];
    [Uback(k), U(k)] = analyzeRun(directory);
end

f1 = figure('pos',[10 10 900 600]);
plot(Sc,Uback,'*-')
hold on
grid on
xlabel('Schmidt Number')
ylabel('Wedge Speed [m s$^{-1}$]')
title('Steady Speed vs. Schmidt Number ($\partial\rho / \partial z = -1$ [kg m$^{-4}$])')
saveas(f1,[maindirectory 'speed_vs_sc_dim2'],'epsc')

f2 = figure('pos',[10 10 900 600]);
plot(Sc,U,'*-')
hold on
grid on
xlabel('Schmidt Number')
ylabel('Non-dimensional Wedge Speed')
title('Steady Speed (non-dimensional) vs. Schmidt Number ($\partial\rho / \partial z = -1$ [kg m$^{-4}$])')
saveas(f2,[maindirectory 'speed_vs_sc_nondim2'],'epsc')