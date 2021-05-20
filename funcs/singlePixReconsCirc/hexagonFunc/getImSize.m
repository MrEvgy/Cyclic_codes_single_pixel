function [NumRow,NumCol,RowLength] = getImSize(UserParam)
%function gets image size.
SimParam.x0 = 0;
SimParam.y0 = 0;
SimParam.dx = 1;
SimParam.dy = SimParam.dx*sqrt(3)/2;
SimParam.NumPntsGrid= 1000;

%% Grid Calculation
[SimParam] = CalcGrid(SimParam,UserParam);
%% Calculate Radius for number of points
SimParam = CalcRadius(SimParam,UserParam);
%% Calculate the Properties for Mask generation: Row_Indx,High and Length
[CleWinParam,~] = CalcPntsInRow(SimParam,UserParam);
RowLength = CleWinParam.RowLength;

%% Calculate number of rows and colums
MidLength = RowLength(ceil(length(RowLength)/2));
UpMidLength = RowLength(ceil(length(RowLength)/2)+1);
if MidLength>UpMidLength % Check if the middle row is longest or the one before in order to create a correct grid.
    NumCol = 2*MidLength;
else
    NumCol = 2*UpMidLength;
end
NumRow = length(RowLength);

