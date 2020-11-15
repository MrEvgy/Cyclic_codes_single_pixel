function  DisplayImage = ImageReconsNoIntep(UserParam,xRec)
% Function transfers an samples to image and output and an image, there is
% no interpolation here.
% Inputs:
% UserParam - User defined values.       
% xRec - Sampled image as vector with just relvant values. This can also be
% a vector

[K,N] = size(xRec);
%% No need to touch this, these are all calculations for placing the measurments in the right place 
% Ploting
SimParam.x0 = 0;
SimParam.y0 = 0;
SimParam.dx = 1;
SimParam.dy = SimParam.dx*sqrt(3)/2;
SimParam.NumPntsGrid= 1000;

% Grid Calculation
[SimParam] = CalcGrid(SimParam,UserParam);
% Calculate Radius for number of points
SimParam = CalcRadius(SimParam,UserParam);
% Calculate the Properties for Mask generation: Row_Indx,High and Length
[CleWinParam,SimParam] = CalcPntsInRow(SimParam,UserParam);
RowLength = CleWinParam.RowLength;

% Calculate number of rows and colums
MidLength = RowLength(ceil(length(RowLength)/2));
UpMidLength = RowLength(ceil(length(RowLength)/2)+1);
if MidLength>UpMidLength % Check if the middle row is longest or the one before in order to create a correct grid.
    NumCol = 2*MidLength;
else
    NumCol = 2*UpMidLength;
end
NumRow = length(RowLength);

%% Create image from vector we reconstruceted before
DisplayImage = zeros(NumRow,NumCol,K);
VecIdx = 1;
for RowIdx = 1:size(DisplayImage,1)
    CurrLength = RowLength(RowIdx);
    if mod(CurrLength,2) == 1
        StartIdx = ceil(size(DisplayImage,2)/2)-2*ceil(CurrLength/2-1);
    elseif mod(CurrLength,2) == 0
        StartIdx = ceil(size(DisplayImage,2)/2)-1-2*ceil(CurrLength/2-1);
    end
    InputVec =StartIdx:2:(CurrLength-1)*2+StartIdx;
    for ColIdx = InputVec
        DisplayImage(RowIdx,ColIdx,:) = xRec(:,VecIdx);
        DisplayImage(RowIdx,ColIdx+1,:) = xRec(:,VecIdx);
        VecIdx = VecIdx + 1;
    end
end


end

