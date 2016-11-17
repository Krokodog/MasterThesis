function [mPos2] = velPSO(cfg,grid,x,y,vFieldx,vFieldy,vMap)
%VELPSO Particle swarm optimazation considering the vector field

% Variable to see the differences between a correction and without
% Using the correction-value of the explorer-population
setCorrection=0;

% Full information of the vector field
setFullInformation=1;

% For the contour plot
vxC=vFieldx;
vyC=vFieldy;

% Change the coordinates of the objective function, should be between min
% and max size
uSub=10;
vSub=5;

% Sphere Function
z=(x-uSub).^2 + ( y-vSub).^2;

% PSO with wind
mPos2=zeros(abs(grid.xMin)+grid.xMax+1,abs(grid.yMin)+grid.yMax+1);

% Initialize the positions of the individuals
for i = 1:cfg.swarmSize
    cfg.swarm(i, 1:7) = randi([grid.xMin,grid.xMax]);
end
% initial velocity u
cfg.swarm(:, 5)=0;
% initial velocity v
cfg.swarm(:, 6)=0;
cfg.swarm(:, 7)=1000000;

cfg.swarmV = cfg.swarm;


for iter = 1:cfg.iterations
    for i= 1:cfg.swarmSize
        
        tmpPos2x=ceil(cfg.swarmV(i,1));
        tmpPos2y=ceil(cfg.swarmV(i,2));
        
        if(tmpPos2x>grid.xMin &&tmpPos2y >grid.yMin && tmpPos2x<grid.xMax && tmpPos2y<grid.yMax)
            mPos2(tmpPos2x+abs(grid.xMin)+1,tmpPos2y+abs(grid.yMin)+1)=mPos2(tmpPos2x+abs(grid.xMin)+1,tmpPos2y+abs(grid.yMin)+1)+1;
        end
        
        %x(t+1)=v(t+1)+x(t)
        %with correction
        if((setCorrection==1) && cfg.swarmV(i,1)>=grid.xMin &&cfg.swarmV(i,1)<=grid.xMax &&cfg.swarmV(i,2)>=grid.yMin &&cfg.swarmV(i,2)<=grid.yMax)
            xCor=vMap(round(cfg.swarmV(i,2)+abs(grid.yMin)+1),round(cfg.swarmV(i,1)+abs(grid.xMin)+1),1);
            yCor=vMap(round(cfg.swarmV(i,2)+abs(grid.yMin)+1),round(cfg.swarmV(i,1)+abs(grid.xMin)+1),2);
            cfg.swarmV(i,5)= cfg.swarmV(i,5) -xCor;
            cfg.swarmV(i,6)= cfg.swarmV(i,6) -yCor;
        end
        
        if((setFullInformation==1) && cfg.swarmV(i,1)>=grid.xMin &&cfg.swarmV(i,1)<=grid.xMax &&cfg.swarmV(i,2)>=grid.yMin &&cfg.swarmV(i,2)<=grid.yMax)
            [xCor,yCor]=getVector(cfg.swarmV(i,1),cfg.swarmV(i,2),vFieldx,vFieldy,grid);
             cfg.swarmV(i,5)= cfg.swarmV(i,5) -xCor;
             cfg.swarmV(i,6)= cfg.swarmV(i,6) -yCor;
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
    
%     %tmp is the value and gbest the index of the globalbest
    [tmpV, gbestVelo] = min(cfg.swarmV(:,7));
    gbestsV(iter)=tmpV;
    for i= 1:cfg.swarmSize
        %Update v(t+1)
        if(cfg.swarmV(i,1) > grid.xMin && cfg.swarmV(i,1) <=grid.xMax && cfg.swarmV(i,2) > grid.yMin && cfg.swarmV(i,2) <=grid.yMax )
            [uV,vV]=getVector(cfg.swarmV(i,1),cfg.swarmV(i,2),vFieldx,vFieldy,grid);
        else
            uV=0;
            vV=0;
        end
        cfg.swarmV(i,5) = rand*cfg.inertiaep*cfg.swarmV(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,3)...
            -cfg.swarmV(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,3)-cfg.swarmV(i,1))+uV;
        cfg.swarmV(i,6) = rand*cfg.inertiaep*cfg.swarmV(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,4)...
            -cfg.swarmV(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,4)-cfg.swarmV(i,2))+vV;
        
    end
    
    % Visualize the searching of the swarm. Can be set in the main script.
    if(cfg.visualizeSteps)
 
        h1=subplot(2,1,1);
 
        hold on
        contour(x,y,z,20);
        plot(cfg.swarmV(:,1),cfg.swarmV(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        quiver(x,y,vxC,vyC);
        hold off
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        axis equal
        title('PSO considering the vectorfield')
        
        subplot(2,1,2)        
        hold on
        plot(iter,tmpV,'b*')
        axis([1 cfg.iterations -1 100]);
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        title('Convergence Plot for PSO considering PSO')
        
        pause(.2);
        if(iter~=cfg.iterations)
            cla(h1)
        end
    end
end

if(cfg.showSolution)
    visualizeSolution(0,cfg.swarmV,x,y,z,grid.xMin,grid.xMax,grid.yMin,grid.yMax,vxC,vyC,0,gbestsV,cfg,uSub,vSub)
end
end


