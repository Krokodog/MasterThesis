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
cfg.swarm= zeros(cfg.swarmSize,7);
cfg.individual = 1;
%Display each iteration step
cfg.visualizeSteps =1;

%grid
grid.epsylon=1;
grid.xMin=0;
grid.xMax=20;
grid.yMin=0;
grid.yMax=20;

[matPos1,matPos2,matPos3]=PSO(cfg,grid);
visualizeVisitedPositions(matPos1,matPos2,matPos3);


