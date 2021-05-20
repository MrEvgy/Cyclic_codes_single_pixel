function  [RecMat,NumRow,NumCol] = RecOperator(UserParam)
% Function transfers an samples to image and output and an image.
% Inputs:
% UserParam - User defined values.       
% xRec - Sampled image as vector with just relvant values.

%% Ploting
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
[CleWinParam,SimParam] = CalcPntsInRow(SimParam,UserParam);
RowLength = CleWinParam.RowLength;

%% Calculate number of rows and colums
NumRow = length(RowLength);

MidLength = RowLength(ceil(length(RowLength)/2));
UpMidLength = RowLength(ceil(length(RowLength)/2)+1);
if MidLength>UpMidLength % Check if the middle row is longest or the one before in order to create a correct grid.
    NumCol = MidLength;
    if  mod(NumRow,4) == 1
        Interp = 2;
    else
        Interp = 1;
    end
else
    NumCol = UpMidLength;
    if  mod(NumRow,4) == 3
        Interp = 2;
    else
        Interp = 1;
    end
end



%% Create image from vector we reconstruceted before
LenMeasure = UserParam.NumPnts;
RecMat = zeros(NumRow*NumCol,LenMeasure);
ImIdx = [];
IdxMeasure = 1;
MidCol = ceil(NumCol/2);
EvenCol =  mod(NumCol,2);



for RowIdx = 1:NumRow
    CurrRow = RowLength(RowIdx);
    EvenRow =  mod(CurrRow,2);
    
    % Create Vector.
    VecVals = zeros(1,NumCol);
    if EvenRow == 1 && EvenCol == 1
        VecVals(MidCol-floor(CurrRow/2):MidCol+floor(CurrRow/2)) = 1;
    elseif EvenRow == 0 && EvenCol == 1
        VecVals(MidCol-floor(CurrRow/2):MidCol+floor(CurrRow/2)) = 1;
    elseif EvenRow == 0 && EvenCol == 0
        VecVals(MidCol-floor(CurrRow/2)+1:MidCol+floor(CurrRow/2)) = 1;
    elseif EvenRow == 1 && EvenCol == 0
        VecVals(MidCol-floor(CurrRow/2):MidCol+floor(CurrRow/2)+1) = 1;
    end
    
    if (Interp == 1 && mod(RowIdx,2) == 1) || (Interp == 2 && mod(RowIdx,2) == 0)
        DoInterp = 1;
    else
        DoInterp = 0;
    end
    for ColIdx = 1:NumCol
%         Idxs = ColIdx+(RowIdx-1)*NumCol;
        Idxs = RowIdx+(ColIdx-1)*NumRow;
        if DoInterp == 0
            if VecVals(ColIdx) == 1
                RecMat(Idxs,IdxMeasure) = 1;
                IdxMeasure = IdxMeasure + 1;
            end
        elseif DoInterp == 1
            if VecVals(ColIdx) == 1
                if ColIdx == 1 || VecVals(ColIdx - 1) == 0 
                    RecMat(Idxs,IdxMeasure) = 0.5;
                elseif ColIdx == NumCol || VecVals(ColIdx + 1) == 0 
                    RecMat(Idxs,IdxMeasure) = 0.5;
                    IdxMeasure = IdxMeasure + 1;
                else 
                    RecMat(Idxs,IdxMeasure) = 0.5;
                    IdxMeasure = IdxMeasure + 1;
                    RecMat(Idxs,IdxMeasure) = 0.5;
                end
            end
        end
    end
end


end

