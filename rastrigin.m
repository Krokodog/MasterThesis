function [z] = rastrigin(x,y)
d=2;
[x,y]=meshgrid(x,y);
z=10*d+((x.^2-10*cos(2*pi*x))+(y.^2-10*cos(2*pi*y)));

figure
surf(x,y,z)
end


