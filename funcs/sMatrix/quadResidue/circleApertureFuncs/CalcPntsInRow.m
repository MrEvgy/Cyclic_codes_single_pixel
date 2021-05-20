function [CleWinParam,SimParam] = CalcPntsInRow(SimParam,UserParam,CleWinParam)
%Function counts number of points in row, this number will be altered later
%because number of points might be to high.

%% Extract Parameters
X = SimParam.X;
Y = SimParam.Y;
dx = SimParam.dx;
dy = SimParam.dy;
x0 = SimParam.x0;
y0 = SimParam.y0;
R = SimParam.R;
NumPnts = UserParam.NumPnts;

%% Calculation of vertexs postions & Calc Distances
[DistMatrix] = CalcVertexDist(SimParam);

Map = le(DistMatrix.^2, R^2);
Xmap = X.*Map;
Row_Indx = min(Xmap,[],2);
Count_Row = sum(Map, 2);
Row_Indx = Row_Indx(Count_Row>0);
Count = sum(Count_Row);
Row_Length = Count_Row(Count_Row>0);
Row_High = (size(Row_Indx,1):-1:1)';

%% Removes the points so we get the sized mask we want.
PntsRemove = Count - NumPnts;
ii = size(Row_Length,1);
while PntsRemove>0
    TmpLastLength = Row_Length(ii);
    Row_Length(ii) = TmpLastLength-PntsRemove;
    PntsRemove = PntsRemove - TmpLastLength;
    if Row_Length(ii) <= 0
        Row_Indx(ii) = [];
        Row_High(ii) = [];
        Row_High = Row_High - 1;
        Row_Length(ii) = [];
    end
    ii = ii - 1;
end

%% Insert Pnt parameters

CleWinParam.RowLength = Row_Length;
CleWinParam.RowHigh = Row_High;
CleWinParam.RowIndx = Row_Indx;
SimParam.Count = Count;
SimParam.Map = Map;

end

