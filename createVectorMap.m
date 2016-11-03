function [vMap] = createVectorMap(cfg,grid,vx,vy,x,y)
%CREATEVECTORMAP Calculate a correction value for each cell visted by an
%individual
%----------------------------------------------
% 
% column1: posx
% column2: posy
% column3: newposx
% column4: newposy
% column5: update xvel
% column6: update yvel

cfg.searchSwarm=zeros(cfg.searchSwarmSize,8);
vMap=zeros(abs(grid.xMin)+grid.xMax+1,abs(grid.yMin)+grid.yMax+1,1);
vMap=zeros(abs(grid.xMin)+grid.xMax+1,abs(grid.yMin)+grid.yMax+1,2);

% Start position of each indiviual is randomly generated
for i=1:cfg.searchSwarmSize
    cfg.searchSwarm(i, 1) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 2) = randi([grid.xMin,grid.xMax]);
%     cfg.searchSwarm(i, 1) = 1;
%     cfg.searchSwarm(i, 2) = 1;
    cfg.searchSwarm(i, 3) = cfg.searchSwarm(i, 1);
    cfg.searchSwarm(i, 4) = cfg.searchSwarm(i, 2);
end


%TODO simulate t
for time = 1:cfg.searchTime
    for i = 1:cfg.searchSwarmSize
        
        % Remember old position
        cfg.searchSwarm(i, 1) = cfg.searchSwarm(i, 3);
        cfg.searchSwarm(i, 2) = cfg.searchSwarm(i, 4);
        
        % New position with wind
        cfg.searchSwarm(i,3) = cfg.searchSwarm(i,1)+cfg.searchSwarm(i,5);
        cfg.searchSwarm(i,4) = cfg.searchSwarm(i,2)+cfg.searchSwarm(i,6);
        
        if(cfg.searchSwarm(i,3)<grid.xMin)
            cfg.searchSwarm(i,3)=grid.xMin;
        end
        if(cfg.searchSwarm(i,3)>grid.xMax)
            cfg.searchSwarm(i,3)=grid.xMax;
        end
        if(cfg.searchSwarm(i,4)<grid.yMin)
            cfg.searchSwarm(i,4)=grid.yMin;
        end
        if(cfg.searchSwarm(i,4)>grid.yMax)
            cfg.searchSwarm(i,4)=grid.yMax;
        end
        % Check if particle is still in the defined grid after each
        % movement. Save the correction value in the vMap-matrix. 

        if(cfg.searchSwarm(i,3)>=grid.xMin &&cfg.searchSwarm(i,3)<=grid.xMax &&cfg.searchSwarm(i,4)>=grid.yMin &&cfg.searchSwarm(i,4)<=grid.yMax)
            if(vMap(round(cfg.searchSwarm(i,2)+(abs(grid.xMin))+1),round(cfg.searchSwarm(i,1)+(abs(grid.xMin))+1))==0)
                vMap(round(cfg.searchSwarm(i,2)+(abs(grid.xMin))+1),round(cfg.searchSwarm(i,1)+(abs(grid.xMin))+1),1)= cfg.searchSwarm(i,3)-cfg.searchSwarm(i,1);
                vMap(round(cfg.searchSwarm(i,2)+(abs(grid.xMin))+1),round(cfg.searchSwarm(i,1)+(abs(grid.xMin))+1),2)= cfg.searchSwarm(i,4)-cfg.searchSwarm(i,2);
         
            end
        end              
    end
    

    for i= 1:cfg.searchSwarmSize
        
        %TODO: Change boundary behaviour
        
        % If an indivudual would exceed the boundary its velocity is set to
        % zero, else calculate the velocity at the position of the
        % individual
        if(cfg.searchSwarm(i,3) > grid.xMin && cfg.searchSwarm(i,3) <=grid.xMax && cfg.searchSwarm(i,4) > grid.yMin && cfg.searchSwarm(i,4) <=grid.yMax )
            [uV,vV]=getVector(cfg.searchSwarm(i,3),cfg.searchSwarm(i,4),vx,vy,grid);
        else
            uV=0;
            vV=0;
        end

        % Velocity update
        cfg.searchSwarm(i,5) =uV;
        cfg.searchSwarm(i,6) =vV;

    end
    
    % This figure visualizes the position of each individual, its goal
    % position and its new position considering the vectorfield
%         clf
%         hold on  
%         plot(cfg.searchSwarm(:,1),cfg.searchSwarm(:,2),'o')
%         plot(cfg.searchSwarm(:,3),cfg.searchSwarm(:,4),'x')
%        % plot(cfg.searchSwarm(:,7),cfg.searchSwarm(:,8),'^')
%         axis([grid.xMin-5 grid.xMax+5 grid.yMin-5 grid.yMax+5]);
%         quiver(x,y,vx,vy)
%         hold off
%         set(gca,'YDir','normal')
%         title('Testsearchswarm')
%         pause(0.2)

end

end

