function [sVec,sInvVec] = sVetTwinPrime(p)
% Function create s-Matrix and its inverse for given P
% p - is the size of one the of the edges.
% This only outputs the basic vector

if isprime(p) == 0 || isprime(p+2) == 0
    msg = 'p or p+2 are not prime numbers';
    error(msg)
end
q = p+2;
n = p*q;
k = (p-1)*(q-1)/2;
zeroIdxDef = 0:q:(p-1)*q;

matIdxs = 0:p*q-1;
f_i = zeros(1,n) - 1;
f_i( rem(matIdxs,p) == 0) = 0; 
pQuadRes = rem((1:(p-1)/2).^2,p); pQuadRes = unique(pQuadRes);
f_ioneIdx = [];
for ii = 0:(q-1)
    f_ioneIdx = [f_ioneIdx,(pQuadRes+p*ii)];
end
f_i(f_ioneIdx+1) = 1;

g_i = zeros(1,n) - 1;
g_i( rem(matIdxs,q) == 0) = 0; 
qQuadRes = rem((1:(q-1)/2).^2,q); qQuadRes = unique(qQuadRes);
g_ioneIdx = [];
for ii = 0:(p-1)
    g_ioneIdx = [g_ioneIdx,(qQuadRes+q*ii)];
end
g_i(g_ioneIdx+1) = 1;

zerocmp = find(~(f_i - g_i))-1;
zeroIdx = [zeroIdxDef, zerocmp]; zeroIdx = unique(zeroIdx);

sVec = ones(1,n);
sVec(zeroIdx+1) = 0;
sVec = single(sVec);
% s = zeros(n, n);
% for ii=1:n
%     s(ii,:) = circshift(s1,[0,-(ii-1)]);
% end
sInvVec = 2/(n+1) * (2*sVec.' - ones(n,1));
end

