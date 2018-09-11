clear
close all
clc

size = [20 10; 10 5; 5 2.5; 2 1; 1 0.5];

maindirectory='../../../ServerCode/02_domain_size/Results/';

figure
hold on
grid on
legendstr=cell(1,length(size(:,1)));
for k = 1:length(size(:,1))
    fid = fopen([maindirectory 'size_' num2str(size(k,1)) '_' num2str(size(k,2)) '/force.sol']);
    force = fscanf(fid,'%f');
    plot(force)
    legendstr{k} = ['Size: ' num2str(size(k,1)) ' x ' num2str(size(k,2))];
end
legend(legendstr,'Location','Best')
xlabel('Time step')
ylabel('Force')
title('Domain Size Study')