function [xOut] = A_db4_Modes(xIn,Mode,C,lvl,aMat,aMatT)
% Function preforms multiplication with A and does inverse wavelet
% transform.

if Mode == 1
    X = waverec2(xIn,C,'db4');
    xOut = aMat * X;
else
    X = aMatT * xIn;
    xOut = wavedec2(X,lvl,'db4').';
end

end

