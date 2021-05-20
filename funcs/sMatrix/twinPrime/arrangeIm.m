function [im] = arrangeIm(vector,p,q)
%Rearranges vector to image for twin-prime image which is row stacked
im = reshape(vector,q,p)';
end

