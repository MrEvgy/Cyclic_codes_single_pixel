function [sampleParam] = AnalysisParam(sampleMod)
% Functions creates parameters needed for analysis.
sampleParam.N = 25111; % Size of pattern (input of function)
sampleParam.R = 57500;  % Radius where pattern sits.
sampleParam.rCal = 1.4; % multiplier for radius calibration
sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
sampleParam.thPer = 0.5; % threshold in fraction of maximum value
sampleParam.shiftDeg0 = 14.95; % shift offset for sample at zero
sampleParam.PathCalib = 'OpticsSystem\Results\Phase4\calibration\08_16radius_calib.mat'; % Path to calib data
sampleParam.plot_fig = 1;
sampleParam.FFT_rec = 1;


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
    if isfield(sampleMod,'SInv')
        sampleParam.SInv = sampleMod.SInv;
    end
    if isfield(sampleMod,'plot_fig')
        sampleParam.plot_fig = sampleMod.plot_fig;
    end 
    if isfield(sampleMod,'FFT_rec')
        sampleParam.FFT_rec = sampleMod.FFT_rec;
    end 
    if sampleParam.FFT_rec == 0
        if ~isfield(sampleMod,'SInv')
            load('Sinv_N25111'); 
            SInv = double(SInv);
            SInv(SInv<0.5) = -1;
            SInv = SInv*factorSinv;
            sampleParam.SInv =  SInv;
            clear SInv;
        end
    end

end

%% Parameters for large pixels (4*0.75) - just copy them
% sampleParam.N = 25111; % Size of pattern (input of function)
% sampleParam.R = 57500;  % Radius where pattern sits.
% sampleParam.rCal = 1.4; % multiplier for radius calibration
% sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
% sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 0.25; % shift offset for sample at zero
% sampleParam.PathCalib = 'OpticsSystem\Results\Phase2.6\calibration\12_17radius_calib.mat'; % Path to calib data




%% Parameters for small pixels (0.85) - just copy them
% sampleParam.N = 25111; % Size of pattern (input of function)
% sampleParam.R = 55000;  % Radius where pattern sits.
% sampleParam.rCal = -2; 
% sampleParam.D = 0.85*sqrt(3);  %distance between 2 pixels on pattern (dx)
% sampleParam.degPatStart = -270-45;  %angle where pattern starts
% sampleParam.degPatEnd = -270-83.7;  %angle where pattern ends
% sampleParam.thPer = 0.5; % threshold in fraction of maximum value
% sampleParam.shiftDeg0 = 0.05; % shift offset for sample at zero
% sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase2\calibration\11_28radius_calib.mat'; % Path to calib data

