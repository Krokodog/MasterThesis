function [mPos1,mPos2] = PSO(cfg,grid,x,y,vFieldx,vFieldy,vMap)
%PSO Particle swarm optimazation
%   The variable swarm is used for the normal PSO and swarmV is used for
%   the PSO considering the vectorfield

% Variable to see the differences between a correction and without
setCorrection=1;

% For the contour plot
vxC=vFieldx;
vyC=vFieldy;

% Change the coordinates of the objective function, should be between min
% and max size
uSub=26;
vSub=26;

% Sphere Function
z=(x-uSub).^2 + ( y-vSub).^2;

% Needed if you want to viualize the visited cells.
% normal PSO
mPos1=zeros(grid.xMax,grid.yMax);
% PSO with wind
mPos2=mPos1;

% Initialize the positions of the individuals
for i = 1:cfg.swarmSize
    cfg.swarm(i, 1:7) = randi([1,grid.xMax]);
end
% initial velocity u
cfg.swarm(:, 5)=0;
% initial velocity v
cfg.swarm(:, 6)=0;
cfg.swarm(:, 7)=1000000;

cfg.swarmV = cfg.swarm;


for iter = 1:cfg.iterations
    for i= 1:cfg.swarmSize
        
        % Store the visited cells in mPos1
        tmpPos1x=ceil(cfg.swarm(i,1));
        tmpPos1y=ceil(cfg.swarm(i,2));
        if(tmpPos1x>grid.xMin &&tmpPos1y >grid.yMin && tmpPos1x<=grid.xMax && tmpPos1y<=grid.yMax)
            mPos1(tmpPos1x,tmpPos1y)=mPos1(tmpPos1x,tmpPos1y)+1;
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
        
        % Analogous to the normal PSO
        tmpPos2x=ceil(cfg.swarmV(i,1));
        tmpPos2y=ceil(cfg.swarmV(i,2));
        
        if(tmpPos2x>grid.xMin &&tmpPos2y >grid.yMin && tmpPos2x<grid.xMax && tmpPos2y<grid.yMax)
            mPos2(tmpPos2x,tmpPos2y)=mPos2(tmpPos2x,tmpPos2y)+1;
        end
        
        %x(t+1)=v(t+1)+x(t)
        %with correction
        if((setCorrection==1) && cfg.swarmV(i,1)>=grid.xMin &&cfg.swarmV(i,1)<=grid.xMax &&cfg.swarmV(i,2)>=grid.yMin &&cfg.swarmV(i,2)<=grid.yMax)
            xCor=vMap(round(cfg.swarmV(i,1)+1),round(cfg.swarmV(i,2)+1),1);
            yCor=vMap(round(cfg.swarmV(i,1)+1),round(cfg.swarmV(i,2)+1),2);
        else
            xCor=0;
            yCor=0;
        end

        % Boundary handling. Particles exceeding the boundaries will be set
        % to the min/max value of the grid
        
        if((cfg.swarmV(i,1)+cfg.swarmV(i,5))<grid.xMin)
            %cfg.swarmV(i,1)=randi([0,20]);
            cfg.swarmV(i,1)=grid.xMin;
        elseif((cfg.swarmV(i,1)+cfg.swarmV(i,5))>grid.xMax)
            cfg.swarmV(i,1)=grid.xMax;
        else
            cfg.swarmV(i,1) = cfg.swarmV(i,1)+cfg.swarmV(i,5)+xCor;
        end

        if((cfg.swarmV(i,2)+cfg.swarmV(i,6))<grid.yMin)
           % cfg.swarmV(i,2)=randi([0,20]);
            cfg.swarmV(i,2) = grid.yMin;
        elseif((cfg.swarmV(i,2)+cfg.swarmV(i,6))>grid.yMax)
            cfg.swarmV(i,2) = grid.yMax;
        else
            cfg.swarmV(i,2) = cfg.swarmV(i,2)+cfg.swarmV(i,6)+yCor;
        end
        uVelo = cfg.swarmV(i,1);
        vVelo = cfg.swarmV(i,2);
        
        % Objective function
        valueVelo = (uVelo-uSub)^2 + ( vVelo-vSub)^2;
        if(valueVelo < cfg.swarmV(i,7))
            %update best pos u
            cfg.swarmV(i,3) = cfg.swarmV (i,1);
            %update best pos v
            cfg.swarmV(i,4) = cfg.swarmV (i,2);
            cfg.swarmV(i,7) = valueVelo;
        end
        
    end
    
    %tmp is the value and gbest the index of the globalbest
    [tmp, gbest] = min(cfg.swarm(:,7));
    [tmpV, gbestVelo] = min(cfg.swarmV(:,7));
    gbests(iter)=tmp;
    gbestsV(iter)=tmpV;
    for i= 1:cfg.swarmSize
        %Update v(t+1)
        cfg.swarm(i,5) = rand*cfg.inertia*cfg.swarm(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,3)...
            -cfg.swarm(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,3)-cfg.swarm(i,1));
        cfg.swarm(i,6) = rand*cfg.inertia*cfg.swarm(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,4)...
            -cfg.swarm(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,4)-cfg.swarm(i,2));
        
        
        if(cfg.swarmV(i,1) > grid.xMin && cfg.swarmV(i,1) <=grid.xMax && cfg.swarmV(i,2) > grid.yMin && cfg.swarmV(i,2) <=grid.yMax )
            [uV,vV]=getVector(cfg.swarmV(i,1),cfg.swarmV(i,2),vFieldx,vFieldy,grid);
        else
            uV=0;
            vV=0;
        end
        cfg.swarmV(i,5) = rand*cfg.inertia*cfg.swarmV(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,3)...
            -cfg.swarmV(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,3)-cfg.swarmV(i,1))+uV;
        cfg.swarmV(i,6) = rand*cfg.inertia*cfg.swarmV(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,4)...
            -cfg.swarmV(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,4)-cfg.swarmV(i,2))+vV;
        
    end
    
    % Visualize the searching of the swarm. Can be set in the main script.
    if(cfg.visualizeSteps)
        h1=subplot(2,2,1);
        
        hold on
        contour(x,y,z,20);
        plot(cfg.swarm(:,1),cfg.swarm(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        hold off
        axis equal
        title('Normal PSO not considering the vectorfield')
        
        h2=subplot(2,2,2);
        hold on
        contour(x,y,z,20);
        plot(cfg.swarmV(:,1),cfg.swarmV(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        quiver(x,y,vxC,vyC);
        hold off
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        axis equal
        title('PSO considering the vectorfield')
      
        subplot(2,2,3)
        hold on
        
        plot(iter,tmp,'b*')
        axis([1 cfg.iterations -1 100]);
        
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        %   axis equal
        title('Convergence Plot for PSO')
        
        subplot(2,2,4)
        
        hold on
        plot(iter,tmpV,'b*')
        axis([1 cfg.iterations -1 100]);
        
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        %  axis equal
        title('Convergence Plot for PSO considering PSO')
        
        pause(.2);
        if(iter~=cfg.iterations)
            cla(h1)
            cla(h2)
        end
    end
end

if(~cfg.visualizeSteps)
    visualizeSolution(cfg.swarm,cfg.swarmV,x,y,z,grid.xMin,grid.xMax,grid.yMin,grid.yMax,vxC,vyC,gbests,gbestsV,cfg,uSub,vSub)
end
end

