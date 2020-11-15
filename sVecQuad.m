function [svec] = sVecQuad(N)
% Function creaues S-matrix first vector
% Input: N - size of the matrix (matrix is square)

%% Calculate S - Matrix
Temp1 = (1:((N-1)/2)).^2;
Temp2 = rem(Temp1, N); clear Temp1;
Vec = zeros(1, N);
Vec(1) = 1;
Vec(Temp2+1) = 1; clear Temp2;

svec =  Vec;



end