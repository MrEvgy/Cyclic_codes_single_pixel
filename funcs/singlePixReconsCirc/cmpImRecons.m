% % Test TV
clc;

%% Parameters to choose.
UserParam.NumPnts = 25111; %Base size
UserParam.ShiftGrid = 1;

%% Create transformation matrix & S-Matrix
[sMat,SInv] = sMatQuad(UserParam.NumPnts);

[RecMatInv,q,p] = RecOperator(UserParam);
RecMatInv = sparse(RecMatInv); % Will make compuation faster.
RecMat = inv(RecMatInv'*RecMatInv)*RecMatInv';
RecMat = full(RecMat);

%% Pick scope samples
sampleParam.N = N; % Size of pattern (input of function)
sampleParam.R = 57500; % Radius where pattern sits.
sampleParam.D = 4*0.75*sqrt(3); %distance between 2 pixels on pattern (dx)
sampleParam.degPatStart = 90-180.5-0.4335; %angle where pattern starts
sampleParam.degPatEnd = 90-310.5+0.4335-20; %angle where pattern ends
sampleParam.thPer = 0.5; % threshold in fraction of maximum value
sampleParam.shiftDeg0 = 0.42; % shift offset for sample at zero
sampleParam.PathCalib = 'systemCode_shared\OpticsSystem\Results\Phase2\calibration\11_07radius_calib.mat'; % Path to calib data
 
[VInterp,degSample] = pickScopeSamples(sampleParam,piRotate,t(1,:),V(1,:));
degScope = (t-t(1))*piRotate.vel;

% Reconsturct Image - using all samples;
imXOrig = RecMatInv * (SInv * VInterp.');
figure(1);imagesc(flipud(fliplr(reshape(imXOrig,[q,p])))); colormap gray; colorbar; title('Original');


%% Take only part of measurments
Per = 50;

VCS = VInterp;
SInvCS = SInv;
sMatCS = sMat;

% Take only part of measurments
K = ceil(length(sMatCS)*Per/100); % num obs
% iRemove = K+1:UserParam.NumPnts;
% iRemove = [1:7*K,8*K+1:UserParam.NumPnts];
iRemove = [1:K];
% iRemove = randperm(N);
% iRemove(floor((100-Per)/100*N):end) = [];

VCS(iRemove) = [];
SInvCS(:,iRemove) = [];
sMatCS(iRemove,:) = [];

% imX = RecMatInv *(SInvCS * VCS.');
aMat = full(sMatCS*sparse(RecMat));
aMatT =  aMat';
f = VCS';


%%
% Run TVAL3
clear opts
opts.mu = 2^10;
opts.beta = 2^7;
opts.tol = 1E-3;
opts.maxit = 200;
opts.TVnorm = 1;
opts.nonneg = false;

tic;
[U, out] = TVAL3(aMat,f,q,p,opts);
% [U, out] = TVAL3(aMat,f-min(f),q,p,opts,opts.tol);

T3 = toc;

% psnrRes(3) = psnr(U, reshape(imXOrig,[M,N]));
% ssimRes(3) = ssim(U, reshape(imXOrig,[M,N]));
% U(U<0) = 0
figure; imagesc(fliplr(flipud(U))); colormap gray; colorbar; title('TVAL3');
% xlabel(strcat('PSNR=',num2str(psnrRes(3)),'SSIM=',num2str(ssimRes(3))));

%
% suptitle(strcat(num2str(Per),'% of samples'));

%%  Old code for different CS alogrithms (LSQR,Magic,Spgll)
% 
% 
% % imLSQR = lsqr(aMat,VInterp');
% % figure(1); subplot(221);imagesc(reshape(imLSQR,[M,N])); colormap gray; colorbar; title('LSQR');
% % 
% lvl = 3;
% [xWave,C] = wavedec2(imX,lvl,'db4');
% xWave = xWave.';
% %% Measurement matrix
% aMat = orth((sMat*RecMat)')';
% % aMat = (sMat*RecMat);
% 
% aMatT =  aMat';
% 
% A = @(z) A_db4(z,C,aMat);
% At = @(z) At_db4(z,lvl,aMatT);
% 
% A2 = @(z,mode) A_db4_Modes(z,mode,C,lvl,aMat,aMatT);
% 
% 
% % obsevations
% b = A(xWave);
% % initial point
% x0 = At(b);
% % 
% %% Solve magic
% tic;
% xp = l1eq_pd_Edit(x0, A, At, b);
% T = toc;
% error = sum((xp - xWave).^2);
% X = waverec2(xp,C,'db4');
% psnrRes(1) = psnr(X,imXOrig);
% ssimRes(1) = ssim(X,imXOrig);
% figure(1); subplot(222);imagesc(reshape(X,[M,N])); colormap gray; colorbar; title('Magic');
% % xlabel(strcat('PSNR=',num2str(psnrRes(1)),'SSIM=',num2str(ssimRes(1))));
% 
% %% spgll
% sigma = 0;
% tau = 0;
% x0  = [];
% tic;
% [xp2,r,g,info] = spgl1(A2,b,tau,sigma,x0);
% T2= toc;
% X2 = waverec2(xp2,C,'db4');
% psnrRes(2) = psnr(X2,imXOrig);
% ssimRes(2) = ssim(X2,imXOrig);
% figure(1); subplot(223);imagesc(reshape(X2,[M,N])); colormap gray; colorbar; title('SPGLL');
% xlabel(strcat('PSNR=',num2str(psnrRes(2)),'SSIM=',num2str(ssimRes(2))));


