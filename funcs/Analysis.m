function [meanImage,VInterp,degSample, im2Rec] = Analysis(V,t,piRotate,sampleParam,N,numAvg,subFig)
% Functions creates an image from our measurements.
% Inputs: N - pattern size (number of pixels)
%         piRotate - parameters of PI rotation stage.
%         t  - times of measurements.
%         V  - Measurements.             
% Outputs: im2Rec - reconsturcted image. (Might need to flip)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              fields: R - radius where pattern sits.
%                      N - pattern size (number of pixels)
%                      D - distance between 2 pixels on pattern (dx)
%                      degPatStart - angle where pattern starts
%                      degPatEnd - angle where pattern ends
%                      PathCalib - path of locations of calibration results 
% changeable paramters for picking scope samples - inside AnalysisParam
%[sampleParam] = AnalysisParam(sampleParam);
degScope = (t-t(1))*piRotate.vel;

degSample = pickScopeSamples(sampleParam,piRotate,t,V);

%% Calculate how much over-sampling we have & calculate difference between angle. (Only in case of averaging).
dAngleMeasure = 0; overSampleFactor = 1; % Default values

if numAvg > 1
    omega = 2*pi/(360/piRotate.vel); %
    dtPixel = sampleParam.D/(sampleParam.R*omega); % Time takes to translate between 2 pixels. [sec]
    dAnglePixel = dtPixel * piRotate.vel; %Angle between 2 pixels [deg]

    dt = t(2)-t(1); % Time between two measurments [sec]
    dAngleMeasure = dt * piRotate.vel; %Angle between 2 measurements [deg]
    overSampleFactor = (dAnglePixel/dAngleMeasure); %number of measurements between 2 pixels.

    if numAvg > floor(overSampleFactor)
        numAvg = floor(overSampleFactor);        
    end
end 
UserParam.NumPnts = N;
UserParam.ShiftGrid = 1;
if sampleParam.FFT_rec == 1
    sfft = fft(sampleParam.Svec);
end

for ii = 1:numAvg
    shiftAdditional = (ii-1)*dAngleMeasure;

    %% Calculate Vinterp
    degSampleShift = shiftAdditional + degSample; % Calculate degrees to sample
    VInterp = interp1(degScope,V,degSampleShift,'linear','extrap'); % Interpolate the measurment.
    Vmat(ii,:) = VInterp;
    if sampleParam.FFT_rec == 1  % Reconstruct with fft
         tic;
         measfft = fft(VInterp);
         imfft = measfft./sfft;
         xRec = ifft(imfft);
         xRec = [xRec(1),fliplr(xRec(2:end))];
         T(ii) = toc;
    else
         xRec = (sampleParam.SInv * VInterp.').'; % Reconstructed image from samples.
    end
    im2Rec(:,:,ii) = ImageReconsNoIntep(UserParam,xRec); % Create image from de-multiplexed measurments.
    im2RecShift(:,:,ii) = imtranslate(im2Rec(:,:,ii),[-2*(ii-1)/overSampleFactor,0],'FillValues',0);
end
if sampleParam.DispT == 1
    display(['Average reconstruction time: ',num2str(mean(T)),'s']);
end
meanImage = mean(im2RecShift,3); % Take average of sub-pixel reconstructed image

if sampleParam.Back  == 1 % Remove background [optional]
    meanImage = meanImage - sampleParam.Background;
end
if sampleParam.Cont == 1 % Fixes contrast
    meanImage = imadjust(meanImage,[],[],sampleParam.Coef);
end

if sampleParam.Aper == 1 % Remove pixels that are not used with aperture
    meanImage = meanImage/max(meanImage(:)); meanImage = meanImage - min(meanImage(:));% Normalize image
    synAp = synAperture(subFig);
    meanImage = meanImage.*synAp;
end
