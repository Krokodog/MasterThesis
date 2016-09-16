function [] = visualizeVisitedPositions(matPos1,matPos3)
 figure
    colormap('hot');
    cmap = colormap;
    cmap(1,:) = [172/255 172/255 172/255];
    colormap(cmap);
    subplot(1,2,1)
    imagesc(transpose(matPos1))
    axis equal
    axis([1 20 1 20]);
    colorbar('Ticks',[0,max(matPos1(:))])
    set(gca,'YDir','normal')
    
    
    subplot(1,2,2)
    imagesc(transpose(matPos3))
    axis equal
    axis([1 20 1 20]);
    colorbar('Ticks',[0,max(matPos3(:))])
    set(gca,'YDir','normal')
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
end

