close all
clear
clc

% Formular for a basic PSO
% x(t+1)=v(t+1)+x(t)
% v(t+1)=wv(t)+phi1(pi-xi)+phi2(pg-xi)
% w: inertia
% phi1(pi-xi): cognitive component
% phi2(pg-xi): social component

%-----------------------
% Information is saved in a Matrix
% column1:objective function u
% column2:objective function v
% column3:update best position u
% column4:update best position v
% column5:update velocity u
% column6:update velocity v
% column7:best Value
%------------------------

%configuration
cfg.iterations = 50;
cfg.inertia = 1.0;
cfg.accelerationCoefficient = 1.0;
cfg.swarmSize = 20;
cfg.searchSwarmSize = 10;
cfg.swarm= zeros(cfg.swarmSize,7);

%Display each iteration step
cfg.visualizeSteps =0;

%grid
grid.epsylon=1;
grid.xMin=0;
grid.xMax=20;
grid.yMin=0;
grid.yMax=20;

% Construct the grid
x=grid.xMin:grid.epsylon:grid.xMax;
y=grid.yMin:grid.epsylon:grid.yMax;

modeVF=1;

switch modeVF
    case 1
        %constant vectorfield
        vx=-y./y;
        vx(isnan(vx))=-1;
        vy=x./x;
        vy(isnan(vy))=1;
    case 2
        %linear vectorfield
        vx=-y;
        vy=x;
    case 3
        %sincos vectorfield
        vx=sin(y)*0.8;
        vy=cos(x)*0.8;
end


[vMap]=createVectorMap(cfg,grid,vx,vy);
vMap(:,:,1)
vMap(:,:,2)
imagesc(transpose(vMap(:,:,1)))
set(gca,'YDir','normal')

%[matPos1,matPos3]=PSO(cfg,grid,x,y,vx,vy,modeVF);
%visualizeVisitedPositions(matPos1,matPos3);


