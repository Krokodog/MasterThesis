function [z] = ackley(x,y)
a=20;
b=0.2;
c=2*pi;
[x,y]=meshgrid(x,y);

z=-a*exp(-b*sqrt(x.^2+y.^2))-exp(1/2*(cos(c*x)+cos(c*y)))+a*exp(1);
figure
surf(x,y,z)
end

