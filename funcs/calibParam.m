function [sampleParam] = calibParam(subfig)
% This function calls some pre calibrated paramaters, depending on the
% spesific experiment (velocity of stage, resolution of scope, calibration
% parameters of pattern depending on pattern size, pattern location on
% disc, and misalignment between rotation stage and disk centers - as
% described in the paper, reconstruction parameters and etc...)
switch subfig % subfig 3a-1, 3b-2, 3c-3, 3d-4, 3e-5
    case 1 % subfig - b      
        % Calibrated parameters
        sampleParam.R = 57495;
        sampleParam.rCal = 2.1;
        sampleParam.PathCalib = 'data\calibDataFig3abc.mat'; % Path to calib data 

        % Pattern parameters
        sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
        sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.shiftDeg0 = 28.83; % shift offset for sample at zero
        sampleParam.N = 25111; % Number of pixels   
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 0; % Remove aperture
        sampleParam.Cont = 1; % Fix contrast 
        sampleParam.Coef = 1; % Contrast coef
        sampleParam.DispT = 1; % Display reconstrcut time
        sampleParam.Back = 0; % Remove background

    case 2 % subfig - b 
        % Calibrated parameters
        sampleParam.R = 5.500540000000000e+04;
        sampleParam.rCal = -0.1;
        
        % Pattern parameters
        sampleParam.D = 0.85*sqrt(3);  %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = -270-45;  % angle where pattern starts
        sampleParam.degPatEnd = -270-83.7;  % angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.shiftDeg0 = 6.7362; 0.02; % shift offset for sample at zero
        sampleParam.PathCalib = 'data\calibDataFig3abc.mat'; % Path to calib data
        sampleParam.N = 25111; % Number of pixels     
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 0; % Remove aperture
        sampleParam.Cont = 1; % Fix contrast 
        sampleParam.Coef = 1; % Contrast coef
        sampleParam.DispT = 1; % Display reconstrcut time
        sampleParam.Back = 0; % Remove background

    case 3 % subfig - c     
        % Calibrated parameters
        sampleParam.R = 57495;
        sampleParam.rCal = 2.1;
        sampleParam.PathCalib = 'data\calibDataFig3abc.mat'; % Path to calib data 

        % Pattern parameters
        sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
        sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.shiftDeg0 = 14.9746; % shift offset for sample at zero
        sampleParam.N = 25111; % Number of pixels     
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 0; % Remove aperture
        sampleParam.Cont = 1; % Fix contrast 
        sampleParam.Coef = 1; % Contrast coef
        sampleParam.DispT = 1; % Display reconstrcut time
        sampleParam.Back = 0; % Remove background

    case 4
        % Calibrated parameters
        sampleParam.R = 57504;
        sampleParam.rCal = -3;
        sampleParam.PathCalib = 'data\calibDataFig3d.mat'; % Path to calib data

        % Pattern parameters
        sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
        sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.shiftDeg0 = 32.70;
        sampleParam.N = 25111; % Number of pixels  
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 1; % Remove aperture
        sampleParam.Cont = 0; % Fix contrast 
        sampleParam.Coef = 1; % Contrast coef
        sampleParam.DispT = 1; % Display reconstrcut time
        sampleParam.Back = 0; % Remove background

    case 5
        % Calibrated parameters
        sampleParam.R = 57197;
        sampleParam.rCal = -1;
        sampleParam.PathCalib = 'data\calibDataFig3e.mat'; % Path to calib data
        
        % Pattern parameters
        sampleParam.D = 4; %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 0;  %angle where pattern starts
        sampleParam.degPatEnd = -30;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.shiftDeg0 = 19.17;
        sampleParam.p = 101; % Number of pixels  
        sampleParam.q = sampleParam.p+2; % Number of pixels  
        sampleParam.N = sampleParam.p*sampleParam.q; % Number of pixels  
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 1; % Remove aperture
        sampleParam.Cont = 0; % Fix contrast 
        sampleParam.Coef = 1; % Contrast coef
        sampleParam.DispT = 1; % Display reconstrcut time
        sampleParam.Back = 0; % Remove background

    case 41
        sampleParam.angle_step = 45; % Step between the starting angles of different reconstructions.
        sampleParam.frames = 142; 142;    % Number of sampled frames.
        sampleParam.teta0 = -28; 194.5;
        % Optimized parameters:
        sampleParam.rCal = 2.5;
        %piRotate.vel = 3240.283;
        sampleParam.R =  57200;  % Radius where pattern sits.

        % General parameters
        sampleParam.p = 101; % Size of pattern (input of function)
        sampleParam.q = 103; % Size of pattern (input of function)
        sampleParam.N = sampleParam.p*sampleParam.q; % Size of pattern (input of function)
        sampleParam.D = 4; %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = -0;  %angle where pattern starts
        sampleParam.degPatEnd = -30;  %angle where pattern ends
        sampleParam.PathCalib = 'data\calibDataFig4a.mat'; % Path to calib data
        sampleParam.FFT_rec = 1;
        sampleParam.Aper = 0; % Remove aperture
        sampleParam.Cont = 1;
        sampleParam.Coef = 1.3;

    case 42   
        sampleParam.frames = 31;    % Number of sampled frames.
        sampleParam.shiftDeg0 = 31.73;       
        % Optimized parameters        
        sampleParam.R = 57504;
        sampleParam.rCal = -3;
  
        % Pattern parameters
        sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
        sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.N = 25111; % Number of pixels  
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 1; % Remove aperture
        sampleParam.Back = 1; % Remove background
        sampleParam.PathBack = 'data\dataFig4b_bk.mat';    % Path to background image
        sampleParam.DispT = 0; % Display reconstrcut time
        sampleParam.Cont = 0;
        sampleParam.Coef = 1;
        sampleParam.PathCalib = 'data\calibDataFig4bc.mat'; % Path to calib data

    case 43
        sampleParam.frames = 31;    % Number of sampled frames.
        sampleParam.shiftDeg0 = 31.73;       
        % Optimized parameters        
        sampleParam.R = 57504;
        sampleParam.rCal = -3;
  
        % Pattern parameters
        sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
        sampleParam.degPatStart = 90-180.5-0.4335;  %angle where pattern starts
        sampleParam.degPatEnd = 90-310.5+0.4335;  %angle where pattern ends
        sampleParam.thPer = 0.5; % threshold in fraction of maximum value
        sampleParam.N = 25111; % Number of pixels  
        
        % Reconstruction parameters
        sampleParam.FFT_rec = 1; % Reconstruct with fft (faster)
        sampleParam.Aper = 1; % Remove aperture
        sampleParam.Back = 1; % Remove background
        sampleParam.PathBack = 'data\dataFig4c_bk.mat';    % Path to background image
        sampleParam.DispT = 0; % Display reconstrcut time
        sampleParam.Cont = 0;
        sampleParam.Coef = 1;
        sampleParam.PathCalib = 'data\calibDataFig4bc.mat'; % Path to calib data
        
        
end

% Choose S-matrix or S-vec depending on reconstruction with FFT or Normal
if sampleParam.FFT_rec == 1 && subfig < 5 % Load s vector with Hexagon
     sampleParam.Svec = sVecQuad(sampleParam.N);
elseif sampleParam.FFT_rec == 1 && subfig < 5 % Load S inverse matrix with Hexagon
    [~,sampleParam.SInv] = sMatQuad(sampleParam.N);      
elseif sampleParam.FFT_rec == 1 && subfig == 5 % Load s vector with square pixel
     sampleParam.Svec = sVetTwinPrime(sampleParam.p);
elseif sampleParam.FFT_rec == 1 && subfig == 5 % Load S inverse matrix with square pixel
    [~,sampleParam.SInv] = sVetTwinPrime(sampleParam.p);   
elseif sampleParam.FFT_rec == 1 && subfig == 41 % Load S inverse matrix with square pixel
%     sampleParam.Svec = sVecQuad(sampleParam.N);
    sampleParam.Svec = sVetTwinPrime(sampleParam.p);
elseif sampleParam.FFT_rec == 1 && subfig == 42 % Load S vector with Hexagon
    sampleParam.Svec = sVecQuad(sampleParam.N);
elseif sampleParam.FFT_rec == 1 && subfig == 43 % Load S vector with Hexagon
    sampleParam.Svec = sVecQuad(sampleParam.N);
end
        
end

