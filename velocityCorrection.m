function [xCorrection,yCorrection] = velocityCorrection(vMap,xVal,yVal)

tmpvMap=zeros(size(vMap,1)+2);
iX=ceil(xVal)+2;
iY=ceil(yVal)+2;

tmpvMap(2:size(tmpvMap,1)-1,2:size(tmpvMap,2)-1,1)=vMap(:,:,1);
tmpvMap(2:size(tmpvMap,1)-1,2:size(tmpvMap,2)-1,2)=vMap(:,:,2);

vecX=tmpvMap(iX-1:iX+1,iY-1:iY+1,1);
vecY=tmpvMap(iX-1:iX+1,iY-1:iY+1,2);
xCorrection=max(vecX(:))
yCorrection=min(vecY(:))

%xCorrection=sum(vecX(:))/size(vecX(:),1)
%yCorrection=sum(vecY(:))/size(vecY(:),1)

