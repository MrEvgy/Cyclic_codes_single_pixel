function [Im] = vec2ImHex(xVec,NumRow,NumCol,RowLength)
% Function creates image from xVec (pads to circle aperture)
Im = zeros(NumRow,NumCol);
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
        Im(RowIdx,ColIdx,:) = xVec(VecIdx);
        Im(RowIdx,ColIdx+1,:) = xVec(VecIdx);
        VecIdx = VecIdx + 1;
    end
end

end

