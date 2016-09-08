function [mat1,mat2,mat3,mat4] = PSO(cfg,grid)
%PSO Summary of this function goes here
%   Detailed explanation goes here

% Construct the grid
x=grid.xMin:grid.epsylon:grid.xMax;
y=grid.yMin:grid.epsylon:grid.yMax;

%uniform vectorfield
%vx=-y./y;
%vy=x./x;
vx=-y;
vy=x;
%vx=sin(y)*0.3;
%vy=cos(x)*0.2;

[x,y]=meshgrid(x,y);

% Change the coordinates of the objective function
uSub=8;
vSub=12;

% Scalarfield
z=(x-uSub).^2 + ( y-vSub).^2;

% Vectorfield contour grid
%a=sin(y)*0.3;
%b=cos(x)*0.2;
a=-y;
b=x;


% Visulize the grid cells
%normal
mat1=zeros(grid.xMax,grid.yMax);
%average
mat2=mat1;
%real
mat3=mat1;

%vectormap
mat4=mat1;
for k=1:grid.xMax-1
    for l=1:grid.yMax-1
        p00=[k,l];
        p01=[k,l+1];
        p10=[k+1,l];
        p11=[k+1,l+1];
        
        v1=[vx(p00(1)),vy(p00(2))];
        v2=[vx(p01(1)),vy(p01(2))];
        v3=[vx(p10(1)),vy(p10(2))];
        v4=[vx(p11(1)),vy(p11(2))];
        
        avgMx=(v1(1)+v2(1)+v3(1)+v4(1))/4;
        avgMy=(v1(2)+v2(2)+v3(2)+v4(2))/4;
        vecTmp=[avgMx,avgMy];
        mat4(k,l)=norm(vecTmp);
    end
end
%most visited cells and vector
mat5=mat1;

% Initialize the cfg.swarm
for i = 1:cfg.swarmSize
    cfg.swarm(cfg.individual, 1:7) = i;
    cfg.individual = cfg.individual+1;
end
% initial velocity u
cfg.swarm(:, 5)=0;
% initial velocity v
cfg.swarm(:, 6)=0;
cfg.swarm(:, 7)=1000;

cfg.swarmVel =cfg.swarm;
cfg.swarmVelo = cfg.swarm;
countera=0;
for iter = 1:cfg.iterations
    
    for i= 1:cfg.swarmSize
        tmpsx=ceil(cfg.swarm(i,1));
        tmpsy=ceil(cfg.swarm(i,2));
        if(tmpsx>0 &&tmpsy >0 && tmpsx<=20 && tmpsy<=20)
            mat1(tmpsx,tmpsy)=mat1(tmpsx,tmpsy)+1;
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
        tmpsvx=ceil(cfg.swarmVel(i,1));
        tmpsvy=ceil(cfg.swarmVel(i,2));
        if(tmpsvx>0 &&tmpsvy >0 && tmpsvx<20 && tmpsvy<20)
            mat2(tmpsvx,tmpsvy)=mat2(tmpsvx,tmpsvy)+1;
        end
        
        %x(t+1)=v(t+1)+x(t)
        %Boundary handling, set to random postition
        %p[rand[0,20],rand[0,20]]
        if((cfg.swarmVel(i,1)+cfg.swarmVel(i,5))<0 ||(cfg.swarmVel(i,1)+cfg.swarmVel(i,5))>20)
            cfg.swarmVel(i,1)=randi([0,20]);
        else
            cfg.swarmVel(i,1) = cfg.swarmVel(i,1)+cfg.swarmVel(i,5);
        end
        if((cfg.swarmVel(i,2)+cfg.swarmVel(i,6))<0 ||(cfg.swarmVel(i,2)+cfg.swarmVel(i,6))>20)
            cfg.swarmVel(i,2)=randi([0,20]);
        else
            cfg.swarmVel(i,2) = cfg.swarmVel(i,2)+cfg.swarmVel(i,6);
        end
        
        
        %        countera=countera+1
        
        uVel = cfg.swarmVel(i,1);
        vVel = cfg.swarmVel(i,2);
        % Objective function
        valueVel = (uVel-uSub)^2 + ( vVel-vSub)^2;
        if(valueVel < cfg.swarmVel(i,7))
            %update best pos u
            cfg.swarmVel(i,3) = cfg.swarmVel (i,1);
            %update best pos v
            cfg.swarmVel(i,4) = cfg.swarmVel (i,2);
            cfg.swarmVel(i,7) = valueVel;
        end
        
        tmpsvox=ceil(cfg.swarmVelo(i,1));
        tmpsvoy=ceil(cfg.swarmVelo(i,2));
        
        if(tmpsvox>0 &&tmpsvoy >0 && tmpsvox<20 && tmpsvoy<20)
            mat3(tmpsvox,tmpsvoy)=mat3(tmpsvox,tmpsvoy)+1;
            mat5(tmpsvox,tmpsvoy)=mat5(tmpsvox,tmpsvoy)+mat4(tmpsvox,tmpsvoy);
        end
        
        %x(t+1)=v(t+1)+x(t)
        if((cfg.swarmVelo(i,1)+cfg.swarmVelo(i,5))<0 ||(cfg.swarmVelo(i,1)+cfg.swarmVelo(i,5))>20)
            cfg.swarmVelo(i,1)=randi([0,20]);
        else
            cfg.swarmVelo(i,1) = cfg.swarmVelo(i,1)+cfg.swarmVelo(i,5);
        end
        if((cfg.swarmVelo(i,2)+cfg.swarmVelo(i,6))<0 ||(cfg.swarmVelo(i,2)+cfg.swarmVelo(i,6))>20)
            cfg.swarmVelo(i,2)=randi([0,20]);
        else
            cfg.swarmVelo(i,2) = cfg.swarmVelo(i,2)+cfg.swarmVelo(i,6);
        end
        uVelo = cfg.swarmVelo(i,1);
        vVelo = cfg.swarmVelo(i,2);
        % Objective function
        valueVelo = (uVelo-uSub)^2 + ( vVelo-vSub)^2;
        if(valueVelo < cfg.swarmVelo(i,7))
            %update best pos u
            cfg.swarmVelo(i,3) = cfg.swarmVelo (i,1);
            %update best pos v
            cfg.swarmVelo(i,4) = cfg.swarmVelo (i,2);
            cfg.swarmVelo(i,7) = valueVel;
        end
        
    end
    %tmp is the value and gbest the index
    [tmp, gbest] = min(cfg.swarm(:,7));
    [tmpVel, gbestVel] = min(cfg.swarmVel(:,7));
    [tmpVelo, gbestVelo] = min(cfg.swarmVelo(:,7));
    for i= 1:cfg.swarmSize
        cfg.swarm(i,5) = rand*cfg.inertia*cfg.swarm(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,3)...
            -cfg.swarm(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,3)-cfg.swarm(i,1));
        cfg.swarm(i,6) = rand*cfg.inertia*cfg.swarm(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarm(i,4)...
            -cfg.swarm(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarm(gbest,4)-cfg.swarm(i,2));
        
        
        
        %         if(cfg.swarmVel(i,1) > 0 && cfg.swarmVel(i,1) <=20 && cfg.swarmVel(i,2) > 0 && cfg.swarmVel(i,2) <=20 )
        [uEst,vEst]=estimateVector(cfg.swarmVel(i,1),cfg.swarmVel(i,2),vx,vy);
        %         else
        %             uEst=0;
        %             vEst=0;
        %         end
        cfg.swarmVel(i,5) = rand*cfg.inertia*cfg.swarmVel(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarmVel(i,3)...
            -cfg.swarmVel(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarmVel(gbestVel,3)-cfg.swarmVel(i,1))+uEst;
        cfg.swarmVel(i,6) = rand*cfg.inertia*cfg.swarmVel(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarmVel(i,4)...
            -cfg.swarmVel(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarmVel(gbestVel,4)-cfg.swarmVel(i,2))+vEst;
        
        
        if(cfg.swarmVelo(i,1) > 0 && cfg.swarmVelo(i,1) <=20 && cfg.swarmVelo(i,2) > 0 && cfg.swarmVelo(i,2) <=20 )
            [uV,vV]=getVector(cfg.swarmVelo(i,1),cfg.swarmVelo(i,2),vx,vy);
        else
            uV=0;
            vV=0;
        end
        cfg.swarmVelo(i,5) = rand*cfg.inertia*cfg.swarmVelo(i,5)+cfg.accelerationCoefficient*rand*(cfg.swarmVelo(i,3)...
            -cfg.swarmVelo(i,1))+cfg.accelerationCoefficient*rand*(cfg.swarmVelo(gbestVel,3)-cfg.swarmVelo(i,1))+uV;
        cfg.swarmVelo(i,6) = rand*cfg.inertia*cfg.swarmVelo(i,6)+cfg.accelerationCoefficient*rand*(cfg.swarmVelo(i,4)...
            -cfg.swarmVelo(i,2))+cfg.accelerationCoefficient*rand*(cfg.swarmVelo(gbestVel,4)-cfg.swarmVelo(i,2))+vV;
        
    end
    
    if(cfg.visualizeSteps)
        clf
        
        subplot(1,3,1)
        hold on
        contour(x,y,z,20);
        plot(cfg.swarm(:,1),cfg.swarm(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        axis equal
        title('Normal PSO not considering the vectorfield')
        hold off
        
        subplot(1,3,2)
        hold on
        contour(x,y,z,20);
        plot(cfg.swarmVel(:,1),cfg.swarmVel(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        quiver(x,y,a,b);
        hold off
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        axis equal
        title('PSO considering the estimated vectorfield')
        
        subplot(1,3,3)
        hold on
        contour(x,y,z,20);
        plot(cfg.swarmVelo(:,1),cfg.swarmVelo(:,2),'o')
        axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
        quiver(x,y,a,b);
        hold off
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        axis equal
        title('PSO considering the vectorfield')
        
        pause(.2);
    end
end
if(~cfg.visualizeSteps)
    visualizeSolution(cfg.swarm,cfg.swarmVel,cfg.swarmVelo,x,y,z,grid.xMin,grid.xMax,grid.yMin,grid.yMax,a,b)
    figure
    subplot(2,1,1)
    imagesc(transpose(mat4))
    set(gca,'YDir','normal')
    colormap('cool')
    colorbar;
    cmap = colormap;
    cmap(1,:) = [172/255 172/255 172/255];
    colormap(cmap);
    
    axis equal
    axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
    maxVisited=max(mat3(:));
    for m=1:size(mat5,1)
        for n=1:size(mat5,2)
            if(maxVisited~=0)
                mat5(m,n)=mat5(m,n)/maxVisited;
            end
        end
    end
    subplot(2,1,2)
    imagesc(transpose(mat5))
    set(gca,'YDir','normal')
    colormap('cool')
    colorbar;
    cmap = colormap;
    cmap(1,:) = [172/255 172/255 172/255];
    colormap(cmap);
    axis equal
    axis([grid.xMin grid.xMax grid.yMin grid.yMax]);
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
end

end

