function [] = visualizeVisitedPositions(matPos1,matPos3,grid)
 figure
    colormap('hot');
    cmap = colormap;
    cmap(1,:) = [172/255 172/255 172/255];
    colormap(cmap);
    subplot(1,2,1)
    imagesc(transpose(matPos1))
    axis equal
    axis([1 abs(grid.xMin)+grid.xMax+1 1 abs(grid.yMin)+grid.yMax+1]);
    colorbar('Ticks',[0,max(matPos1(:))])
    set(gca,'YDir','normal')
    ylabel({'y-Axis'})
    xlabel({'x-Axis'})
    
    subplot(1,2,2)
    imagesc(transpose(matPos3))
    axis equal
    axis([1 abs(grid.xMin)+grid.xMax+1 1 abs(grid.yMin)+grid.yMax+1]);
    colorbar('Ticks',[0,max(matPos3(:))])
    set(gca,'YDir','normal')
    ylabel({'y-Axis'})
    xlabel({'x-Axis'})
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
end

