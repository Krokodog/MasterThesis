function [vMap] = createVectorMap(cfg,grid,vx,vy)
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
% column7: goal posx
% column8: goal posy
cfg.searchSwarm=zeros(cfg.searchSwarmSize,8);
vMap=zeros(grid.xMax+1,grid.yMax+1,1);
vMap=zeros(grid.xMax+1,grid.yMax+1,2);

% Start position of each indiviual is randomly generated
for i=1:cfg.searchSwarmSize
    cfg.searchSwarm(i, 1) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 2) = randi([grid.xMin,grid.xMax]);
    cfg.searchSwarm(i, 3) = cfg.searchSwarm(i, 1);
    cfg.searchSwarm(i, 4) = cfg.searchSwarm(i, 2);
end

for time = 1:cfg.searchTime
    for i = 1:cfg.searchSwarmSize
        
 
        % Each particle will randomly move in a direction
        moveX=randi([-1,1]);
        moveY=randi([-1,1]);
        
        % Remember old position
        cfg.searchSwarm(i, 1) = cfg.searchSwarm(i, 3);
        cfg.searchSwarm(i, 2) = cfg.searchSwarm(i, 4);
    
        % Goal position without wind
        cfg.searchSwarm(i,7) = cfg.searchSwarm(i,1)+moveX;
        cfg.searchSwarm(i,8) = cfg.searchSwarm(i,2)+moveY;
        
        % New position with wind
        cfg.searchSwarm(i,3) = cfg.searchSwarm(i,1)+moveX +cfg.searchSwarm(i,5);
        cfg.searchSwarm(i,4) = cfg.searchSwarm(i,2)+moveY +cfg.searchSwarm(i,6);
        
        % Check if particle is still in the defined grid after each
        % movement. Save the correction value in the vMap-matrix. 
        if(cfg.searchSwarm(i,1)>=grid.xMin &&cfg.searchSwarm(i,1)<=grid.xMax &&cfg.searchSwarm(i,2)>=grid.yMin &&cfg.searchSwarm(i,2)<=grid.yMax)
            if(vMap(round(cfg.searchSwarm(i,1))+1,round(cfg.searchSwarm(i,2))+1)==0)
                vMap(round(cfg.searchSwarm(i,1)+1),round(cfg.searchSwarm(i,2)+1),1)= cfg.searchSwarm(i,7)-cfg.searchSwarm(i,3);
                vMap(round(cfg.searchSwarm(i,1)+1),round(cfg.searchSwarm(i,2)+1),2)= cfg.searchSwarm(i,8)-cfg.searchSwarm(i,4); 
            end
        end              
    end
    

    for i= 1:cfg.searchSwarmSize
        
        %TODO: Change boundary behaviour
        
        % If an indivudual would exceed the boundary its velocity is set to
        % zero, else calculate the velocity at the position of the
        % individual
        if(cfg.searchSwarm(i,1) > grid.xMin && cfg.searchSwarm(i,1) <=grid.xMax && cfg.searchSwarm(i,2) > grid.yMin && cfg.searchSwarm(i,2) <=grid.yMax )
            [uV,vV]=getVector(cfg.searchSwarm(i,1),cfg.searchSwarm(i,2),vx,vy,grid);
        else
            uV=0;
            vV=0;
        end

        % Velocity update
        cfg.searchSwarm(i,5) = rand*cfg.inertia*cfg.searchSwarm(i,5)+uV;
        cfg.searchSwarm(i,6) = rand*cfg.inertia*cfg.searchSwarm(i,6)+vV;

    end
    
    % This figure visualizes the position of each individual, its goal
    % position and its new position considering the vectorfield
%         clf
%         hold on  
%         plot(cfg.searchSwarm(:,1),cfg.searchSwarm(:,2),'o')
%         plot(cfg.searchSwarm(:,3),cfg.searchSwarm(:,4),'x')
%         plot(cfg.searchSwarm(:,7),cfg.searchSwarm(:,8),'^')
%         axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
%         hold off
%         set(gca,'YDir','normal')
%         title('Testsearchswarm')
%         pause(0.05)

end

end

