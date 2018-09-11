clear
close all
clc

r = [4, 8, 12];

maindirectory='../../../ServerCode/01_mesh_refinement/Results/';

figure
hold on
grid on
legendstr=cell(1,length(r));
for k = 1:length(r)
    fid = fopen([maindirectory 'mesh_' num2str(r(k)) '_' num2str(r(k)) '/force.sol']);
    force = fscanf(fid,'%f');
    plot(force)
    legendstr{k} = ['Refinement: ' num2str(r(k))];
end
legend(legendstr,'Location','Best')
xlabel('Time step')
ylabel('Force')
title('Mesh Refinement Study')