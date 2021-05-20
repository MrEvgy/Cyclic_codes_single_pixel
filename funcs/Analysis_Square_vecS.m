function [meanImage,VInterp,degSample] = Analysis_Square_vecS(V,t,piRotate,sampleParam,p,numAvg,subFig)
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

%% Pick correct scope samples
q = p+2; N = p*q;
degScope = (t-t(1))*piRotate.vel;
degSample = pickScopeSamples(sampleParam,piRotate,t,V);

%% Calculate how much over-sampling we have & calculate difference between angle. (Only in case of averaging).
dAngleMeasure = 0; overSampleFactor = 1; % Default values
if numAvg > 1
    omega = 2*pi/(360/piRotate.vel); % Velocity in radians
    dtPixel = sampleParam.D/(sampleParam.R*omega); % Time takes to translate between 2 pixels. [sec]
    dAnglePixel = dtPixel * piRotate.vel; %Angle between 2 pixels [deg]

    dt = t(2)-t(1); % Time between two measurments [sec]
    dAngleMeasure = dt * piRotate.vel; %Angle between 2 measurements [deg]
    overSampleFactor = (dAnglePixel/dAngleMeasure); %number of measurements between 2 pixels.

    if numAvg > floor(overSampleFactor)
        numAvg = floor(overSampleFactor);
        disp(['changed number of averaging to ', num2str(numAvg)]);
    end
end 

    
%% Reconstrcut 
if sampleParam.FFT_rec == 1
    sfft = fft(sampleParam.Svec);
else
    sInvVec = sampleParam.SInv;
    sInvVec = sInvVec.';
end


for ii = 1:numAvg
     shiftAdditional = (ii-1)*dAngleMeasure;

    %% Calculate Vinterp
    degSampleShift = shiftAdditional + degSample; % Calculate degrees to sample
    VInterp = interp1(degScope,V,degSampleShift,'linear','extrap'); % Interpolate the measurment.
    xRec = zeros(N,1);  
    if sampleParam.FFT_rec == 1 % Reconstruct with FFT
         measfft = fft(VInterp);
         imfft = measfft./sfft;
         xRec = ifft(imfft);
         xRec = [xRec(1),fliplr(xRec(2:end))];
    else
        for jj = 1:N
            xRec(jj) = circshift(sInvVec,[0,1-jj]) * VInterp.';
        end
    end
    im2Rec(:,:,ii) = arrangeIm(xRec,p,q); % Create image from de-multiplexed measurments.
    im2RecShift(:,:,ii) = imtranslate(im2Rec(:,:,ii),[-2*(ii-1)/overSampleFactor,0],'linear','FillValues',0);
end
meanImage = mean(im2RecShift,3); % Average sub-pixel shifts

% figure; hold on; plot(degScope, V); xlabel('deg'); ylabel('V [Volt]');
% plot(degSample, VInterp,'ro');

if sampleParam.Cont == 1 % Fixes contrast
    meanImage = imadjust(meanImage,[],[],sampleParam.Coef);
end

if sampleParam.Aper == 1 % Remove pixels that are not used with aperture
    meanImage = meanImage/abs(max(meanImage(:))); meanImage = meanImage - min(meanImage(:));% Normalize image
    synAp = synAperture(subFig);
    meanImage = meanImage.*synAp;
end



