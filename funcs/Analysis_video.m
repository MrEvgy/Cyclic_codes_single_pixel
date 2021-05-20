function [J_sh] = Analysis_video(V,t,piRotate,sampleParam,p,numAvg,subFig)
    
    if subFig == 41 % Reconstruct video 4.1 - square pixels
        for fr = 1:sampleParam.frames % Perform analysis per frame
            sampleParam.shiftDeg0 = sampleParam.teta0 + fr*sampleParam.angle_step;
            [I(fr,:,:),VInterp(fr,:)] =  Analysis_Square_vecS(V,t,piRotate,sampleParam,sampleParam.p,numAvg,subFig);
            J(fr,:,:) = flip(rot90((I(fr,:,:)),2),3);
        end           
    elseif subFig == 42 || subFig == 43 % Reconstruct video 4.2&4.3 - hexagon pixels
        if sampleParam.Back  == 1 % Remove background [optional]
            load(sampleParam.PathBack);
            sampleParamB = sampleParam;
            sampleParamB.Back = 0;
            sampleParamB.Aper = 0;
            for fr = 1:sampleParam.frames % Perform analysis per frame    
                [I_bk(fr,:,:),VInterp_bk(fr,:)] =  Analysis(V(fr+1,:),t(fr+1,:),piRotate,sampleParamB,sampleParamB.N,numAvg,subFig);
            end
            sampleParam.Background = squeeze(mean(I_bk,1));    
        end
        
        if subFig == 42 
            load('data\dataFig4b.mat');
        elseif subFig == 43
            load('data\dataFig4c.mat');
        end
        for fr = 1:sampleParam.frames % Perform analysis per frame       
            [I(fr,:,:),VInterp(fr,:)] =  Analysis(V(fr+1,:),t(fr+1,:),piRotate,sampleParam,sampleParam.N,numAvg,subFig);
            J(fr,:,:) = flip(rot90((I(fr,:,:)),2),3);
        end
    end
 
    int_factor = 5; % x5 interpolation
    for fr=1:sampleParam.frames
        Ji(fr,:,:) = imInterp(squeeze(J(fr,:,:)), int_factor);
    end
    if subFig == 41   % Compensate for position shift based on calibration.
        load(sampleParam.PathCalib);
        for fr=1:sampleParam.frames    % Alighment per frame
            J_sh(fr,:,:) = imtranslate(squeeze(Ji(fr,:,:)), [shift_x(fr),shift_y(fr)]);
        end
    elseif subFig == 42 || subFig == 43
        J_sh = flip(Ji,2);
        J_sh = flip(J_sh,3);
    end
    
end
