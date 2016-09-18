function [] = visualizeSolution( pos_normal,pos_velocity,x,y,z,xMin,xMax,yMin,yMax,a,b,gbests,gbestsV,cfg)
%VISUALIZESOLUTION Summary of this function goes here
%   Detailed explanation goes here

    subplot(2,2,1)
    hold on
    contour(x,y,z,20);
    plot(pos_normal(:,1),pos_normal(:,2),'o')
    axis([xMin xMax yMin yMax]);
    hold off
    axis equal
    title('Normal PSO not considering the vectorfield')
    ylabel({'y-Axis'})
    xlabel({'x-Axis'})
    
    subplot(2,2,2)
    hold on
    contour(x,y,z,20);
    plot(pos_velocity(:,1),pos_velocity(:,2),'o')
    axis([xMin xMax yMin yMax]);
    quiver(x,y,a,b);
    hold off
    axis equal
    title('PSO considering the vectorfield')
    ylabel({'y-Axis'})
    xlabel({'x-Axis'})

    
    subplot(2,2,3)
    hold on
    
    plot(1:cfg.iterations,gbests(:),'-')
    axis([1 cfg.iterations -1 max(gbests(:))]);
    hold off
    axis auto
    title('Convergence Plot for normal PSO')
    ylabel({'f(Globalbest)'})
    xlabel({'Iterations'})  

    
    subplot(2,2,4)
    hold on
    plot(1:cfg.iterations,gbestsV(:),'-')
    axis([1 cfg.iterations -1 max(gbestsV(:))]);
    hold off
    axis auto
    title('Convergence Plot for PSO considering the vectorfield')
    ylabel({'f(Globalbest)'})
    xlabel({'Iterations'})
    
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     subplot(1,3,2)
%     hold on
%     contour(x,y,z,20);
%     plot(pos_average(:,1),pos_average(:,2),'o')
%     axis([xMin xMax yMin yMax]);
%     quiver(x,y,a,b);
%     hold off
%     axis equal
%     title('PSO considering the estimated vectorfield')
    


end

