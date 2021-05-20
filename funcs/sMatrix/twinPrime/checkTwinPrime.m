clear all; close all;
% Known p values - from wikipedia
% 3,5,11,17,29,41,59,71,101,107,137,149,179,191,197,227,239,269,281,311,347,419,431,461,521,569,599,617,641,659
p = 5; q = p +2; n = p*(p+2);
[SMat] = SmatTwinprime(p);
SInv = 2/(n+1) * (2*SMat.' - ones(n));
SInv2 = inv(SMat);
max(max(abs(SInv-SInv2)))


%%
imS = zeros(p,q,n);

for ii = 1:n
    Svec = SMat(ii,:);
    imS(:,:,ii) = reshape(Svec,q,p)';
end

figure; 
subplot(2,2,1); imagesc(imS(:,:,1)); colormap gray;
subplot(2,2,2); imagesc(imS(:,:,2)); colormap gray;
subplot(2,2,3); imagesc(imS(:,:,3)); colormap gray;
subplot(2,2,4); imagesc(imS(:,:,4)); colormap gray;


imenlarge = enlargePix(imS(:,:,1),10);
figure; imagesc(imenlarge); colormap gray;
% save('Mask_101_103','imS');