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
cfg.inertia =1;
cfg.accelerationCoefficient = 1.0;
cfg.swarmSize = 30;
cfg.swarm= zeros(cfg.swarmSize,7);
%Search swarm variables
cfg.inertiaep=1;
cfg.searchSwarmSize = 30;
cfg.searchTime=50;

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
vFieldx=x*1/max(x(:));
vFieldy=y*1/max(y(:));

%normalPSO(cfg,grid,x,y);

% Solution of the explorer swarm
[vMap]=createVectorMap(cfg,grid,vFieldy,vFieldx,x,y);
velPSO(cfg,grid,x,y,vFieldy,vFieldx,vMap);


% RECORD DATA AND EXPORT IT TO AN EXCEL-FILE
% filename = 'dataV2NOInfoIW1.xlsx';
% A = {'Algorithm','Swarm size','VMap','Vector field','Optimum','Inertia Weight','Center-X','Center-Y','Computing time not parallel','Deviation-x in %','Deviation-y in %';};
% B={'nPSO','30','no','F(x,y)=(y,x)','(x=-13,y=10)';};
% B2={'vPSO','30 +(30 at 50it )','NO','F(x,y)=(y,x)','(x=-13,y=10)';};
% xlswrite(filename,A,1,'A1')
% xlswrite(filename,B,1,'A2:E1001')
% xlswrite(filename,A,2,'A1')
% xlswrite(filename,B2,2,'A2:E1001')



% dataMatrix=zeros(6);
% dataMatrix2=zeros(6);

% %Simulate 1000 times
% for i=1:1000
% tic
% % Doing PSO
% [matPos1,matPos3,cfg]=PSO(cfg,grid,x,y,vFieldy,vFieldx,vMap);
% time=toc;
% [avgNormal,avgWind]=calcCenter(cfg);
% test1=avgNormal;
% test2=avgWind;
% dataMatrix(i,:)=[cfg.inertia,test1(1),test1(2),time,test1(1)/13*100-100,abs(test1(2))/10*100-100];
% dataMatrix2(i,:)=[cfg.inertiaep,test2(1),test2(2),time,test2(1)/13*100-100,abs(test2(2))/10*100-100];
% end
% xlswrite(filename,dataMatrix,1,'F2:K1001')
% xlswrite(filename,dataMatrix2,2,'F2:K1001')
% disp('FINISHED')
%test1/10
%test2/10


% Shows the correction value of each cell visited by any individual of the
% swarm
% figure
% imagesc(transpose(vMap(:,:,1)))
% set(gca,'YDir','normal')

% Visualizes the visited cells by PSO of the grid
% visualizeVisitedPositions(matPos1,matPos3,grid);

% Three optimization function, which will be used later for testing
% x=-5:0.1:5;
% y=-5:0.1:5;
% ackley(x,y);
% rosenbrock(x,y)
% rastrigin(x,y);

