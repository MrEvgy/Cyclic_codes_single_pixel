function [Ii] = imInterp(I, int_factor)

    L = size(I);

    x = 1 : 1 : L(2);
    y = 1 : 1 : L(1);
    [X,Y] = meshgrid(x,y);

    xi = linspace(1,L(2),L(2)*int_factor);
    yi = linspace(1,L(1),L(1)*int_factor);
    [Xi, Yi] = meshgrid(xi,yi);
    
    Ii = interp2(X, Y, I, Xi, Yi);

end