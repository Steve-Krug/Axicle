%% Link x axes of figures

try
    linkaxes([figWheelTorques_211 figWheelTorques_212...
        figYawRates_211 figYawRates_212...
        figControllers_211 figControllers_212...
        figSpeeds_211 figSpeeds_212...
        figdMz_221 figdMz_222 figdMz_223 figdMz_224...
        figWheelSlips_221 figWheelSlips_222 figWheelSlips_223 figWheelSlips_224...
        figForcesX_221 figForcesX_222 figForcesX_223 figForcesX_224...
        figForcesY_221 figForcesY_222 figForcesY_223 figForcesY_224...
        figForcesZ_221 figForcesZ_222 figForcesZ_223 figForcesZ_224...
        figMu_221 figMu_222 figMu_223 figMu_224...
        figGeneralMotion_241(2) figGeneralMotion_242(2) figGeneralMotion_243(2) figGeneralMotion_244(2)...
        figGeneralMotion_245(2) figGeneralMotion_246(2) figGeneralMotion_247(2) figGeneralMotion_248(2)...
        figOversteerPID_211 figOversteerPID_212...
        figUndersteerPID_211 figUndersteerPID_212...
        figBrakePressures_221 figBrakePressures_222 figBrakePressures_223 figBrakePressures_224...
        h_effectiveness(1) h_effectiveness(2)...
        h_states_refs(1) h_states_refs(2) h_states_refs(3) h_states_refs(4)...
        h_control_overview(1) h_control_overview(2) h_control_overview(3) h_control_overview(4)
        ],'x')
    disp('Successfully linked X axes of specified plots.')
catch
    disp('Error in linking axes of plots. Check linkStandardPlotAxes.m.')
end