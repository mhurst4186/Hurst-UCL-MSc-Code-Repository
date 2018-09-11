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

alpha = [0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.14 0.18 0.22 0.26];
names = {'alpha0_02','alpha0_02','alpha0_04','alpha0_05','alpha0_06','alpha0_07',...
    'alpha0_08','alpha0_09','alpha0_10','alpha0_14','alpha0_18','alpha0_22','alpha0_26'};

maindirectory = '../../../ServerCode/09_speed_vs_alpha/Results/';

Uback = zeros(1,length(alpha));
U = zeros(1,length(alpha));

for k = 1:length(names)
    directory = [maindirectory names{k} '/'];
    [Uback(k), U(k)] = analyzeRun(directory);
end

f1 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(atand(alpha),Uback,'*-')
xlabel('Wedge Angle $\theta$')
ylabel('Wedge Speed [m s$^{-1}$]')
title('Steady Speed vs. Wedge Angle')
saveas(f1,[maindirectory 'speed_vs_alpha_dim2'],'epsc')

f2 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(atand(alpha),U,'*-')
xlabel('Wedge Angle $\theta$')
ylabel('Non-dimensional Wedge Speed')
title('Steady Speed (non-dimensional) vs. Wedge Angle')
saveas(f2,[maindirectory 'speed_vs_alpha_nondim2'],'epsc')