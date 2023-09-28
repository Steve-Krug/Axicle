function [freq, TFM_yawrate_SWA, TFP_yawrate_SWA, TFM_slipangle_SWA, TFP_slipangle_SWA, ...
    TFM_Ay_SWA, TFP_Ay_SWA, TFM_roll_SWA, TFP_roll_SWA,TFM_Ay_Yaw,TFP_Ay_Yaw] = ...
    frequency_response( fs, frange_min, frange_max, SWA, yawrate, slipangle, ay, roll)

if 1==0

    [TFM_yawrate_SWA,freq] = tfestimate(SWA,yawrate,150,[],[.1:.1:5],fs);
    TFP_yawrate_SWA=unwrap(angle(TFM_yawrate_SWA))*180/pi;
    
    [TFM_slipangle_SWA,freq] = tfestimate(SWA,slipangle,150,[],[.1:.1:5],fs);
    TFP_slipangle_SWA=unwrap(angle(TFM_slipangle_SWA))*180/pi;
    
    [TFM_Ay_SWA,freq] = tfestimate(SWA,ay,150,[],[.1:.1:5],fs);
    TFP_Ay_SWA=unwrap(angle(TFM_Ay_SWA))*180/pi;
    
    [TFM_roll_SWA,freq] = tfestimate(SWA,roll,150,[],[.1:.1:5],fs);
    TFP_roll_SWA=unwrap(angle(TFM_roll_SWA))*180/pi;
    
    [TFM_Ay_Yaw,freq] = tfestimate(yawrate,ay,150,[],[.1:.1:5],fs);
    TFP_Ay_Yaw=unwrap(angle(TFM_Ay_Yaw))*180/pi;
else
    [freq,mag_SWA,ph_SWA] = fft_lite_v2(fs,SWA);
    [freq,mag_yawrate,ph_yawrate] = fft_lite_v2(fs,yawrate);
    [freq,mag_slipangle,ph_slipangle] = fft_lite_v2(fs,slipangle);
    [freq,mag_Ay,ph_Ay] = fft_lite_v2(fs,ay);
    
    frange=find((freq>=frange_min) & (freq<=frange_max));
    
    
    
    freq = freq(frange);
    %
    if roll == 0
        TFM_roll_SWA = 0;
        TFP_roll_SWA = 0;
        freq=freq(frange);
        mag_SWA = mag_SWA(frange);
        ph_SWA = ph_SWA(frange);
    else
        [freq,mag_roll,ph_roll] = fft_lite_v2(fs,roll);
        freq=freq(frange);
        mag_SWA = mag_SWA(frange);
        ph_SWA = ph_SWA(frange);
        mag_roll = mag_roll(frange);
        ph_roll = ph_roll(frange);
        TFM_roll_SWA = mag_roll./mag_SWA;
        TFP_roll_SWA = ph_roll-ph_SWA;
    end
    
    mag_yawrate = mag_yawrate(frange);
    mag_slipangle = mag_slipangle(frange);
    mag_Ay = mag_Ay(frange);
    
    ph_yawrate = ph_yawrate(frange);
    ph_slipangle = ph_slipangle(frange);
    ph_Ay = ph_Ay(frange);
    
    TFM_yawrate_SWA = mag_yawrate./mag_SWA;
    TFP_yawrate_SWA = ph_yawrate-ph_SWA;
    for j = 1:length(TFP_yawrate_SWA)
        if TFP_yawrate_SWA(j) > 100
            TFP_yawrate_SWA(j) = TFP_yawrate_SWA(j) - 360;
        end
    end
    
    TFM_slipangle_SWA = mag_slipangle./mag_SWA;
    TFP_slipangle_SWA = ph_slipangle-ph_SWA;
    for j = 1:length(TFP_slipangle_SWA)
        if TFP_slipangle_SWA(j) > 100
            TFP_slipangle_SWA(j) = TFP_slipangle_SWA(j) - 360;
        end
    end
    
    TFM_Ay_SWA = mag_Ay./mag_SWA;
    TFP_Ay_SWA = ph_Ay-ph_SWA;
    for j = 1:length(TFP_Ay_SWA)
        if TFP_Ay_SWA(j) > 100
            TFP_Ay_SWA(j) = TFP_Ay_SWA(j) - 360;
        end
    end
    
    TFM_Ay_Yaw = mag_Ay./mag_yawrate;
    TFP_Ay_Yaw = ph_Ay-ph_yawrate;
    for j = 1:length(TFP_Ay_Yaw)
        if TFP_Ay_Yaw(j) > 100
            TFP_Ay_Yaw(j) = TFP_Ay_Yaw(j) - 360;
        end
    end
end

%

end

