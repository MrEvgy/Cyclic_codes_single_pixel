clear; close all; clc;
%%%% Code generates Figure 4 images                %%%%
%%%% Choosable parameters are: subFig and numAvg %%%%
subFig = 41; % Choose which sub-figure you want: 4.a-41, 4.b-42, 4.c-43
numAvg = 1;  % No avaraging is availiable in video mode due to the memry limitation of the oscilloscope.
video_t_frame =  0.005; % Time for displaying a single frame.
% If numAvg is larger then number of avaiable averaging it will take the maximum amount of averaging possible

[sampleParam] = calibParam(subFig); % Load parameters

% Load data
switch subFig 
    case 41
        load('data\dataFig4a.mat');
        letter = 'a';
    case 42
        load('data\dataFig4b.mat');
        letter = 'b';
    case 43
        load('data\dataFig4c.mat');
        letter = 'c';
end

VideoRec = Analysis_video(V,t,piRotate,sampleParam,sampleParam.N,numAvg,subFig);

figure;
for fr=1:sampleParam.frames
    imagesc((squeeze(VideoRec(fr,:,:)))); colormap gray; title(fr);
    pause(video_t_frame);  
end
