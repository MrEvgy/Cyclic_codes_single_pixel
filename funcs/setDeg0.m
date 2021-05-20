function [degSample0] = setDeg0(V, DegScope, th_percent, Deg0_shift)
    th = min(V) + (max(V)-min(V))*th_percent; % Set treshold level.
    indx2 = find(V>th, 1);
    degSample0 = DegScope(indx2(1)) + Deg0_shift;
    
end