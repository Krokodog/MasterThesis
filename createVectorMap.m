function [vMap,ax,ay] = createVectorMap(cfg,grid,vx,vy)
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
% column7: goal posx
% column8: goal posy
cfg.searchSwarm=zeros(cfg.searchSwarmSize,8);
vMap=zeros(grid.xMax+1,grid.yMax+1,1);
vMap=zeros(grid.xMax+1,grid.yMax+1,2);


for i=1:cfg.searchSwarmSize
    cfg.searchSwarm(i, 1) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 2) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 3) = cfg.searchSwarm(i, 1);
    cfg.searchSwarm(i, 4) = cfg.searchSwarm(i, 2);
end

for time = 1:cfg.searchTime
    for i = 1:cfg.searchSwarmSize
        
 
        %Each particle will randomly move in a direction
        moveX=randi([-1,1]);
        moveY=randi([-1,1]);
        
        %Remember old position
        cfg.searchSwarm(i, 1) = cfg.searchSwarm(i, 3);
        cfg.searchSwarm(i, 2) = cfg.searchSwarm(i, 4);

        
        %Goal position without wind
        cfg.searchSwarm(i,7) = cfg.searchSwarm(i,1)+moveX;
        cfg.searchSwarm(i,8) = cfg.searchSwarm(i,2)+moveY;
        
        %New position with wind
        cfg.searchSwarm(i,3) = cfg.searchSwarm(i,1)+moveX +cfg.searchSwarm(i,5);
        cfg.searchSwarm(i,4) = cfg.searchSwarm(i,2)+moveY +cfg.searchSwarm(i,6);
        
        if(cfg.searchSwarm(i,1)>=grid.xMin &&cfg.searchSwarm(i,1)<=grid.xMax &&cfg.searchSwarm(i,2)>=grid.yMin &&cfg.searchSwarm(i,2)<=grid.yMax)
            if(vMap(round(cfg.searchSwarm(i,1))+1,round(cfg.searchSwarm(i,2))+1)==0)
                vMap(round(cfg.searchSwarm(i,1)+1),round(cfg.searchSwarm(i,2)+1),1)= cfg.searchSwarm(i,7)-cfg.searchSwarm(i,3);
                vMap(round(cfg.searchSwarm(i,1)+1),round(cfg.searchSwarm(i,2)+1),2)= cfg.searchSwarm(i,8)-cfg.searchSwarm(i,4); 
            end
        end        

%         %x(t+1)=v(t+1)+x(t)
%         xVal=cfg.searchSwarm(i,1)+moveX;
%         vxVal=cfg.searchSwarm(i,5);
%         
%         yVal=cfg.searchSwarm(i,2)+moveY;
%         vyVal=cfg.searchSwarm(i,6);
%         
%         xCorrection=0;
%         yCorrection=0;
%         
%         if(xVal >=grid.xMin && xVal <=grid.xMax && yVal >=grid.yMin && yVal <=grid.yMax)
%             [xCorrection,yCorrection]=velocityCorrection(vMap,xVal,yVal);
%         end
%         
%         
%         if((xVal+vxVal)<grid.xMin||(xVal+vxVal)>grid.xMax)
%             cfg.searchSwarm(i,3)=xVal-vxVal;
%         else
%             cfg.searchSwarm(i,3) = xVal+vxVal+xCorrection;
%         end
%         
%         if((yVal+vyVal)<grid.yMin||(yVal+vyVal)>grid.yMax)
%             cfg.searchSwarm(i,4)=yVal-vyVal;
%         else
%             cfg.searchSwarm(i,4) = yVal+vyVal+yCorrection;
%         end
 
      
    end
    

    for i= 1:cfg.searchSwarmSize
        if(cfg.searchSwarm(i,1) > grid.xMin && cfg.searchSwarm(i,1) <=grid.xMax && cfg.searchSwarm(i,2) > grid.yMin && cfg.searchSwarm(i,2) <=grid.yMax )
            [uV,vV]=getVector(cfg.searchSwarm(i,1),cfg.searchSwarm(i,2),vx,vy,grid);
        else
            uV=0;
            vV=0;
        end

        %Velocity update
        cfg.searchSwarm(i,5) = rand*cfg.inertia*cfg.searchSwarm(i,5)+uV;
        cfg.searchSwarm(i,6) = rand*cfg.inertia*cfg.searchSwarm(i,6)+vV;

    end
    
%         clf
%         hold on
%     
%         plot(cfg.searchSwarm(:,1),cfg.searchSwarm(:,2),'o')
%         plot(cfg.searchSwarm(:,3),cfg.searchSwarm(:,4),'x')
%         plot(cfg.searchSwarm(:,7),cfg.searchSwarm(:,8),'^')
%         axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
%         hold off
%         set(gca,'YDir','normal')
%         title('Testsearchswarm')
%         pause(0.05)
%     
end

end

