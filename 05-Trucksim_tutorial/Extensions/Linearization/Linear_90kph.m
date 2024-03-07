% MATLAB linearized TruckSim 2023.0 model, calculated at t = 200.012 s.
% TITLE Root Locus (Speed Series) <Advanced: Restore State, Linearize, Gravity>
% Run was made 11:49 on August 17, 2023.

% 
% Revision 192644, December 2, 2022


% The linear equations have the form:
%     SV' = MatrixA * SV + MatrixB * IN
%     OUT = MatrixC * SV + MatrixD * IN

% All perturbations are given with internal SI units.

% -----------------------------------------------------------------------------------
% 52 STATE VARIABLES
% -----------------------------------------------------------------------------------
% SV(1) = SV_ZO: Global Z coord. of sprung-mass origin {Zo}; perturbation = 0.001
% SV(2) = SV_PITCH: Pitch of sprung mass {Pitch}; perturbation = 0.001
% SV(3) = SV_ROLL: Roll (Euler) of sprung mass {Roll_E}; perturbation = 0.001
% SV(4) = SV_SWA: Steering wheel angle; perturbation = 0.001
% SV(5) = SV_AV_SW: Steering wheel angular rate {StrAV_SW}; perturbation = 0.001
% SV(6) = SV_STR_IN_GR_A1: Steering gear input position, axle 1 {A_StrIn1}; perturbation = 0.001
% SV(7) = SV_STR_IN_DGR_A1: Steering gear input rate, axle 1; perturbation = 0.001
% SV(8) = SV_ROLL_A1: Roll of axle 1; perturbation = 0.001
% SV(9) = SV_JNC_A1: Jounce of axle 1; perturbation = 0.001
% SV(10) = SV_ROT_L1: Rotation of wheel L1; perturbation = 0.001
% SV(11) = SV_ROT_R1: Rotation of wheel R1; perturbation = 0.001
% SV(12) = SV_ROLL_A2: Roll of axle 2; perturbation = 0.001
% SV(13) = SV_JNC_A2: Jounce of axle 2; perturbation = 0.001
% SV(14) = SV_ROT_L2: Rotation of wheel L2; perturbation = 0.001
% SV(15) = SV_ROT_R2: Rotation of wheel R2; perturbation = 0.001
% SV(16) = SV_SLIP_LAT_L1I: Lagged tan of lateral slip, tire L1i; perturbation = 0.001
% SV(17) = SV_SLIP_LONG_L1I: Lagged long. slip, tire L1i {KappL_L1i}; perturbation = 0.001
% SV(18) = SV_SLIP_LAT_L1O: Lagged tan of lateral slip, tire L1o; perturbation = 0.001
% SV(19) = SV_SLIP_LONG_L1O: Lagged long. slip, tire L1o {KappL_L1o}; perturbation = 0.001
% SV(20) = SV_SLIP_LAT_R1I: Lagged tan of lateral slip, tire R1i; perturbation = 0.001
% SV(21) = SV_SLIP_LONG_R1I: Lagged long. slip, tire R1i {KappL_R1i}; perturbation = 0.001
% SV(22) = SV_SLIP_LAT_R1O: Lagged tan of lateral slip, tire R1o; perturbation = 0.001
% SV(23) = SV_SLIP_LONG_R1O: Lagged long. slip, tire R1o {KappL_R1o}; perturbation = 0.001
% SV(24) = SV_SLIP_LAT_L2I: Lagged tan of lateral slip, tire L2i; perturbation = 0.001
% SV(25) = SV_SLIP_LONG_L2I: Lagged long. slip, tire L2i {KappL_L2i}; perturbation = 0.001
% SV(26) = SV_SLIP_LAT_L2O: Lagged tan of lateral slip, tire L2o; perturbation = 0.001
% SV(27) = SV_SLIP_LONG_L2O: Lagged long. slip, tire L2o {KappL_L2o}; perturbation = 0.001
% SV(28) = SV_SLIP_LAT_R2I: Lagged tan of lateral slip, tire R2i; perturbation = 0.001
% SV(29) = SV_SLIP_LONG_R2I: Lagged long. slip, tire R2i {KappL_R2i}; perturbation = 0.001
% SV(30) = SV_SLIP_LAT_R2O: Lagged tan of lateral slip, tire R2o; perturbation = 0.001
% SV(31) = SV_SLIP_LONG_R2O: Lagged long. slip, tire R2o {KappL_R2o}; perturbation = 0.001
% SV(32) = SV_ROT_TR_OUT: Transmission output shaft rotation; perturbation = 0.001
% SV(33) = SV_ROT_SHAFT_1: 1st drive axle diff input shaft rotation {Rot_D3f}; perturbation = 0.001
% SV(34) = SV_ROT_SHAFT_2: 2nd drive axle diff input shaft rotation {Rot_D3r}; perturbation = 0.001
% SV(35) = SV_ROT_SHAFT_3: Transfer case input shaft rotation ; perturbation = 0.001
% SV(36) = SV_VXS: Body-X speed of laden sprung-mass CG; perturbation = 0.001
% SV(37) = SV_VYS: Body-Y speed of laden sprung-mass CG; perturbation = 0.001
% SV(38) = SV_VZS: Body-Z speed of laden sprung-mass CG; perturbation = 0.001
% SV(39) = SV_AVZ: Body-Z yaw rate of sprung-mass {AVz}; perturbation = 0.001
% SV(40) = SV_AVY: Body-Y pitch rate of sprung-mass {AVy}; perturbation = 0.001
% SV(41) = SV_AVX: Body-X roll rate of sprung-mass {AVx}; perturbation = 0.001
% SV(42) = SV_AVX_A1: Roll rate of axle 1; perturbation = 0.001
% SV(43) = SV_JNCR_A1: Jounce rate of axle 1; perturbation = 0.001
% SV(44) = SV_AVY_L1: Spin of wheel L1 {AVy_L1}; perturbation = 0.001
% SV(45) = SV_AVY_R1: Spin of wheel R1 {AVy_R1}; perturbation = 0.001
% SV(46) = SV_AVX_A2: Roll rate of axle 2; perturbation = 0.001
% SV(47) = SV_JNCR_A2: Jounce rate of axle 2; perturbation = 0.001
% SV(48) = SV_AVY_L2: Spin of wheel L2 {AVy_L2}; perturbation = 0.001
% SV(49) = SV_AVY_R2: Spin of wheel R2 {AVy_R2}; perturbation = 0.001
% SV(50) = SV_AV_ENG: Engine crankshaft spin {AV_Eng}; perturbation = 0.001
% SV(51) = SV_AV_TC: Torque coupling output shaft spin {AV_TC}; perturbation = 0.001
% SV(52) = SV_AV_TR_OUT: Transmission output shaft spin; perturbation = 0.001

% -----------------------------------------------------------------------------------
% 1 INPUT/CONTROL VARIABLE
% -----------------------------------------------------------------------------------
% IN(1) = IMP_STEER_SW: Steering wheel angle; perturbation = 0.001

% -----------------------------------------------------------------------------------
% 2 OUTPUT VARIABLES
% -----------------------------------------------------------------------------------
% OUT(1) = AVz; Yaw rate (body-fixed), vehicle
% OUT(2) = Ay; Lat. accel., inst. CG, vehicle

% -----------------------------------------------------------------------------------
% DEFINE MATRICES FOR LINEAR SYSTEM
% -----------------------------------------------------------------------------------
MatrixA = zeros(52, 52);

MatrixA(1,2) = -24.9994;
MatrixA(1,3) = -0.00032803;
MatrixA(1,36) = -0.0321025;
MatrixA(1,37) = 0.00182712;
MatrixA(1,38) = 0.999483;
MatrixA(1,39) = 0.00235699;
MatrixA(1,40) = -1.26205;
MatrixA(1,41) = 0.00155306;
MatrixA(2,3) = 2.29813e-05;
MatrixA(2,39) = -0.00182807;
MatrixA(2,40) = 0.999998;
MatrixA(3,2) = -2.30055e-05;
MatrixA(3,3) = -1.61805e-08;
MatrixA(3,39) = 0.032119;
MatrixA(3,40) = 5.87158e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238018;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 1.75652e-07;
MatrixA(16,2) = -0.000964124;
MatrixA(16,3) = -1.0912e-06;
MatrixA(16,6) = -2.07239;
MatrixA(16,7) = -0.00083478;
MatrixA(16,8) = 1.16478;
MatrixA(16,9) = -9.35963e-07;
MatrixA(16,16) = -35.1203;
MatrixA(16,36) = -4.08022e-06;
MatrixA(16,37) = 1.40233;
MatrixA(16,38) = -0.0025637;
MatrixA(16,39) = 1.82621;
MatrixA(16,40) = 0.0033419;
MatrixA(16,41) = 1.13443;
MatrixA(16,42) = 0.464118;
MatrixA(16,43) = 3.81184e-05;
MatrixA(20,1) = 1.74659e-07;
MatrixA(20,2) = -0.000965885;
MatrixA(20,3) = -1.24836e-06;
MatrixA(20,6) = -2.07613;
MatrixA(20,7) = -0.000836435;
MatrixA(20,8) = 1.09128;
MatrixA(20,9) = -9.39117e-07;
MatrixA(20,20) = -35.1844;
MatrixA(20,36) = -4.08768e-06;
MatrixA(20,37) = 1.4049;
MatrixA(20,38) = -0.00256838;
MatrixA(20,39) = 1.82954;
MatrixA(20,40) = 0.003348;
MatrixA(20,41) = 1.13651;
MatrixA(20,42) = 0.464967;
MatrixA(20,43) = 3.81881e-05;
MatrixA(24,1) = 5.78023e-07;
MatrixA(24,2) = 0.0030193;
MatrixA(24,3) = 1.71526e-06;
MatrixA(24,12) = 2.84869;
MatrixA(24,13) = -1.09318e-05;
MatrixA(24,24) = -81.2447;
MatrixA(24,36) = -1.95508e-05;
MatrixA(24,37) = 3.24404;
MatrixA(24,38) = -0.00593096;
MatrixA(24,39) = -6.77069;
MatrixA(24,40) = -0.0123607;
MatrixA(24,41) = 2.97746;
MatrixA(24,46) = 1.58873;
MatrixA(24,47) = -8.06972e-05;
MatrixA(26,1) = 5.78279e-07;
MatrixA(26,2) = 0.00302289;
MatrixA(26,3) = 1.94967e-06;
MatrixA(26,12) = 2.95153;
MatrixA(26,13) = -1.09412e-05;
MatrixA(26,26) = -81.3051;
MatrixA(26,36) = -1.95653e-05;
MatrixA(26,37) = 3.24646;
MatrixA(26,38) = -0.00593538;
MatrixA(26,39) = -6.77572;
MatrixA(26,40) = -0.0123698;
MatrixA(26,41) = 2.97968;
MatrixA(26,46) = 1.58991;
MatrixA(26,47) = -8.07572e-05;
MatrixA(28,1) = 5.76605e-07;
MatrixA(28,2) = 0.00299953;
MatrixA(28,3) = 6.66044e-07;
MatrixA(28,12) = 2.3893;
MatrixA(28,13) = -1.088e-05;
MatrixA(28,28) = -80.9106;
MatrixA(28,36) = -1.94704e-05;
MatrixA(28,37) = 3.23071;
MatrixA(28,38) = -0.00590659;
MatrixA(28,39) = -6.7429;
MatrixA(28,40) = -0.0123099;
MatrixA(28,41) = 2.96523;
MatrixA(28,46) = 1.5822;
MatrixA(28,47) = -8.03655e-05;
MatrixA(30,1) = 5.76351e-07;
MatrixA(30,2) = 0.002996;
MatrixA(30,3) = 5.12653e-07;
MatrixA(30,12) = 2.3223;
MatrixA(30,13) = -1.08707e-05;
MatrixA(30,30) = -80.8507;
MatrixA(30,36) = -1.9456e-05;
MatrixA(30,37) = 3.22832;
MatrixA(30,38) = -0.00590222;
MatrixA(30,39) = -6.73791;
MatrixA(30,40) = -0.0123008;
MatrixA(30,41) = 2.96303;
MatrixA(30,46) = 1.58103;
MatrixA(30,47) = -8.03061e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 75.2397;
MatrixA(36,2) = 232.844;
MatrixA(36,3) = -0.0133631;
MatrixA(36,6) = 7.56125e-05;
MatrixA(36,7) = -1.29551e-06;
MatrixA(36,8) = 1.19158;
MatrixA(36,9) = -12.8729;
MatrixA(36,12) = 10.6874;
MatrixA(36,13) = 136.487;
MatrixA(36,16) = 7.77346;
MatrixA(36,20) = 7.76981;
MatrixA(36,24) = 3.4267;
MatrixA(36,26) = 3.4233;
MatrixA(36,28) = 3.44706;
MatrixA(36,30) = 3.45047;
MatrixA(36,32) = -0.0036759;
MatrixA(36,35) = 0.0036759;
MatrixA(36,36) = -4.40021;
MatrixA(36,37) = -0.000274727;
MatrixA(36,38) = -0.141335;
MatrixA(36,39) = -0.00465563;
MatrixA(36,40) = 2.93468;
MatrixA(36,41) = -3.0941e-05;
MatrixA(36,42) = -0.000133224;
MatrixA(36,43) = -0.317675;
MatrixA(36,44) = 0.514361;
MatrixA(36,45) = 0.513224;
MatrixA(36,46) = 2.47891e-05;
MatrixA(36,47) = 0.659158;
MatrixA(36,48) = 0.347967;
MatrixA(36,49) = 0.35028;
MatrixA(36,52) = -0.000117007;
MatrixA(37,1) = 0.0194629;
MatrixA(37,2) = 0.0113686;
MatrixA(37,3) = 99.3201;
MatrixA(37,6) = 0.0118555;
MatrixA(37,7) = 0.00736311;
MatrixA(37,8) = -165.352;
MatrixA(37,9) = 10.1855;
MatrixA(37,12) = 214.194;
MatrixA(37,13) = -1.32734;
MatrixA(37,16) = -34.8803;
MatrixA(37,20) = -34.5681;
MatrixA(37,24) = -7.51629;
MatrixA(37,26) = -7.50949;
MatrixA(37,28) = -7.28588;
MatrixA(37,30) = -7.29241;
MatrixA(37,32) = -0.00475805;
MatrixA(37,35) = 0.00475805;
MatrixA(37,36) = 0.000214226;
MatrixA(37,37) = -0.0291237;
MatrixA(37,38) = 6.00987e-05;
MatrixA(37,39) = -25.0459;
MatrixA(37,40) = -0.000266368;
MatrixA(37,41) = 0.788559;
MatrixA(37,42) = -1.06373;
MatrixA(37,43) = 0.0117913;
MatrixA(37,44) = -0.00328888;
MatrixA(37,45) = 0.0113498;
MatrixA(37,46) = 0.266163;
MatrixA(37,47) = 0.00911387;
MatrixA(37,48) = -0.0182224;
MatrixA(37,49) = 0.0107078;
MatrixA(37,52) = -0.000151453;
MatrixA(38,1) = -7.82135;
MatrixA(38,2) = -26.1868;
MatrixA(38,3) = -0.156843;
MatrixA(38,6) = -2.12137e-05;
MatrixA(38,7) = -1.37252e-05;
MatrixA(38,8) = -31.8223;
MatrixA(38,9) = 577.882;
MatrixA(38,12) = 64.2333;
MatrixA(38,13) = 393.69;
MatrixA(38,16) = 0.156623;
MatrixA(38,20) = 0.156011;
MatrixA(38,24) = -0.382359;
MatrixA(38,26) = -0.381979;
MatrixA(38,28) = -0.385092;
MatrixA(38,30) = -0.385474;
MatrixA(38,32) = 0.000288633;
MatrixA(38,35) = -0.000288633;
MatrixA(38,36) = 0.180364;
MatrixA(38,37) = -2.46843e-06;
MatrixA(38,38) = 0.00579336;
MatrixA(38,39) = 0.000932935;
MatrixA(38,40) = 24.8377;
MatrixA(38,41) = -0.00156658;
MatrixA(38,42) = 0.00269871;
MatrixA(38,43) = 6.84037;
MatrixA(38,44) = 0.006061;
MatrixA(38,45) = 0.00602111;
MatrixA(38,46) = -0.000459446;
MatrixA(38,47) = 5.46812;
MatrixA(38,48) = -0.0401702;
MatrixA(38,49) = -0.040486;
MatrixA(38,52) = 9.18747e-06;
MatrixA(39,1) = 0.026975;
MatrixA(39,2) = 0.0613016;
MatrixA(39,3) = -220.024;
MatrixA(39,6) = 0.00624786;
MatrixA(39,7) = 0.0048876;
MatrixA(39,8) = -76.8721;
MatrixA(39,9) = 3.88397;
MatrixA(39,12) = -201.727;
MatrixA(39,13) = 2.83516;
MatrixA(39,16) = -20.1694;
MatrixA(39,20) = -15.128;
MatrixA(39,24) = 5.20298;
MatrixA(39,26) = 5.19838;
MatrixA(39,28) = 7.69446;
MatrixA(39,30) = 7.70149;
MatrixA(39,32) = -0.00615552;
MatrixA(39,35) = 0.00615552;
MatrixA(39,36) = -0.00162625;
MatrixA(39,37) = -0.0026591;
MatrixA(39,38) = -4.73745e-05;
MatrixA(39,39) = -1.20045;
MatrixA(39,40) = -0.00081026;
MatrixA(39,41) = -0.145908;
MatrixA(39,42) = -0.469597;
MatrixA(39,43) = 0.00620262;
MatrixA(39,44) = -0.165506;
MatrixA(39,45) = 0.16455;
MatrixA(39,46) = -0.515347;
MatrixA(39,47) = -0.00811247;
MatrixA(39,48) = -0.122903;
MatrixA(39,49) = 0.125302;
MatrixA(39,52) = -0.000195936;
MatrixA(40,1) = -20.9574;
MatrixA(40,2) = -65.861;
MatrixA(40,3) = -0.372056;
MatrixA(40,6) = 3.64442e-06;
MatrixA(40,7) = 9.14547e-06;
MatrixA(40,8) = 15.0399;
MatrixA(40,9) = -274.199;
MatrixA(40,12) = 48.2539;
MatrixA(40,13) = 281.611;
MatrixA(40,16) = -1.19046;
MatrixA(40,20) = -1.1808;
MatrixA(40,24) = -0.990101;
MatrixA(40,26) = -0.989118;
MatrixA(40,28) = -0.991634;
MatrixA(40,30) = -0.992615;
MatrixA(40,32) = -0.0403607;
MatrixA(40,35) = 0.0403607;
MatrixA(40,36) = 0.903156;
MatrixA(40,37) = 5.03683e-05;
MatrixA(40,38) = 0.0290096;
MatrixA(40,39) = -0.000212913;
MatrixA(40,40) = -0.770723;
MatrixA(40,41) = -0.000283093;
MatrixA(40,42) = -0.0011068;
MatrixA(40,43) = -3.22148;
MatrixA(40,44) = -0.0752816;
MatrixA(40,45) = -0.0745155;
MatrixA(40,46) = -0.000818194;
MatrixA(40,47) = 4.16145;
MatrixA(40,48) = -0.100326;
MatrixA(40,49) = -0.100562;
MatrixA(40,52) = -0.00128472;
MatrixA(41,1) = 0.0233411;
MatrixA(41,2) = 0.0175382;
MatrixA(41,3) = 115.631;
MatrixA(41,6) = 0.0130929;
MatrixA(41,7) = 0.00803268;
MatrixA(41,8) = 147.459;
MatrixA(41,9) = -31.2892;
MatrixA(41,12) = 518.318;
MatrixA(41,13) = -31.4708;
MatrixA(41,16) = -38.3451;
MatrixA(41,20) = -38.4792;
MatrixA(41,24) = -7.99777;
MatrixA(41,26) = -7.99054;
MatrixA(41,28) = -7.98057;
MatrixA(41,30) = -7.98774;
MatrixA(41,32) = 0.0595564;
MatrixA(41,35) = -0.0595564;
MatrixA(41,36) = 0.000238626;
MatrixA(41,37) = -0.0202461;
MatrixA(41,38) = 4.46784e-05;
MatrixA(41,39) = 0.0648151;
MatrixA(41,40) = -8.26156e-05;
MatrixA(41,41) = -0.000989329;
MatrixA(41,42) = 3.75961;
MatrixA(41,43) = 0.0130125;
MatrixA(41,44) = 0.0100468;
MatrixA(41,45) = -0.00543422;
MatrixA(41,46) = 4.27644;
MatrixA(41,47) = 0.00988002;
MatrixA(41,48) = -0.0100974;
MatrixA(41,49) = -0.00238096;
MatrixA(41,52) = 0.00189574;
MatrixA(42,1) = 0.247798;
MatrixA(42,2) = -0.0466319;
MatrixA(42,3) = -11485.8;
MatrixA(42,6) = 0.743822;
MatrixA(42,7) = 0.887844;
MatrixA(42,8) = -17552.1;
MatrixA(42,9) = 804.556;
MatrixA(42,12) = -430.25;
MatrixA(42,13) = 25.8959;
MatrixA(42,16) = -523.585;
MatrixA(42,20) = -542.028;
MatrixA(42,24) = 5.97678;
MatrixA(42,26) = 5.97145;
MatrixA(42,28) = 7.46697;
MatrixA(42,30) = 7.47375;
MatrixA(42,32) = -0.643694;
MatrixA(42,35) = 0.643694;
MatrixA(42,36) = -0.00453975;
MatrixA(42,37) = 0.0018081;
MatrixA(42,38) = -0.000149101;
MatrixA(42,39) = 17.7224;
MatrixA(42,40) = 0.0366824;
MatrixA(42,41) = -0.195854;
MatrixA(42,42) = -93.4934;
MatrixA(42,43) = -0.0107033;
MatrixA(42,44) = 0.925594;
MatrixA(42,45) = -0.384785;
MatrixA(42,46) = -3.55803;
MatrixA(42,47) = -0.00848761;
MatrixA(42,48) = -0.300668;
MatrixA(42,49) = -0.154355;
MatrixA(42,52) = -0.0204894;
MatrixA(43,1) = -3792.67;
MatrixA(43,2) = -8.28951;
MatrixA(43,3) = 1.5014;
MatrixA(43,6) = 5.72353e-05;
MatrixA(43,7) = 7.95068e-05;
MatrixA(43,8) = 401.703;
MatrixA(43,9) = -11053.4;
MatrixA(43,12) = -2.40236;
MatrixA(43,13) = -30.3856;
MatrixA(43,16) = 1.71557;
MatrixA(43,20) = 1.7125;
MatrixA(43,24) = -0.885697;
MatrixA(43,26) = -0.884818;
MatrixA(43,28) = -0.8912;
MatrixA(43,30) = -0.892082;
MatrixA(43,32) = -0.0524464;
MatrixA(43,35) = 0.0524464;
MatrixA(43,36) = -0.132737;
MatrixA(43,37) = 8.24009e-05;
MatrixA(43,38) = -0.00426371;
MatrixA(43,39) = 0.0038492;
MatrixA(43,40) = 0.105065;
MatrixA(43,41) = -0.000414003;
MatrixA(43,42) = -0.0215827;
MatrixA(43,43) = -86.2197;
MatrixA(43,44) = 0.117106;
MatrixA(43,45) = 0.116697;
MatrixA(43,46) = -0.00399887;
MatrixA(43,47) = -0.0998561;
MatrixA(43,48) = -0.0889434;
MatrixA(43,49) = -0.0895714;
MatrixA(43,52) = -0.00166942;
MatrixA(44,1) = 387.27;
MatrixA(44,2) = 57.965;
MatrixA(44,3) = 320.076;
MatrixA(44,6) = -0.0277306;
MatrixA(44,7) = 0.194388;
MatrixA(44,8) = 305.315;
MatrixA(44,9) = 640.327;
MatrixA(44,12) = -48.6283;
MatrixA(44,13) = -281.605;
MatrixA(44,16) = -1368.09;
MatrixA(44,20) = 17.8862;
MatrixA(44,24) = 0.999759;
MatrixA(44,26) = 0.998767;
MatrixA(44,28) = 1.00591;
MatrixA(44,30) = 1.0069;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 226.675;
MatrixA(44,37) = 0.012747;
MatrixA(44,38) = 7.28087;
MatrixA(44,39) = -203.91;
MatrixA(44,40) = -193.238;
MatrixA(44,41) = 6.56001;
MatrixA(44,42) = 6.55372;
MatrixA(44,43) = 10.5314;
MatrixA(44,44) = -96.1491;
MatrixA(44,45) = -2.38304;
MatrixA(44,46) = -0.000140242;
MatrixA(44,47) = -4.16146;
MatrixA(44,48) = 4.05928;
MatrixA(44,49) = 4.05998;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 388.124;
MatrixA(45,2) = 57.9594;
MatrixA(45,3) = -338.241;
MatrixA(45,6) = 0.0169102;
MatrixA(45,7) = -0.19405;
MatrixA(45,8) = -353.001;
MatrixA(45,9) = 641.181;
MatrixA(45,12) = -48.6283;
MatrixA(45,13) = -281.605;
MatrixA(45,16) = 17.8958;
MatrixA(45,20) = -1367.33;
MatrixA(45,24) = 0.999759;
MatrixA(45,26) = 0.998767;
MatrixA(45,28) = 1.00591;
MatrixA(45,30) = 1.0069;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 226.141;
MatrixA(45,37) = 0.0127169;
MatrixA(45,38) = 7.26371;
MatrixA(45,39) = 203.748;
MatrixA(45,40) = -192.038;
MatrixA(45,41) = -6.53362;
MatrixA(45,42) = -6.5399;
MatrixA(45,43) = 10.5142;
MatrixA(45,44) = -2.38035;
MatrixA(45,45) = -95.9415;
MatrixA(45,46) = -0.000140242;
MatrixA(45,47) = -4.16146;
MatrixA(45,48) = 4.05928;
MatrixA(45,49) = 4.05998;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 0.37784;
MatrixA(46,2) = 1.53112;
MatrixA(46,3) = -27709.5;
MatrixA(46,6) = -0.0149615;
MatrixA(46,7) = -0.0082646;
MatrixA(46,8) = -172.938;
MatrixA(46,9) = 36.1935;
MatrixA(46,12) = -33563.7;
MatrixA(46,13) = 601.085;
MatrixA(46,16) = 42.1938;
MatrixA(46,20) = 46.775;
MatrixA(46,24) = -253.265;
MatrixA(46,26) = -253.041;
MatrixA(46,28) = -264.731;
MatrixA(46,30) = -264.965;
MatrixA(46,32) = -0.677266;
MatrixA(46,35) = 0.677266;
MatrixA(46,36) = 0.0110851;
MatrixA(46,37) = 0.0341105;
MatrixA(46,38) = 0.000293723;
MatrixA(46,39) = 13.2681;
MatrixA(46,40) = 0.0145522;
MatrixA(46,41) = -0.215839;
MatrixA(46,42) = -4.41897;
MatrixA(46,43) = -0.0147087;
MatrixA(46,44) = -0.396328;
MatrixA(46,45) = -0.0859693;
MatrixA(46,46) = -79.8753;
MatrixA(46,47) = -0.0108015;
MatrixA(46,48) = 0.768384;
MatrixA(46,49) = -0.202066;
MatrixA(46,52) = -0.021558;
MatrixA(47,1) = -6564.57;
MatrixA(47,2) = -22180.7;
MatrixA(47,3) = 9.41032;
MatrixA(47,6) = 4.77564e-07;
MatrixA(47,7) = -4.41357e-06;
MatrixA(47,8) = 0.857407;
MatrixA(47,9) = -15.6341;
MatrixA(47,12) = -795.028;
MatrixA(47,13) = -11496.7;
MatrixA(47,16) = 1.45471;
MatrixA(47,20) = 1.45369;
MatrixA(47,24) = 7.7504;
MatrixA(47,26) = 7.74272;
MatrixA(47,28) = 7.79799;
MatrixA(47,30) = 7.80569;
MatrixA(47,32) = 0.081787;
MatrixA(47,35) = -0.081787;
MatrixA(47,36) = -4.4733;
MatrixA(47,37) = -0.000191858;
MatrixA(47,38) = -0.143684;
MatrixA(47,39) = -0.0181698;
MatrixA(47,40) = 3.8061;
MatrixA(47,41) = -0.000249114;
MatrixA(47,42) = -0.00238107;
MatrixA(47,43) = -0.217031;
MatrixA(47,44) = 0.0923039;
MatrixA(47,45) = 0.0920746;
MatrixA(47,46) = 0.0103358;
MatrixA(47,47) = -67.7061;
MatrixA(47,48) = 0.77852;
MatrixA(47,49) = 0.783862;
MatrixA(47,52) = 0.00260336;
MatrixA(48,1) = 1368.06;
MatrixA(48,2) = 4641.61;
MatrixA(48,3) = 1316.3;
MatrixA(48,6) = 7.62683e-06;
MatrixA(48,7) = -3.28139e-07;
MatrixA(48,8) = -15.1785;
MatrixA(48,9) = 274.206;
MatrixA(48,12) = 1269.4;
MatrixA(48,13) = 1060.22;
MatrixA(48,16) = 1.15408;
MatrixA(48,20) = 1.1535;
MatrixA(48,24) = -829.871;
MatrixA(48,26) = -829.048;
MatrixA(48,28) = 14.684;
MatrixA(48,30) = 14.6985;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 210.279;
MatrixA(48,37) = 0.0121819;
MatrixA(48,38) = 6.75421;
MatrixA(48,39) = -207.186;
MatrixA(48,40) = -179.293;
MatrixA(48,41) = 6.66472;
MatrixA(48,42) = 0.000259633;
MatrixA(48,43) = 3.22148;
MatrixA(48,44) = 5.35341;
MatrixA(48,45) = 5.35324;
MatrixA(48,46) = 6.66055;
MatrixA(48,47) = 24.7951;
MatrixA(48,48) = -91.829;
MatrixA(48,49) = -3.24726;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 1359.32;
MatrixA(49,2) = 4611.2;
MatrixA(49,3) = -1320.2;
MatrixA(49,6) = 7.62683e-06;
MatrixA(49,7) = -3.28139e-07;
MatrixA(49,8) = -15.1785;
MatrixA(49,9) = 274.206;
MatrixA(49,12) = -1367.11;
MatrixA(49,13) = 1051.51;
MatrixA(49,16) = 1.15408;
MatrixA(49,20) = 1.1535;
MatrixA(49,24) = 14.5983;
MatrixA(49,26) = 14.5838;
MatrixA(49,28) = -834.731;
MatrixA(49,30) = -835.556;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 211.709;
MatrixA(49,37) = 0.0122648;
MatrixA(49,38) = 6.80014;
MatrixA(49,39) = 208.834;
MatrixA(49,40) = -179.749;
MatrixA(49,41) = -6.69738;
MatrixA(49,42) = 0.000259633;
MatrixA(49,43) = 3.22148;
MatrixA(49,44) = 5.35341;
MatrixA(49,45) = 5.35324;
MatrixA(49,46) = -6.70158;
MatrixA(49,47) = 24.9912;
MatrixA(49,48) = -3.257;
MatrixA(49,49) = -92.3819;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = -9.68326e-06;
MatrixA(50,2) = -9.68326e-06;
MatrixA(50,3) = -9.68326e-06;
MatrixA(50,4) = -9.68326e-06;
MatrixA(50,5) = -9.68326e-06;
MatrixA(50,6) = -9.68326e-06;
MatrixA(50,7) = -9.68326e-06;
MatrixA(50,8) = -9.68326e-06;
MatrixA(50,9) = -9.68326e-06;
MatrixA(50,10) = -9.68326e-06;
MatrixA(50,11) = -9.68326e-06;
MatrixA(50,12) = -9.68326e-06;
MatrixA(50,13) = -9.68326e-06;
MatrixA(50,14) = -9.68326e-06;
MatrixA(50,15) = -9.68326e-06;
MatrixA(50,16) = -9.68326e-06;
MatrixA(50,17) = -9.68326e-06;
MatrixA(50,18) = -9.68326e-06;
MatrixA(50,19) = -9.68326e-06;
MatrixA(50,20) = -9.68326e-06;
MatrixA(50,21) = -9.68326e-06;
MatrixA(50,22) = -9.68326e-06;
MatrixA(50,23) = -9.68326e-06;
MatrixA(50,24) = -9.68326e-06;
MatrixA(50,25) = -9.68326e-06;
MatrixA(50,26) = -9.68326e-06;
MatrixA(50,27) = -9.68326e-06;
MatrixA(50,28) = -9.68326e-06;
MatrixA(50,29) = -9.68326e-06;
MatrixA(50,30) = -9.68326e-06;
MatrixA(50,31) = -9.68326e-06;
MatrixA(50,32) = -9.68326e-06;
MatrixA(50,33) = -9.68326e-06;
MatrixA(50,34) = -9.68326e-06;
MatrixA(50,35) = -9.68326e-06;
MatrixA(50,36) = -1358.57;
MatrixA(50,37) = -9.68326e-06;
MatrixA(50,38) = -43.6631;
MatrixA(50,39) = -9.68326e-06;
MatrixA(50,40) = -9.68326e-06;
MatrixA(50,41) = -9.68326e-06;
MatrixA(50,42) = -9.68326e-06;
MatrixA(50,43) = -9.68326e-06;
MatrixA(50,44) = -9.68326e-06;
MatrixA(50,45) = -0.0170365;
MatrixA(50,46) = -0.0170365;
MatrixA(50,47) = -9.68326e-06;
MatrixA(50,48) = -9.68326e-06;
MatrixA(50,49) = -0.0170365;
MatrixA(50,50) = -4.12811;
MatrixA(50,51) = -9.68326e-06;
MatrixA(50,52) = 3.74067;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 81.4119;
MatrixA(51,52) = -107.015;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 133.462;
MatrixA(52,52) = -175.434;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = -9.68326e-06;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0430544;
MatrixC(2,2) = 0.123976;
MatrixC(2,3) = -2.95942;
MatrixC(2,6) = 0.00590817;
MatrixC(2,7) = 1.41021e-11;
MatrixC(2,8) = -1.81776;
MatrixC(2,9) = 0.00784719;
MatrixC(2,12) = -1.10343;
MatrixC(2,13) = 0.0350654;
MatrixC(2,16) = -31.2635;
MatrixC(2,20) = -31.182;
MatrixC(2,24) = -10.6362;
MatrixC(2,26) = -10.6267;
MatrixC(2,28) = -10.7148;
MatrixC(2,30) = -10.7244;
MatrixC(2,32) = -6.50521e-16;
MatrixC(2,35) = 1.0842e-15;
MatrixC(2,36) = 1.42891e-05;
MatrixC(2,37) = -0.0301174;
MatrixC(2,38) = 5.55181e-05;
MatrixC(2,39) = 0.00247072;
MatrixC(2,40) = -1.49358e-05;
MatrixC(2,41) = -0.00219311;
MatrixC(2,42) = 0.000253731;
MatrixC(2,43) = 3.73345e-07;
MatrixC(2,44) = -2.8109e-06;
MatrixC(2,45) = -2.80284e-06;
MatrixC(2,46) = -0.000245112;
MatrixC(2,47) = 1.22776e-06;
MatrixC(2,48) = -1.82078e-06;
MatrixC(2,49) = -1.83389e-06;

MatrixD = zeros(2, 1);
