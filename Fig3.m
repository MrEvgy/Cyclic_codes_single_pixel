% clear; close all; clc;
%%%% Code generates Figure 3 images                %%%%
%%%% Choose able parameters are: subFig and numAvg %%%%
subFig = 1; % Choose which sub-figure you want a-1,b-2,c-3,d-4,e-5
numAvg = 100;% Choose number of averaging with sub-pixel shifts (as explained in the paper)
% If numAvg is larger then number of avaiable averaging it will take the maximum amount of averaging possible

[sampleParam] = calibParam(subFig); % Load parameters

% Load data
switch subFig 
    case 1
        load('data\dataFig3a.mat');
        letter = 'a';
    case 2
        load('data\dataFig3b.mat');
        letter = 'b';
    case 3
        load('data\dataFig3c.mat');
        letter = 'c';
    case 4
        load('data\dataFig3d.mat');
        letter = 'd';
    case 5
        load('data\dataFig3e.mat');
        letter = 'e';
end
% We repeated the measurements multiple times, but use only one of the measurements
V = V(1,:);
t = t(1,:);

if subFig == 1 || subFig == 2 || subFig == 3 || subFig == 4 %Hexagon pixels
    ImRec = Analysis(V,t,piRotate,sampleParam,sampleParam.N,numAvg,subFig);
elseif subFig == 5 %Square pixels
    ImRec = Analysis_Square_vecS(V,t,piRotate,sampleParam,sampleParam.p,numAvg,subFig);
end


%%
if subFig == 1 || subFig == 2 || subFig == 3
    figure; imagesc(flipud(ImRec)); colormap gray; 
    title(['Fig 3',letter]);
elseif subFig == 4 || subFig == 5 %Need to flip left-right 
    figure; imagesc(fliplr(flipud(ImRec))); colormap gray; 
    title(['Fig 3',letter]);
end


