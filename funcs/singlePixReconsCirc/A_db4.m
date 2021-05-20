function [b] = A_db4(Xwave,C,aMat)
% Function preforms multiplication with A and does inverse wavelet
% transform.

X = waverec2(Xwave,C,'db4');
b = aMat * X;

end

