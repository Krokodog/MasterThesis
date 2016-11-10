function [mPos1] = normalPSO(cfg,grid,x,y)
%NORMALPSO Particle swarm optimazation

% Change the coordinates of the objective function, should be between min
% and max size
uSub=11;
vSub=-8;

% Sphere Function
z=(x-uSub).^2 + ( y-vSub).^2;

% Needed if you want to viualize the visited cells.
% normal PSO
mPos1=zeros(abs(grid.xMin)+grid.xMax+1,abs(grid.yMin)+grid.yMax+1);

% Initialize the positions of the individuals
for i = 1:cfg.swarmSize
    cfg.swarm(i, 1:7) = randi([grid.xMin,grid.xMax]);
end
% initial velocity u
cfg.swarm(:, 5)=0;
% initial velocity v
cfg.swarm(:, 6)=0;
cfg.swarm(:, 7)=1000000;

for iter = 1:cfg.iterations
    for i= 1:cfg.swarmSize
        
        % Store the visited cells in mPos1
        tmpPos1x=ceil(cfg.swarm(i,1));
        tmpPos1y=ceil(cfg.swarm(i,2));
        if(tmpPos1x>grid.xMin &&tmpPos1y >grid.yMin && tmpPos1x<=grid.xMax && tmpPos1y<=grid.yMax)
            mPos1(tmpPos1x+abs(grid.xMin)+1,tmpPos1y+abs(grid.yMin)+1)=mPos1(tmpPos1x+abs(grid.xMin)+1,tmpPos1y+abs(grid.yMin)+1)+1;
        end
        
        %x(t+1)=v(t+1)+x(t)
        cfg.swarm(i,1) = cfg.swarm(i,1)+cfg.swarm(i,5);
        cfg.swarm(i,2) = cfg.swarm(i,2)+cfg.swarm(i,6);
        u = cfg.swarm(i,1);
        v = cfg.swarm(i,2);
        % Objective function
        value = (u-uSub)^2 + ( v-vSub)^2;
        if(value < cfg.swarm(i,7))
            %update best pos u
            cfg.swarm(i,3) = cfg.swarm (i,1);
            %update best pos v
            cfg.swarm(i,4) = cfg.swarm (i,2);
            cfg.swarm(i,7) = value;
        end     
    end
    
    %tmp is the value and gbest the index of the globalbest
    [tmp, gbest] = min(cfg.swarm(:,7));
    gbests(iter)=tmp;
    for i= 1:cfg.swarmSize
        %Update v(t+1)
        cfg.swarm(i,5) = rand*cfg.inertia*cfg.swarm(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,3)...
            -cfg.swarm(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,3)-cfg.swarm(i,1));
        cfg.swarm(i,6) = rand*cfg.inertia*cfg.swarm(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,4)...
            -cfg.swarm(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,4)-cfg.swarm(i,2));      
    end
    
    % Visualize the searching of the swarm. Can be set in the main script.
    if(cfg.visualizeSteps)
        h1=subplot(2,1,1);
        hold on
        contour(x,y,z,20);
        plot(cfg.swarm(:,1),cfg.swarm(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        hold off
        axis equal
        title('Normal PSO not considering the vectorfield')        
      
        subplot(2,1,2)
        hold on      
        plot(iter,tmp,'b*')
        axis([1 cfg.iterations -1 100]);
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        title('Convergence Plot for PSO')
    
        pause(.2);
        if(iter~=cfg.iterations)
            cla(h1)
        end
    end
end

if(~cfg.visualizeSteps)
    visualizeSolution(cfg.swarm,0,x,y,z,grid.xMin,grid.xMax,grid.yMin,grid.yMax,0,0,gbests,0,cfg,uSub,vSub)
end

end

