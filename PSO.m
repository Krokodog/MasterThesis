function [mPos1,mPos2] = PSO(cfg,grid,x,y,vx,vy,modeVF)
%PSO Summary of this function goes here
%   Detailed explanation goes here

[x,y]=meshgrid(x,y);

% Change the coordinates of the objective function
uSub=17;
vSub=2;

% Sphere Function
z=(x-uSub).^2 + ( y-vSub).^2;

switch modeVF
    case 1
        %uniform vectorfield
        vxC=-y./y;
        vxC(isnan(vxC))=-1;
        vyC=x./x;
        vyC(isnan(vyC))=1;
    case 2
        %linear vectorfield
        vxC=-y;
        vyC=x;
    case 3
        %sincos vectorfield
        vxC=sin(y)*0.8;
        vyC=cos(x)*0.8;
end
% Vectorfield contour grid
%a=sin(y)*0.3;
%b=cos(x)*0.2;



% Visulize the grid cells
%normal
mPos1=zeros(grid.xMax,grid.yMax);
%real
mPos2=mPos1;

% Initialize the cfg.swarm
for i = 1:cfg.swarmSize
    cfg.swarm(i, 1:7) = i;
end
% initial velocity u
cfg.swarm(:, 5)=0;
% initial velocity v
cfg.swarm(:, 6)=0;
cfg.swarm(:, 7)=1000;


cfg.swarmV = cfg.swarm;


for iter = 1:cfg.iterations   
    for i= 1:cfg.swarmSize
        tmpPos1x=ceil(cfg.swarm(i,1));
        tmpPos1y=ceil(cfg.swarm(i,2));
        if(tmpPos1x>0 &&tmpPos1y >0 && tmpPos1x<=20 && tmpPos1y<=20)
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

        tmpPos2x=ceil(cfg.swarmV(i,1));
        tmpPos2y=ceil(cfg.swarmV(i,2));
        
        if(tmpPos2x>0 &&tmpPos2y >0 && tmpPos2x<20 && tmpPos2y<20)
            mPos2(tmpPos2x,tmpPos2y)=mPos2(tmpPos2x,tmpPos2y)+1;
        end
        
        %x(t+1)=v(t+1)+x(t)
        if((cfg.swarmV(i,1)+cfg.swarmV(i,5))<0 ||(cfg.swarmV(i,1)+cfg.swarmV(i,5))>20)
            cfg.swarmV(i,1)=randi([0,20]);
        else
            cfg.swarmV(i,1) = cfg.swarmV(i,1)+cfg.swarmV(i,5);
        end
        if((cfg.swarmV(i,2)+cfg.swarmV(i,6))<0 ||(cfg.swarmV(i,2)+cfg.swarmV(i,6))>20)
            cfg.swarmV(i,2)=randi([0,20]);
        else
            cfg.swarmV(i,2) = cfg.swarmV(i,2)+cfg.swarmV(i,6);
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
    %tmp is the value and gbest the index
    [tmp, gbest] = min(cfg.swarm(:,7));  
    [tmpV, gbestVelo] = min(cfg.swarmV(:,7));
    gbests(iter)=tmp;
    gbestsV(iter)=tmpV;
    for i= 1:cfg.swarmSize
        cfg.swarm(i,5) = rand*cfg.inertia*cfg.swarm(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,3)...
            -cfg.swarm(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,3)-cfg.swarm(i,1));
        cfg.swarm(i,6) = rand*cfg.inertia*cfg.swarm(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,4)...
            -cfg.swarm(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,4)-cfg.swarm(i,2));

        
        if(cfg.swarmV(i,1) > 0 && cfg.swarmV(i,1) <=20 && cfg.swarmV(i,2) > 0 && cfg.swarmV(i,2) <=20 )
            [uV,vV]=getVector(cfg.swarmV(i,1),cfg.swarmV(i,2),vx,vy);
        else
            uV=0;
            vV=0;
        end
        cfg.swarmV(i,5) = rand*cfg.inertia*cfg.swarmV(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,3)...
            -cfg.swarmV(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,3)-cfg.swarmV(i,1))+uV;
        cfg.swarmV(i,6) = rand*cfg.inertia*cfg.swarmV(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarmV(i,4)...
            -cfg.swarmV(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarmV(gbestVelo,4)-cfg.swarmV(i,2))+vV;
        
    end
    
    if(cfg.visualizeSteps)
        %clf
        
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
    visualizeSolution(cfg.swarm,cfg.swarmV,x,y,z,grid.xMin,grid.xMax,grid.yMin,grid.yMax,vxC,vyC,gbests,gbestsV,cfg)
end
end

