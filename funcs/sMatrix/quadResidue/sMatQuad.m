function [s,sInv] = sMatQuad(N)
% Function creautes a cyclic S-Matrix based on p.210 in Hadamard Transform Optics
% Input: N - size of the matrix (matrix is square)

%% Calculate S - Matrix
Temp1 = (1:((N-1)/2)).^2;
Temp2 = rem(Temp1, N); clear Temp1;
Vec = zeros(1, N);
Vec(1) = 1;
Vec(Temp2+1) = 1; clear Temp2;

s = zeros(N);
for i=1:N
    s(i,:) = circshift(Vec,[0,-(i-1)]);
end
sInv = 2/(N+1) * (2*s.' - ones(N));


end

