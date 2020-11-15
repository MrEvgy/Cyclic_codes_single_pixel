% Example reconstruction for Fig.3.a of the main paper.
% Image of a resolution target with N = 25111 pixels with size 4x0.75 um and M=56 sub-pixel shifted samples.
clear;
load('data.mat')

%% Calculate how much over-sampling we have & calculate difference between angles.
omega = 2*pi/(360/piRotate.vel); %
dtPixel = sampleParam.D/(sampleParam.R*omega);  % Time takes to translate between 2 pixels. [sec]
dAnglePixel = dtPixel * piRotate.vel;           % Angle between 2 pixels [deg]
dAngleMeasure = sampleParam.dt * piRotate.vel;  % Angle between 2 measurements [deg]
overSampleFactor = (dAnglePixel/dAngleMeasure); % Number of measurements between 2 pixels.
if sampleParam.M > floor(overSampleFactor)
    sampleParam.M = floor(overSampleFactor);
    disp(['changed number of averaging to ', num2str(sampleParam.M)]);
end

[svec] = sVecQuad(sampleParam.N);   % Create multiplexing vector
sfft = fft(svec);

%% Sub samples invert and realighments
for ii = 1:sampleParam.M
    V_smp_ii = V_smp(ii,:); % Take one of the M sup-pixel shifted samples.
    
    % Reconstruct with fft
    tic
    measfft = fft(V_smp_ii);
    imfft = measfft./sfft;
    xRec = ifft(imfft);
    xRec = [xRec(1),fliplr(xRec(2:end))];
    t_rec(ii) = toc;    % Read reconstruction time for one frame
     
    im2Rec(:,:,ii) = ImageReconsNoIntep(sampleParam,xRec); % Create image from de-multiplexed measurements.
    im2RecShift(:,:,ii) = imtranslate(im2Rec(:,:,ii),[-2*(ii-1)/overSampleFactor,0],'FillValues',0);    % Align M reconstructions.

end

meanImage = mean(im2RecShift,3);
I = imadjust(meanImage);             % Contrast adjustment
I_norm = I-min(min(I));              % Normalize, since it's A.U.
I_norm = I_norm/max(max(I_norm));    % Normalize, since it's A.U.
I_norm_app = I_norm(65:170, 50:260); % Remove empty areas outside of the phisical aperture.

figure; imagesc(flipud(I_norm_app));
colormap gray; colorbar; title('Reconstruction with N=25111 and M=56'); axis off;
disp(['Time for single frame reconstruction was ', num2str(mean(t_rec)), ' [sec].']);
disp(['The reconstruction was performed for ', num2str(sampleParam.M), ' sub-pixel shifted samples.']);



