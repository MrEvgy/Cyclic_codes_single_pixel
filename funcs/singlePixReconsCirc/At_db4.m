function [xWave] = At_db4(b,lvl,aMatT)
% Function preforms multiplication with A and does inverse wavelet
% transform.

X = aMatT * b;
xWave = wavedec2(X,lvl,'db4').';

end

