function [Ubackfinal, Ufinal] = analyzeRun(directory)

meshfile = [directory 'Th.msh'];
visc1file = [directory 'visc1.sol'];
visc2file = [directory 'visc2.sol'];
pressurefile = [directory 'p.sol'];
rhofile = [directory 'rho.sol'];
forcefile = [directory 'force.sol'];
resultsfile = [directory 'results.sol'];

fidresults = fopen(resultsfile);
results = fscanf(fidresults,'%s\n');
idUback = strfind(results,'Ubackground:');
idU = strfind(results,'U:');
idpressure = strfind(results,'pressureforce:');
idviscous = strfind(results,'viscousforce:');
idforce = strfind(results,'force:');
idforce = idforce(3:3:end);

numiters = length(idUback);
Ubacks = zeros(1,numiters);
Us = zeros(1,numiters);
pressures = zeros(1,numiters);
viscouss = zeros(1,numiters);
forces = zeros(1,numiters);

for k = 1:numiters
    Ubacks(k) = str2double(results(idUback(k)+12:idU(k)-1));
    temp = results(idU(k)+2:idU(k)+18);
    idtime = strfind(temp,'timeiter');
    Us(k) = str2double(temp(1:idtime-1));
    pressures(k) = str2double(results(idpressure(k)+14:idviscous(k)-1));
    viscouss(k) = str2double(results(idviscous(k)+13:idforce(k)-1));
    if k == numiters
        forces(k) = str2double(results(idforce(k)+6:end));
    else  
        temp = results(idforce(k)+6:idforce(k)+50);
        idhash = strfind(temp,'#');
        forces(k) = str2double(temp(1:idhash(1)-1));
    end
end

Ubackfinal = Ubacks(end);
Ufinal = Us(end);
[Ubacks,I] = sort(Ubacks);
Us = Us(I);
pressures = pressures(I);
viscouss = viscouss(I);
forces = forces(I);

f8 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(Ubacks,forces,'*-')
plot(Ubacks,pressures,'*-')
plot(Ubacks,viscouss,'*-')
xlabel('Background Velocity [m s$^{-1}$]')
ylabel('Force')
title('Finding Zero Net Force')
legend('Net','Pressure','Viscous','Location','Best')
saveas(f8,[directory 'finding_zero'],'epsc')

fidforce = fopen(forcefile);
force = fscanf(fidforce,'%f');

f7 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(force)
xlabel('Time step')
ylabel('Force')
title('Solution Convergence')
saveas(f7,[directory 'force_convergence'],'epsc')

fidmesh = fopen(meshfile,'r');
firstline = fgetl(fidmesh);
A = sscanf(firstline,'%f');
numvertices = A(1);

A = fscanf(fidmesh,'%f',[3 numvertices]);
x = A(1,:);
y = A(2,:);
ident = A(3,:);
onborder = (ident == 99);

fidvisc1 = fopen(visc1file,'r');
fgetl(fidvisc1); % get rid of the first line
visc1 = fscanf(fidvisc1,'%f');

fidvisc2 = fopen(visc2file,'r');
fgetl(fidvisc2); % get rid of the first line
visc2 = fscanf(fidvisc2,'%f');

fidp = fopen(pressurefile,'r');
fgetl(fidp); % get rid of the first line
p = fscanf(fidp,'%f');

fidrho = fopen(rhofile,'r');
fgetl(fidrho); % get rid of the first line
rho = fscanf(fidrho,'%f');

x = x(onborder);
y = y(onborder);
visc1 = visc1(onborder);
visc2 = visc2(onborder);
p = p(onborder);
rho = rho(onborder);

theta = atan(max(y)/(max(x)-min(x)));

back = (x==-1);
topcorner = (y==max(y));
bottomcorner = (y==min(y));

xback = x(back);
yback = y(back);
visc1back = visc1(back);
visc2back = visc2(back);
pback = p(back);
rhoback = rho(back);

x = x((~back)|topcorner|bottomcorner);
y = y((~back)|topcorner|bottomcorner);
visc1 = visc1((~back)|topcorner|bottomcorner);
visc2 = visc2((~back)|topcorner|bottomcorner);
p = p((~back)|topcorner|bottomcorner);
rho = rho((~back)|topcorner|bottomcorner);

top = (y>=0);
bottom = (y<=0);

xtop = x(top);
ytop = y(top);
visc1top = visc1(top);
visc2top = visc2(top);
visctop = visc1top*(-sin(theta))+visc2top*(-cos(theta));
ptop = p(top);
rhotop = rho(top);

ybottom = y(bottom);
xbottom = x(bottom);
visc1bottom = visc1(bottom);
visc2bottom = visc2(bottom);
viscbottom = visc1bottom*(-sin(theta))+visc2bottom*cos(theta);
pbottom = p(bottom);
rhobottom = rho(bottom);

[xtop,I] = sort(xtop);
ytop = ytop(I);
visctop = visctop(I);
ptop = ptop(I);
viscforcetop = -sec(theta)*trapz(xtop(2:end-1),visctop(2:end-1));
pressureforcetop = -sec(theta)*trapz(xtop,ptop)*sin(theta);
rhotop = rhotop(I);

[xbottom,I] = sort(xbottom);
ybottom = ybottom(I);
viscbottom = viscbottom(I);
pbottom = pbottom(I);
viscforcebottom = -sec(theta)*trapz(xbottom(2:end-1),viscbottom(2:end-1));
pressureforcebottom = -sec(theta)*trapz(xbottom,pbottom)*sin(theta);
rhobottom = rhobottom(I);

f1 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(xtop(2:end-1),-visctop(2:end-1));
plot(xbottom(2:end-1),-viscbottom(2:end-1));
title('Horizontal Component of Viscous Stress (sloping surfaces)')
xlabel('x-coordinate')
ylabel('Viscous Stress')
legend('Top','Bottom','Location','Best')
saveas(f1,[directory 'visc_slope'],'epsc')

f2 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(xtop(2:end-1),ptop(2:end-1));
plot(xbottom(2:end-1),pbottom(2:end-1));
title('Pressure Distribution (sloping surfaces)')
xlabel('x-coordinate')
ylabel('Pressure')
legend('Top','Bottom','Location','Best')
saveas(f2,[directory 'pressure_slope'],'epsc')

f3 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(xtop(2:end-1),rhotop(2:end-1));
plot(xbottom(2:end-1),rhobottom(2:end-1));
title('Density Distribution (sloping surfaces)')
xlabel('x-coordinate')
ylabel('Density')
legend('Top','Bottom','Location','Best')
saveas(f3,[directory 'rho_slope'],'epsc')

[yback,I] = sort(yback);
xback = xback(I);
visc1back = visc1back(I);
pback = pback(I);
viscforceback = -trapz(yback,visc1back);
pressureforceback = trapz(yback,pback);
rhoback = rhoback(I);

f4 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(yback(2:end-1),-visc1back(2:end-1))
title('Horizontal Component of Viscous Stress (back surface)')
xlabel('z-coordinate')
ylabel('Viscous stress')
saveas(f4,[directory 'visc_back'],'epsc')

f5 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(yback(2:end-1),pback(2:end-1))
title('Pressure Distribution (back surface)')
xlabel('z-coordinate')
ylabel('Pressure')
saveas(f5,[directory 'pressure_back'],'epsc')

f6 = figure('pos',[10 10 900 600]);
hold on
grid on
plot(yback(2:end-1),rhoback(2:end-1))
title('Density Distribution (back surface)')
xlabel('z-coordinate')
ylabel('Density')
saveas(f6,[directory 'rho_back'],'epsc')

viscforce = viscforcetop+viscforcebottom+viscforceback;
pressureforce = pressureforcetop+pressureforcebottom+pressureforceback;

fid = fopen([directory 'matlabresults.txt'],'w');
fprintf(fid,'Viscous forces:\n');
fprintf(fid,'Top: %f\n',viscforcetop);
fprintf(fid,'Bottom: %f\n',viscforcebottom);
fprintf(fid,'Back: %f\n',viscforceback);
fprintf(fid,'Total: %f\n\n',viscforce);

fprintf(fid,'Pressure forces:\n');
fprintf(fid,'Top: %f\n',pressureforcetop);
fprintf(fid,'Bottom: %f\n',pressureforcebottom);
fprintf(fid,'Back: %f\n',pressureforceback);
fprintf(fid,'Total: %f\n\n',pressureforce);

fprintf(fid,'Net force: %f\n',viscforce+pressureforce);

