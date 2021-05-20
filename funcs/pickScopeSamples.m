function [degSample] = pickScopeSamples(sP,pR,t,V)
% Functions picks samples locations in order to pick correct measurements.
% Inputs: sP - parameters regarding samples choosing. (sampleParam)
%              fields: R - radius where pattern sits.
%                      N - pattern size (number of pixels)
%                      D - distance between 2 pixels on pattern (dx)
%                      degPatStart - angle where pattern starts
%                      degPatEnd - angle where pattern ends
%                      PathCalib - path of locations of calibration results 
%                      thPer - threshold in fraction of maximum value
%                      shiftDeg0 - shift offset for sample at zero
%         pR - parameters of PI rotation stage. (piRotate)
%              fields: vel - velolcity of rotation stage.
%         t  - times of measurements.
%         v  - Measurements.
% Outputs: VInterp - interpolated voltages for meausrement.
%          degSample - chosen degrees to sample from
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter size (number of samples)
filtS = 20;

% Calculations 
degScope = (t-t(1))*pR.vel;

% Load variables for calibration - you might need to change path
load(sP.PathCalib); % Load calibration values: This file loads meanR_offset_filt and degIdx

% Calculations of adaptive radius and relevant degrees on pattern
R_offset_filt = mean(R_offset_filt,1); % In case there are multiple measurements
Rmod = sP.R + sP.rCal*R_offset_filt; % Offset modulated radius
Rmod = FilterRcal(Rmod,filtS); % convultion with filter of 1's
degPat = linspace(sP.degPatStart,sP.degPatEnd,sP.N); % Calculates degress where pattern sits
RmodInterp = interp1(degIdx, Rmod, degPat,'linear','extrap'); % Interpolates radius for each degree.

dDegSample = 2.*asin(sP.D./(2*RmodInterp))*180/pi; % Theta step size [deg]

%%%%% Choose one %%%%%%
% degSample0 = setDeg0(V, degScope, sP.thPer, sP.shiftDeg0); % Calculates the first degree of measurement 
degSample0 = sP.shiftDeg0; %%% for square mask
%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate Vinterp
degSample = degSample0 + cumsum(dDegSample); % Calculate degrees to sample



end

