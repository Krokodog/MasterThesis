close all
clear
clc

% Formular for a basic PSO
% x(t+1)=v(t+1)+x(t)
% v(t+1)=wv(t)+phi1(pi-xi)+phi2(pg-xi)
% w: inertia weight
% phi1(pi-xi): cognitive component
% phi2(pg-xi): social component

%-----------------------
% Information is saved in a matrix
% column1:objective function u
% column2:objective function v
% column3:update best position u
% column4:update best position v
% column5:update velocity u
% column6:update velocity v
% column7:best Value
%------------------------

%configuration
%PSO variables
cfg.iterations = 50;
cfg.inertia = 1;
cfg.accelerationCoefficient = 1.0;
cfg.swarmSize = 20;
cfg.swarm= zeros(cfg.swarmSize,7);
%Search swarm variables
cfg.searchSwarmSize = 20;
cfg.searchTime=100;

%Display each iteration step
cfg.visualizeSteps =0;

%grid
grid.epsylon=1;
grid.xMin=0;
grid.xMax=29;
grid.yMin=0;
grid.yMax=29;

% Construct the grid
x=grid.xMin:grid.epsylon:grid.xMax;
y=grid.yMin:grid.epsylon:grid.yMax;
[x,y]=meshgrid(x,y);
vFieldx=x;
vFieldy=y;

% How many vector field in x and y direction. Size of the grid must be
% divisible by the number of patches
vPatchSize=6;

%TODO optimize randomly generated vectorfield patches.Sometimes strange
%behavior of the swarm. Check it.

% Randomly generates a steady vectorfield for each patch. Force is between 
% -(random value of range[0,1]+0,5)+ random value of range[0,1]+0,5)
% just to avoid fields with 0 velocity
for i=1:(grid.xMax+1)/vPatchSize:grid.xMax
    for j=1:(grid.yMax+1)/vPatchSize:grid.yMax
    vFieldx(i:i+(grid.xMax+1)/vPatchSize-1,j:j+(grid.yMax+1)/vPatchSize-1) =-(rand+0.5)*+(rand+0.5);
    vFieldy(i:i+(grid.xMax+1)/vPatchSize-1,j:j+(grid.yMax+1)/vPatchSize-1) =-(rand+0.5)*+(rand+0.5);
    end
end

% Solution of the explorer swarm
[vMap]=createVectorMap(cfg,grid,vFieldx,vFieldy);

% Doing PSO
[matPos1,matPos3]=PSO(cfg,grid,x,y,vFieldx,vFieldy,vMap);

% Visualizes the visited cells by PSO of the grid
%visualizeVisitedPositions(matPos1,matPos3,grid);

% Shows the correction value of each cell visited by any individual of the
% swarm
figure
imagesc(transpose(vMap(:,:,1)))
set(gca,'YDir','normal')

% Three optimization function, which will be used later for testing
% x=-5:0.1:5;
% y=-5:0.1:5;
% ackley(x,y);
% rosenbrock(x,y)
% rastrigin(x,y);

