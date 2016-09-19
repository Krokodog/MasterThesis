function [z] = rosenbrock(x,y)
[x,y]=meshgrid(x,y);
z=(1-x).^2 + 100*(y-x.^2).^2;

figure
surf(x,y,z)

end

