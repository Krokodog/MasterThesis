function [u,v] = estimateVector(x,y,a,b)
%ESTIMATEVECTOR Get average velocity vector
%   Detailed explanation goes here
u=0;
v=0;

%Boundary handling
if(x < 0)
    x=0;
end
if(x > 20)
    x=20;
end
if(y < 0)
    y=0;
end
if(y > 20)
    y=20;
end

%index handling
x=x+1;
y=y+1;

% 3 cases:
%1. On 1 gridpoint
%2. Between 2 gridpoints
%3. In a cell of 4 gridpoints

%rem = remainder, get the grid vertices

%Case 1
if rem(x,1) == 0 && rem(y,1)==0
    u = a(x);
    v = b(y);
end

%Case 2 in x-direction
if rem(x,1) == 0 && rem(y,1)~=0
    u = a(x);
    y1=floor(y);
    y2=ceil(y);
    v = (b(y1)+b(y2))/2 ;
end

%Case 2 in y-direction
if rem(x,1) ~= 0 && rem(y,1)==0
    x1=floor(x);
    x2=ceil(x);
    u = (a(x1)+a(x2))/2;
    v =  b(y);
end

%Case 3

%Average
if rem(x,1) ~= 0 && rem(y,1)~=0
    if(x>0 && x<1)
        x=1;
    end
    if(y>0 && y<1)
        y=1;
    end

    p00=[floor(x),floor(y)];
    p01=[floor(x),ceil(y)];
    p10=[ceil(x),floor(y)];
    p11=[ceil(x),ceil(y)];
    
    
    v1=[a(p00(1)),b(p00(2))];
    v2=[a(p01(1)),b(p01(2))];
    v3=[a(p10(1)),b(p10(2))];
    v4=[a(p11(1)),b(p11(2))];
    
    u=(v1(1)+v2(1)+v3(1)+v4(1))/4;
    v=(v1(2)+v2(2)+v3(2)+v4(2))/4;
end

