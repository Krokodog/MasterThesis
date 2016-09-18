function [vMap] = createVectorMap(cfg,grid,vx,vy)
%CREATEVECTORMAP Summary of this function goes here
%   Detailed explanation goes here
%----------------------------------------------
% the searchswarm is half the size of the actual swarm
% column1: posx
% column2: posy
% column3: newposx
% column4: newposy
% column5: update xv
% column6: update yv
cfg.searchSwarm=zeros(cfg.searchSwarmSize,6);
vMap=zeros(grid.xMax+2,grid.yMax+2);

cfg.searchTime=100;

for i=1:cfg.searchSwarmSize
    cfg.searchSwarm(i, 1) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 2) = randi([grid.xMin,grid.xMax]);
end


for time = 1:cfg.searchTime
    for i = 1:cfg.searchSwarmSize
        if(cfg.searchSwarm(i,1)>0 &&cfg.searchSwarm(i,1)<=20&&cfg.searchSwarm(i,2)>0 &&cfg.searchSwarm(i,2)<=20)
            if(vMap(ceil(cfg.searchSwarm(i,1)),ceil(cfg.searchSwarm(i,2)))==0)
                vMap(ceil(cfg.searchSwarm(i,1)+1),ceil(cfg.searchSwarm(i,2)+1),1)= cfg.searchSwarm(i,3)-cfg.searchSwarm(i,5);
                vMap(ceil(cfg.searchSwarm(i,1)+1),ceil(cfg.searchSwarm(i,2)+1),2)= cfg.searchSwarm(i,4)-cfg.searchSwarm(i,6);
            end
        end
        %x(t+1)=v(t+1)+x(t)
%        sx=ceil(cfg.searchSwarm(i,1))
%         if1=cfg.searchSwarm(i,1)+cfg.searchSwarm(i,5)
%         sy=ceil(cfg.searchSwarm(i,2))
%         if2=cfg.searchSwarm(i,2)+cfg.searchSwarm(i,6) 
        
        
        xVal=cfg.searchSwarm(i,1);
        vxVal=cfg.searchSwarm(i,5);
        
        yVal=cfg.searchSwarm(i,2);
        vyVal=cfg.searchSwarm(i,6);
        
        [xCorrection,yCorrection]=velocityCorrection(vMap,xVal,yVal);
        if((xVal+vxVal)<=0||(xVal+vxVal)>20)
            cfg.searchSwarm(i,1)=xVal-1.5*vxVal;
        else
            %vMap(ceil(cfg.searchSwarm(i,1))+1,ceil(cfg.searchSwarm(i,2))+1,1)       
            cfg.searchSwarm(i,1) = xVal+vxVal+xCorrection;
        end

        if((yVal+vyVal)<=0||(yVal+vyVal)>20)
            cfg.searchSwarm(i,2)=yVal-1.5*vyVal;
        else
            cfg.searchSwarm(i,2) = yVal+vyVal+yCorrection;
        end
        
    end
    %cfg.searchSwarm
    for i= 1:cfg.searchSwarmSize
         if(cfg.searchSwarm(i,1) > 0 && cfg.searchSwarm(i,1) <=20 && cfg.searchSwarm(i,2) > 0 && cfg.searchSwarm(i,2) <=20 )
            [uV,vV]=getVector(cfg.searchSwarm(i,1),cfg.searchSwarm(i,2),vx,vy);
         else
             uV=0;
             vV=0;
         end
        cfg.searchSwarm(i,3) = rand*cfg.inertia*cfg.searchSwarm(i,3)+randi([-1,1]);
        cfg.searchSwarm(i,4) = rand*cfg.inertia*cfg.searchSwarm(i,4)+randi([-1,1]);
        cfg.searchSwarm(i,5) = cfg.searchSwarm(i,3)+uV;
        cfg.searchSwarm(i,6) = cfg.searchSwarm(i,4)+vV;
    end
    
    clf
    hold on
    
    plot(cfg.searchSwarm(:,1),cfg.searchSwarm(:,2),'o')
    axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
    hold off
    
    title('Testsearchswarm')
    pause(0.05)
    
end
end

