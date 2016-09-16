function [] = visualizeSolution( pos_normal,pos_velocity,x,y,z,xMin,xMax,yMin,yMax,a,b,gbests,gbestsV )
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
    
    subplot(2,2,2)
    hold on
    contour(x,y,z,20);
    plot(pos_velocity(:,1),pos_velocity(:,2),'o')
    axis([xMin xMax yMin yMax]);
    quiver(x,y,a,b);
    hold off
    axis equal
    title('PSO considering the vectorfield')
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    subplot(2,2,3)
    hold on
    
    plot(1:50,gbests(:),'-')
    axis([1 50 -1 max(gbests(:))]);
    hold off
    axis auto
    title('Convergence Plot for normal PSO')
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    subplot(2,2,4)
    hold on
    plot(1:50,gbestsV(:),'-')
    axis([1 50 -1 max(gbestsV(:))]);
    hold off
    axis auto
    title('Convergence Plot for PSO considering the vectorfield')
    
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

