function [synAp] = synAperture(subFig)
%% This creates a synthetic aperture, since the aperture blocks part of the light
switch subFig
    case 4
        rad = 87; % Radius of aperture
        rat = 0.7; % ratio between x and y (to create elipsoid)

        [X,Y] = meshgrid(-333/4:0.5:333/4,-96:1:96);
        R = sqrt(X.^2/rat + Y.^2);

        synAp = zeros(193,334);
        synAp(R<rad) = 1;
    case 5
        p = 101;
        %% This creates a synthetic aperture. 
        rad = 44; % Radius of aperture
        rat = 0.25; % ratio between x and y (to create elipsoid)

        [X,Y] = meshgrid(-(p+1)/4:0.5:(p+1)/4, -(p-1)/2:1:(p-1)/2);
        Y = Y + 4;
        R = sqrt(X.^2/rat + Y.^2);
        synAp = zeros(101,103);
        synAp(R<rad) = 1;
    
    case 42   
        rad = 84; % Radius of aperture
        rat = 0.7; % ratio between x and y (to create elipsoid)
        [X,Y] = meshgrid(-333/4:0.5:333/4,-96:1:96);
        Y = Y-7;
        R = sqrt(X.^2/rat + Y.^2);
        synAp = zeros(193,334);
        synAp(R<rad) = 1;
        
    case 43
        rad = 84; % Radius of aperture
        rat = 0.7; % ratio between x and y (to create elipsoid)
        [X,Y] = meshgrid(-333/4:0.5:333/4,-96:1:96);
        Y = Y-7;
        R = sqrt(X.^2/rat + Y.^2);
        synAp = zeros(193,334);
        synAp(R<rad) = 1;
end
end

