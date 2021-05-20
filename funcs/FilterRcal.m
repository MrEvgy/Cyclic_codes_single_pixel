% LPF the R_cal curve.
function Rfix = FilterRcal(Rmod, m)
%     m = 20;
    Rfix = conv(Rmod,1/m*ones(1,m),'same');
    Rfix(1:m/2) = Rmod(1:m/2);
    Rfix(end-m/2:end) = Rmod(end-m/2:end);
end