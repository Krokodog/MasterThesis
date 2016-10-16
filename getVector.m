function [u,v] = getVector(x,y,vFieldx,vFieldy,grid)
%GETVECTOR Calculate the precise velocity vector
%   x and y coordinates
%   a and b velocity components in x- and y-direction

u=0;
v=0;

%Boundary handling
if(x < grid.xMin+1)
    x=grid.xMin;
end
if(x > grid.xMax)
    x=grid.xMax;
end
if(y < grid.yMin+1)
    y=grid.yMin;
end
if(y > grid.yMax)
    y=grid.yMax;
end

%index handling
x=x+1;
y=y+1;

%Grid points
p00=[floor(x),floor(y)];
p10=[ceil(x),floor(y)];
p01=[floor(x),ceil(y)];
p11=[ceil(x),ceil(y)];
    
%Velocity at grid points

v1=[vFieldx(size(vFieldx,1)+1-p00(1),p00(1)),vFieldy(size(vFieldy,1)+1-p00(2),p00(2))];
v2=[vFieldx(size(vFieldx,1)+1-p01(1),p01(1)),vFieldy(size(vFieldy,1)+1-p01(2),p01(2))];
v3=[vFieldx(size(vFieldx,1)+1-p10(1),p10(1)),vFieldy(size(vFieldy,1)+1-p10(2),p10(2))];
v4=[vFieldx(size(vFieldx,1)+1-p11(1),p11(1)),vFieldy(size(vFieldy,1)+1-p11(2),p11(2))];

% 3 cases:
%1. On 1 gridpoint
%2. Between 2 gridpoints
%3. In a cell of 4 gridpoints
%Use interpolation v=(1-t)*p1+t*p2 , t e[0,1]

%rem = remainder, get the grid vertices
fractX=rem(x,1);
fractY=rem(y,1);

%Case 1
if fractX == 0 && fractY==0
    u = vFieldx(size(vFieldx,1)+1-x,x);
    v = vFieldx(size(vFieldx,1)+1-y,y);
end

%Case 2 in x-direction
if fractX ~= 0 && fractY==0
    if((p00(2)-y)==0)
        interpVal=(1-fractX)*v1+fractX*v3;
    else
        interpVal=(1-fractX)*v2+fractX*v4;
    end
    u=interpVal(1);
    v=interpVal(2);
end

%Case 2 in y-direction
if fractX == 0 && fractY~=0
    if((p00(1)-x)==0)
        interpVal=(1-fractY)*v1+fractY*v3;
    else
        interpVal=(1-fractY)*v2+fractY*v4;
    end
    u=interpVal(1);
    v=interpVal(2);
end

%Case 3
if fractX ~= 0 && fractY~=0

    %Interpolation in x direction
    vX0=(1-fractX)*v1+fractX*v3;
    vX1=(1-fractX)*v2+fractX*v4;
    
    %Interpolation in y direction
    vXY=(1-fractY)*vX0+fractY*vX1;
    
    u=vXY(1);
    v=vXY(2);
end


end

