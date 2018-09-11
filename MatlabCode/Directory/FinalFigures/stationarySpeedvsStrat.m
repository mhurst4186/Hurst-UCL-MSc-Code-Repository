clear
close all
clc

strat = [-1e-2 -1e-1 -1e0 -1e1];
Uback = [ 5.36588e-08 6.86283e-08 7.02953e-08 6.92324e-08];

figure('pos',[10 10 900 600]);
loglog(-strat,Uback,'*-')
hold on
grid on
xlabel('$-\partial\rho / \partial z$ [kg m$^{-4}$]')
ylabel('Wedge Speed [m s$^{-1}$]')
title('Stationary Model Speed vs. Stratification')