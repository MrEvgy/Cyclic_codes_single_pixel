function [sampleParam] = AnalysisParamSquare(sampleMod)
% % Functions creates parameters needed for analysis.
sampleParam.p = 101; % Size of pattern (input of function)
sampleParam.q = 103; % Size of pattern (input of function)
sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
sampleParam.R =  57200+5;  % Radius where pattern sits.
sampleParam.rCal = 2.5; % multiplier for radius calibration
sampleParam.D = 4; %distance between 2 pixels on pattern (dx)
sampleParam.degPatStart = -0;  %angle where pattern starts
sampleParam.degPatEnd = -30;  %angle where pattern ends
sampleParam.thPer = 0.5; % threshold in fraction of maximum value
sampleParam.shiftDeg0 = 50; % shift offset for sample at zero
sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data
sampleParam.FFT_rec = 1;


%
% sampleParam.p = 347; % Size of pattern (input of function)
% sampleParam.q = 349; % Size of pattern (input of function)
% sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
% sampleParam.R =  55895+5;  % Radius where pattern sits.
% sampleParam.rCal = 2.5; % multiplier for radius calibration
% sampleParam.D = 2.9; %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -0;  %angle where pattern starts
% sampleParam.degPatEnd = -360;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 162; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data


if nargin == 1
    if isfield(sampleMod,'N')
       sampleParam.N = sampleMod.N;
    end
    if isfield(sampleMod,'R')
       sampleParam.R = sampleMod.R;
    end
    if isfield(sampleMod,'rCal')
       sampleParam.rCal = sampleMod.rCal;
    end
    if isfield(sampleMod,'D')
       sampleParam.D = sampleMod.D;
    end
    if isfield(sampleMod,'degPatStart')
       sampleParam.degPatStart = sampleMod.degPatStart;  %angle where pattern starts
    end
    if isfield(sampleMod,'degPatEnd')
       sampleParam.degPatEnd = sampleMod.degPatEnd;  %angle where pattern ends
    end
    if isfield(sampleMod,'thPer')
       sampleParam.thPer = sampleMod.thPer; % threshold in fraction of maximum value
    end
    if isfield(sampleMod,'shiftDeg0')
        sampleParam.shiftDeg0 = sampleMod.shiftDeg0; % shift offset for sample at zero
    end
    if isfield(sampleMod,'PathCalib')
       sampleParam.PathCalib = sampleMod.PathCalib;
    end
    if isfield(sampleMod,'FFT_rec')
        sampleParam.FFT_rec = sampleMod.FFT_rec;
    end 
end


%% 
% sampleParam.p = 311; % Size of pattern (input of function)
% sampleParam.q = 313; % Size of pattern (input of function)
% sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
% sampleParam.R =  62500;  % Radius where pattern sits.
% sampleParam.rCal = -12; % multiplier for radius calibration
% sampleParam.D = 4; %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -0;  %angle where pattern starts
% sampleParam.degPatEnd = -359.5;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 0.3; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data


%%
% sampleParam.p = 347; % Size of pattern (input of function)
% sampleParam.q = 349; % Size of pattern (input of function)
% sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
% sampleParam.R =  55895+5;  % Radius where pattern sits.
% sampleParam.rCal = 2.5; % multiplier for radius calibration
% sampleParam.D = 2.9; %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -0;  %angle where pattern starts
% sampleParam.degPatEnd = -360;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 162; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data

%%
% sampleParam.p = 521; % Size of pattern (input of function)
% sampleParam.q = 523; % Size of pattern (input of function)
% sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
% sampleParam.R =  52040.42+5;  % Radius where pattern sits.
% sampleParam.rCal = 2.5; % multiplier for radius calibration
% sampleParam.D = 1.2; %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -0;  %angle where pattern starts
% sampleParam.degPatEnd = -360;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 50; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data

% %%
% sampleParam.p = 101; % Size of pattern (input of function)
% sampleParam.q = 103; % Size of pattern (input of function)
% sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
% sampleParam.R =  57200+5;  % Radius where pattern sits.
% sampleParam.rCal = 2.5; % multiplier for radius calibration
% sampleParam.D = 4; %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -0;  %angle where pattern starts
% sampleParam.degPatEnd = -30;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 50; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase3\calibration\02_18radius_calib.mat'; % Path to calib data
% 

