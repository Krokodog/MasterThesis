function [xCorrection,yCorrection] = velocityCorrection(vMap,xVal,yVal)

xCorrection=0;
yCorrection=0;
tmpvMap=zeros(size(vMap,1)+2);

iX=round(xVal)+2;
iY=round(yVal)+2;

tmpvMap(3:size(tmpvMap,1),3:size(tmpvMap,2),1)=vMap(:,:,1);
tmpvMap(3:size(tmpvMap,1),3:size(tmpvMap,2),2)=vMap(:,:,2);

vecX=tmpvMap(iX-1:iX+1,iY-1:iY+1,1);
vecY=tmpvMap(iX-1:iX+1,iY-1:iY+1,2);

[xvalue,xindex]=max(abs(vecX(:)));
[yvalue,yindex]=max(abs(vecY(:)));

xCorrection=vecX(xindex);
yCorrection=vecY(yindex);
%xCorrection=sum(vecX(:))/size(vecX(:),1)
%yCorrection=sum(vecY(:))/size(vecY(:),1)

