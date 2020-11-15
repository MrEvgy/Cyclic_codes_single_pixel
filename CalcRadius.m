function [SimParam] = CalcRadius(SimParam,UserParam)
%Function Calculates Radius needed for number of points wanted

%% Extract Parameters
NumPnts = UserParam.NumPnts;

%% Calculation of vertexs postions & Calc Distances
[DistMatrix] = CalcVertexDist(SimParam);

%% Calc how many occurances for each different distance value
DistVec = DistMatrix(:);
DistVec = round(DistVec*10000)/10000;
DiffVals = unique(DistVec); %Get different sets of distances 
Occurances = hist(DistVec,DiffVals); %Build Hist
OccurancesCumSum = cumsum(Occurances);
IndxRadius = find((OccurancesCumSum>=NumPnts)>0,1,'first'); %Find first element in cumsum which excedes number of wanted points.
SimParam.R = DiffVals(IndxRadius)+0.001; 
SimParam.CumSum = OccurancesCumSum;
end

