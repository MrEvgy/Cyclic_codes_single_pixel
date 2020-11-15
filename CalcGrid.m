function [SimParam] = CalcGrid(SimParam,UserParam)
%Function Calculates Grid & creates an offeset for x values in order to
%create a grid for hexagons

%% Extract Parameters
x0 = SimParam.x0;
y0 = SimParam.y0;
dx = SimParam.dx;
dy = SimParam.dy;
NumPnts = SimParam.NumPntsGrid;
ShiftGrid = UserParam.ShiftGrid;

%% Calculate Grid
x = ((-NumPnts)/2*dx : dx : (NumPnts)/2*dx);
y = ((-NumPnts)/2*dy : dy : (NumPnts)/2*dy);
[X,Y] = meshgrid(x, y);    % Basic square grid that will be moved

if ShiftGrid == 1
    X(2:2:end,:) = X(2:2:end,:)+dx/2;
end

%% Insert grid to parameters
SimParam.x = x;
SimParam.y = y;
SimParam.Y = Y;
SimParam.X = X;
end

