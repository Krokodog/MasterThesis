function [u,v] = getVector(x,y,a,b)
%GETVECTOR Calculate the precise velocity vector
%   x and y coordinates
%   a and b velocity components in x- and y-direction

u=0;
v=0;

%Boundary handling
if(x < 1)
    x=0;
end
if(x > 20)
    x=20;
end
if(y < 1)
    y=0;
end
if(y > 20)
    y=20;
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
v1=[a(p00(1)),b(p00(2))];
v2=[a(p01(1)),b(p01(2))];
v3=[a(p10(1)),b(p10(2))];
v4=[a(p11(1)),b(p11(2))];
    
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
    u = a(x);
    v = b(y);
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

