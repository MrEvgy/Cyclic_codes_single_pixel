function [sample] = im2vecHex(Im,RowLength)
% Function gets hexagon image (circle aperture) and creates relevant vector
% for only samples
sample = zeros(sum(RowLength),1);
VecIdx = 1;
for RowIdx = 1:size(Im,1)
    CurrLength = RowLength(RowIdx);
    if mod(CurrLength,2) == 1
        StartIdx = ceil(size(Im,2)/2)-2*ceil(CurrLength/2-1);
    elseif mod(CurrLength,2) == 0
        StartIdx = ceil(size(Im,2)/2)-1-2*ceil(CurrLength/2-1);
    end
    InputVec = StartIdx:2:(CurrLength-1)*2+StartIdx;
    for ColIdx = InputVec
        sample(VecIdx,1) = Im(RowIdx,ColIdx);
        VecIdx = VecIdx + 1;
    end
end

end

