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
cfg.iterations = 25;
cfg.inertia = 1;
cfg.accelerationCoefficient = 1.0;
cfg.swarmSize = 30;
cfg.swarm= zeros(cfg.swarmSize,7);
%Search swarm variables
cfg.inertiaep=1;
cfg.searchSwarmSize = 30;
cfg.searchTime=100;

%Display each iteration step
cfg.visualizeSteps =0;

%grid
grid.epsylon=1;
grid.xMin=-15;
grid.xMax=15;
grid.yMin=-15;
grid.yMax=15;

% Construct the grid
x=grid.xMin:grid.epsylon:grid.xMax;
y=grid.yMin:grid.epsylon:grid.yMax;
[x,y]=meshgrid(x,y);

% %reduce strength of field / normalize
vFieldx=-x/max(x(:));
vFieldy=y/max(y(:));

%quiver(x,y,vFieldx,vFieldy);

% Solution of the explorer swarm
[vMap]=createVectorMap(cfg,grid,vFieldy,vFieldx,x,y);

test1=0;
test2=0;
% Doing PSO
for i=1:10
[matPos1,matPos3,cfg]=PSO(cfg,grid,x,y,vFieldy,vFieldx,vMap);
[avgNormal,avgWind]=calcCenter(cfg);
test1=test1+avgNormal;
test2=test2+avgWind;
end
test1/10
test2/10
% Shows the correction value of each cell visited by any individual of the
% swarm
figure
imagesc(transpose(vMap(:,:,1)))
set(gca,'YDir','normal')

% Visualizes the visited cells by PSO of the grid
% visualizeVisitedPositions(matPos1,matPos3,grid);

% Three optimization function, which will be used later for testing
% x=-5:0.1:5;
% y=-5:0.1:5;
% ackley(x,y);
% rosenbrock(x,y)
% rastrigin(x,y);

