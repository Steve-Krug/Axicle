% MATLAB linearized TruckSim 2023.0 model, calculated at t = 120.007 s.
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

MatrixA(1,2) = -13.8856;
MatrixA(1,3) = -0.000256903;
MatrixA(1,36) = -0.0321896;
MatrixA(1,37) = 0.00213872;
MatrixA(1,38) = 0.999479;
MatrixA(1,39) = 0.00275895;
MatrixA(1,40) = -1.26197;
MatrixA(1,41) = 0.00181791;
MatrixA(2,3) = 1.59923e-05;
MatrixA(2,39) = -0.00213983;
MatrixA(2,40) = 0.999998;
MatrixA(3,2) = -1.60093e-05;
MatrixA(3,3) = -7.35748e-09;
MatrixA(3,39) = 0.0322062;
MatrixA(3,40) = 6.8916e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238046;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 6.49772e-07;
MatrixA(16,2) = -0.00050953;
MatrixA(16,3) = -2.63677e-07;
MatrixA(16,6) = -1.14168;
MatrixA(16,7) = -0.000824692;
MatrixA(16,8) = 0.643122;
MatrixA(16,9) = -3.66023e-08;
MatrixA(16,16) = -19.3475;
MatrixA(16,36) = 3.37597e-06;
MatrixA(16,37) = 1.39087;
MatrixA(16,38) = -0.00297613;
MatrixA(16,39) = 1.81131;
MatrixA(16,40) = 0.00387303;
MatrixA(16,41) = 1.12426;
MatrixA(16,42) = 0.459421;
MatrixA(16,43) = 3.64585e-05;
MatrixA(17,1) = 1.63285e-05;
MatrixA(17,2) = 0.0599566;
MatrixA(17,3) = 1.42461e-05;
MatrixA(17,6) = 0.000191099;
MatrixA(17,7) = -0.00717086;
MatrixA(17,8) = 4.01382e-05;
MatrixA(17,9) = 1.81683e-05;
MatrixA(17,17) = -117.957;
MatrixA(17,36) = -8.61933;
MatrixA(17,37) = -0.00055097;
MatrixA(17,38) = -0.277662;
MatrixA(17,39) = 7.53847;
MatrixA(17,40) = 7.34807;
MatrixA(17,41) = -0.243202;
MatrixA(17,42) = -0.242906;
MatrixA(17,43) = -0.277662;
MatrixA(17,44) = 3.3894;
MatrixA(20,1) = 6.54478e-07;
MatrixA(20,2) = -0.00051041;
MatrixA(20,3) = -1.39274e-06;
MatrixA(20,6) = -1.14362;
MatrixA(20,7) = -0.00082627;
MatrixA(20,8) = 0.603013;
MatrixA(20,9) = -3.31592e-08;
MatrixA(20,20) = -19.3809;
MatrixA(20,36) = 3.38182e-06;
MatrixA(20,37) = 1.39328;
MatrixA(20,38) = -0.00298127;
MatrixA(20,39) = 1.81445;
MatrixA(20,40) = 0.00387974;
MatrixA(20,41) = 1.1262;
MatrixA(20,42) = 0.460215;
MatrixA(20,43) = 3.65215e-05;
MatrixA(21,1) = 1.61098e-05;
MatrixA(21,2) = 0.0597051;
MatrixA(21,3) = -1.37922e-05;
MatrixA(21,6) = 0.000190287;
MatrixA(21,7) = 0.00714411;
MatrixA(21,8) = 1.27846e-05;
MatrixA(21,9) = 1.79412e-05;
MatrixA(21,21) = -117.454;
MatrixA(21,36) = -8.58323;
MatrixA(21,37) = -0.000548662;
MatrixA(21,38) = -0.276499;
MatrixA(21,39) = -7.51739;
MatrixA(21,40) = 7.28513;
MatrixA(21,41) = 0.241695;
MatrixA(21,42) = 0.241989;
MatrixA(21,43) = -0.2765;
MatrixA(21,45) = 3.3752;
MatrixA(24,1) = 3.72707e-06;
MatrixA(24,2) = 0.00185912;
MatrixA(24,3) = 3.49652e-06;
MatrixA(24,12) = 1.59248;
MatrixA(24,13) = -4.37634e-06;
MatrixA(24,24) = -45.2783;
MatrixA(24,36) = -4.81804e-06;
MatrixA(24,37) = 3.25502;
MatrixA(24,38) = -0.00696535;
MatrixA(24,39) = -6.79338;
MatrixA(24,40) = -0.0145326;
MatrixA(24,41) = 2.98638;
MatrixA(24,46) = 1.59294;
MatrixA(24,47) = -8.64295e-05;
MatrixA(26,1) = 3.73251e-06;
MatrixA(26,2) = 0.00186157;
MatrixA(26,3) = 4.72326e-06;
MatrixA(26,12) = 1.65033;
MatrixA(26,13) = -4.37839e-06;
MatrixA(26,26) = -45.3154;
MatrixA(26,36) = -4.82198e-06;
MatrixA(26,37) = 3.25768;
MatrixA(26,38) = -0.00697105;
MatrixA(26,39) = -6.79894;
MatrixA(26,40) = -0.0145445;
MatrixA(26,41) = 2.98882;
MatrixA(26,46) = 1.59425;
MatrixA(26,47) = -8.65003e-05;
MatrixA(28,1) = 3.69709e-06;
MatrixA(28,2) = 0.00184566;
MatrixA(28,3) = -1.96069e-06;
MatrixA(28,12) = 1.33434;
MatrixA(28,13) = -4.36505e-06;
MatrixA(28,28) = -45.0737;
MatrixA(28,36) = -4.79628e-06;
MatrixA(28,37) = 3.24031;
MatrixA(28,38) = -0.00693389;
MatrixA(28,39) = -6.76271;
MatrixA(28,40) = -0.014467;
MatrixA(28,41) = 2.97289;
MatrixA(28,46) = 1.58575;
MatrixA(28,47) = -8.60391e-05;
MatrixA(30,1) = 3.69172e-06;
MatrixA(30,2) = 0.00184326;
MatrixA(30,3) = -2.75287e-06;
MatrixA(30,12) = 1.29673;
MatrixA(30,13) = -4.36303e-06;
MatrixA(30,30) = -45.037;
MatrixA(30,36) = -4.79239e-06;
MatrixA(30,37) = 3.23768;
MatrixA(30,38) = -0.00692825;
MatrixA(30,39) = -6.75721;
MatrixA(30,40) = -0.0144553;
MatrixA(30,41) = 2.97047;
MatrixA(30,46) = 1.58446;
MatrixA(30,47) = -8.59692e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 82.0071;
MatrixA(36,2) = 249.868;
MatrixA(36,3) = 0.262659;
MatrixA(36,6) = -1.0916e-05;
MatrixA(36,7) = 5.43539e-06;
MatrixA(36,8) = 1.62784;
MatrixA(36,9) = -10.7294;
MatrixA(36,12) = 12.7668;
MatrixA(36,13) = 144.789;
MatrixA(36,16) = 2.6058;
MatrixA(36,17) = 23.393;
MatrixA(36,20) = 2.62242;
MatrixA(36,21) = 23.2449;
MatrixA(36,24) = 2.34842;
MatrixA(36,26) = 2.34458;
MatrixA(36,28) = 2.33635;
MatrixA(36,30) = 2.34019;
MatrixA(36,32) = -0.00367794;
MatrixA(36,35) = 0.00367794;
MatrixA(36,36) = -4.53321;
MatrixA(36,37) = -0.000319807;
MatrixA(36,38) = -0.14599;
MatrixA(36,39) = -0.0194775;
MatrixA(36,40) = 3.40324;
MatrixA(36,41) = 0.000381714;
MatrixA(36,42) = 0.000102821;
MatrixA(36,43) = -0.276777;
MatrixA(36,44) = 0.263418;
MatrixA(36,45) = 0.265683;
MatrixA(36,46) = 0.000173926;
MatrixA(36,47) = 0.467465;
MatrixA(36,48) = 0.62335;
MatrixA(36,49) = 0.627914;
MatrixA(36,52) = -0.000117073;
MatrixA(37,1) = -0.00598733;
MatrixA(37,2) = -0.0559254;
MatrixA(37,3) = 98.0022;
MatrixA(37,6) = 0.00943906;
MatrixA(37,7) = 0.00410065;
MatrixA(37,8) = -164.664;
MatrixA(37,9) = 12.9301;
MatrixA(37,12) = 212.64;
MatrixA(37,13) = -1.93936;
MatrixA(37,16) = -38.5002;
MatrixA(37,17) = -0.332344;
MatrixA(37,20) = -38.3484;
MatrixA(37,21) = 0.3299;
MatrixA(37,24) = -8.67014;
MatrixA(37,26) = -8.66158;
MatrixA(37,28) = -8.53762;
MatrixA(37,30) = -8.54588;
MatrixA(37,32) = -0.00479143;
MatrixA(37,35) = 0.00479143;
MatrixA(37,36) = 0.000245626;
MatrixA(37,37) = -0.0161766;
MatrixA(37,38) = 4.23454e-05;
MatrixA(37,39) = -13.9961;
MatrixA(37,40) = -0.000444884;
MatrixA(37,41) = 0.44195;
MatrixA(37,42) = -1.06311;
MatrixA(37,43) = 0.0137612;
MatrixA(37,44) = 0.000303602;
MatrixA(37,45) = 0.00781326;
MatrixA(37,46) = 0.268943;
MatrixA(37,47) = 0.0106955;
MatrixA(37,48) = -0.0297329;
MatrixA(37,49) = 0.0221513;
MatrixA(37,52) = -0.000152516;
MatrixA(38,1) = -8.43709;
MatrixA(38,2) = -28.3547;
MatrixA(38,3) = -0.186127;
MatrixA(38,6) = -2.06847e-05;
MatrixA(38,7) = -8.84906e-06;
MatrixA(38,8) = -37.5009;
MatrixA(38,9) = 566.572;
MatrixA(38,12) = 76.0656;
MatrixA(38,13) = 411.033;
MatrixA(38,16) = 0.114622;
MatrixA(38,17) = 0.278353;
MatrixA(38,20) = 0.114491;
MatrixA(38,21) = 0.275173;
MatrixA(38,24) = -0.254776;
MatrixA(38,26) = -0.254347;
MatrixA(38,28) = -0.253625;
MatrixA(38,30) = -0.254054;
MatrixA(38,32) = 0.000292433;
MatrixA(38,35) = -0.000292433;
MatrixA(38,36) = 0.357462;
MatrixA(38,37) = 1.61423e-05;
MatrixA(38,38) = 0.0115136;
MatrixA(38,39) = 0.00178829;
MatrixA(38,40) = 13.577;
MatrixA(38,41) = -0.000965464;
MatrixA(38,42) = 0.00315949;
MatrixA(38,43) = 6.84092;
MatrixA(38,44) = 0.00311517;
MatrixA(38,45) = 0.00312592;
MatrixA(38,46) = -0.000556518;
MatrixA(38,47) = 5.48996;
MatrixA(38,48) = -0.072437;
MatrixA(38,49) = -0.0730704;
MatrixA(38,52) = 9.30844e-06;
MatrixA(39,1) = 0.0377196;
MatrixA(39,2) = 0.106612;
MatrixA(39,3) = -221.616;
MatrixA(39,6) = 0.00500347;
MatrixA(39,7) = 0.00269156;
MatrixA(39,8) = -77.1822;
MatrixA(39,9) = 4.91447;
MatrixA(39,12) = -201.683;
MatrixA(39,13) = 3.99551;
MatrixA(39,16) = -20.3877;
MatrixA(39,17) = -7.5146;
MatrixA(39,20) = -18.6667;
MatrixA(39,21) = 7.46624;
MatrixA(39,24) = 6.62936;
MatrixA(39,26) = 6.6234;
MatrixA(39,28) = 8.34913;
MatrixA(39,30) = 8.35783;
MatrixA(39,32) = -0.00613691;
MatrixA(39,35) = 0.00613691;
MatrixA(39,36) = -0.00700399;
MatrixA(39,37) = -0.00147805;
MatrixA(39,38) = -0.000222449;
MatrixA(39,39) = -1.37875;
MatrixA(39,40) = 0.00300745;
MatrixA(39,41) = -0.0579834;
MatrixA(39,42) = -0.434418;
MatrixA(39,43) = 0.0071461;
MatrixA(39,44) = -0.0848587;
MatrixA(39,45) = 0.0850201;
MatrixA(39,46) = -0.462233;
MatrixA(39,47) = -0.00979883;
MatrixA(39,48) = -0.220784;
MatrixA(39,49) = 0.224179;
MatrixA(39,52) = -0.000195344;
MatrixA(40,1) = -22.7129;
MatrixA(40,2) = -70.9536;
MatrixA(40,3) = -0.487782;
MatrixA(40,6) = 1.68599e-05;
MatrixA(40,7) = 4.94398e-06;
MatrixA(40,8) = 17.6902;
MatrixA(40,9) = -269.113;
MatrixA(40,12) = 57.1207;
MatrixA(40,13) = 293.566;
MatrixA(40,16) = -0.429896;
MatrixA(40,17) = -3.48153;
MatrixA(40,20) = -0.428721;
MatrixA(40,21) = -3.42794;
MatrixA(40,24) = -0.672285;
MatrixA(40,26) = -0.671175;
MatrixA(40,28) = -0.665198;
MatrixA(40,30) = -0.666301;
MatrixA(40,32) = -0.0403606;
MatrixA(40,35) = 0.0403606;
MatrixA(40,36) = 1.1272;
MatrixA(40,37) = 7.49804e-05;
MatrixA(40,38) = 0.0363028;
MatrixA(40,39) = 0.0021654;
MatrixA(40,40) = -0.959642;
MatrixA(40,41) = -0.000218636;
MatrixA(40,42) = -0.00125844;
MatrixA(40,43) = -3.22751;
MatrixA(40,44) = -0.03787;
MatrixA(40,45) = -0.0378467;
MatrixA(40,46) = -0.000886879;
MatrixA(40,47) = 4.21714;
MatrixA(40,48) = -0.181147;
MatrixA(40,49) = -0.181558;
MatrixA(40,52) = -0.00128472;
MatrixA(41,1) = -0.00311266;
MatrixA(41,2) = -0.0508415;
MatrixA(41,3) = 114.402;
MatrixA(41,6) = 0.0104213;
MatrixA(41,7) = 0.00447653;
MatrixA(41,8) = 142.201;
MatrixA(41,9) = -40.2141;
MatrixA(41,12) = 509.067;
MatrixA(41,13) = -43.6027;
MatrixA(41,16) = -42.5087;
MatrixA(41,17) = 0.353586;
MatrixA(41,20) = -42.5022;
MatrixA(41,21) = -0.351722;
MatrixA(41,24) = -9.2796;
MatrixA(41,26) = -9.27048;
MatrixA(41,28) = -9.29437;
MatrixA(41,30) = -9.30341;
MatrixA(41,32) = 0.059519;
MatrixA(41,35) = -0.059519;
MatrixA(41,36) = 0.000648909;
MatrixA(41,37) = -0.0112456;
MatrixA(41,38) = 4.49807e-05;
MatrixA(41,39) = 0.011981;
MatrixA(41,40) = -0.000526221;
MatrixA(41,41) = 0.000228928;
MatrixA(41,42) = 3.75693;
MatrixA(41,43) = 0.0151953;
MatrixA(41,44) = 0.00628397;
MatrixA(41,45) = -0.00171407;
MatrixA(41,46) = 4.27464;
MatrixA(41,47) = 0.0116068;
MatrixA(41,48) = -0.0132245;
MatrixA(41,49) = 0.000632034;
MatrixA(41,52) = 0.00189455;
MatrixA(42,1) = 0.164408;
MatrixA(42,2) = -0.00498889;
MatrixA(42,3) = -11480.3;
MatrixA(42,6) = 0.695308;
MatrixA(42,7) = 0.492811;
MatrixA(42,8) = -17429.3;
MatrixA(42,9) = 1030.25;
MatrixA(42,12) = -423.283;
MatrixA(42,13) = 35.8492;
MatrixA(42,16) = -585.444;
MatrixA(42,17) = 29.8996;
MatrixA(42,20) = -590.95;
MatrixA(42,21) = -29.7162;
MatrixA(42,24) = 7.28383;
MatrixA(42,26) = 7.27701;
MatrixA(42,28) = 8.32556;
MatrixA(42,30) = 8.33401;
MatrixA(42,32) = -0.643434;
MatrixA(42,35) = 0.643434;
MatrixA(42,36) = 0.00507239;
MatrixA(42,37) = 0.000968413;
MatrixA(42,38) = 0.00016143;
MatrixA(42,39) = 9.28;
MatrixA(42,40) = 0.0157616;
MatrixA(42,41) = -0.0911827;
MatrixA(42,42) = -93.3846;
MatrixA(42,43) = -0.0121198;
MatrixA(42,44) = 0.606235;
MatrixA(42,45) = -0.0697928;
MatrixA(42,46) = -3.52284;
MatrixA(42,47) = -0.0100731;
MatrixA(42,48) = -0.358866;
MatrixA(42,49) = -0.0956039;
MatrixA(42,52) = -0.0204812;
MatrixA(43,1) = -3793.57;
MatrixA(43,2) = -13.0238;
MatrixA(43,3) = 1.78129;
MatrixA(43,6) = 4.56741e-05;
MatrixA(43,7) = 5.29119e-05;
MatrixA(43,8) = 473.74;
MatrixA(43,9) = -10910.2;
MatrixA(43,12) = -2.85263;
MatrixA(43,13) = -32.2897;
MatrixA(43,16) = 0.554268;
MatrixA(43,17) = 5.28081;
MatrixA(43,20) = 0.557169;
MatrixA(43,21) = 5.23924;
MatrixA(43,24) = -0.60177;
MatrixA(43,26) = -0.60078;
MatrixA(43,28) = -0.598736;
MatrixA(43,30) = -0.599727;
MatrixA(43,32) = -0.0524655;
MatrixA(43,35) = 0.0524655;
MatrixA(43,36) = 0.519931;
MatrixA(43,37) = 9.43414e-05;
MatrixA(43,38) = 0.0167503;
MatrixA(43,39) = 0.0034105;
MatrixA(43,40) = -0.446865;
MatrixA(43,41) = -0.00039194;
MatrixA(43,42) = -0.0252174;
MatrixA(43,43) = -86.2106;
MatrixA(43,44) = 0.061174;
MatrixA(43,45) = 0.0615924;
MatrixA(43,46) = -0.00470863;
MatrixA(43,47) = -0.0498567;
MatrixA(43,48) = -0.160588;
MatrixA(43,49) = -0.161825;
MatrixA(43,52) = -0.00167003;
MatrixA(44,1) = 212.501;
MatrixA(44,2) = 67.522;
MatrixA(44,3) = 141.847;
MatrixA(44,6) = -0.010033;
MatrixA(44,7) = 0.0992498;
MatrixA(44,8) = 124.265;
MatrixA(44,9) = 458.807;
MatrixA(44,12) = -57.5578;
MatrixA(44,13) = -293.557;
MatrixA(44,16) = -459.064;
MatrixA(44,17) = -4115.55;
MatrixA(44,20) = 6.04464;
MatrixA(44,21) = 53.481;
MatrixA(44,24) = 0.686651;
MatrixA(44,26) = 0.685529;
MatrixA(44,28) = 0.683283;
MatrixA(44,30) = 0.684405;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 115.337;
MatrixA(44,37) = 0.00736203;
MatrixA(44,38) = 3.71325;
MatrixA(44,39) = -104.292;
MatrixA(44,40) = -98.2209;
MatrixA(44,41) = 3.3662;
MatrixA(44,42) = 3.36298;
MatrixA(44,43) = 6.97708;
MatrixA(44,44) = -51.9997;
MatrixA(44,45) = -2.95325;
MatrixA(44,46) = -0.000118529;
MatrixA(44,47) = -4.21715;
MatrixA(44,48) = 4.14039;
MatrixA(44,49) = 4.14177;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 212.927;
MatrixA(45,2) = 67.5088;
MatrixA(45,3) = -201.987;
MatrixA(45,6) = 0.0129459;
MatrixA(45,7) = -0.100123;
MatrixA(45,8) = -219.569;
MatrixA(45,9) = 459.233;
MatrixA(45,12) = -57.5578;
MatrixA(45,13) = -293.557;
MatrixA(45,16) = 6.00686;
MatrixA(45,17) = 53.8256;
MatrixA(45,20) = -461.94;
MatrixA(45,21) = -4089.08;
MatrixA(45,24) = 0.686651;
MatrixA(45,26) = 0.685529;
MatrixA(45,28) = 0.683283;
MatrixA(45,30) = 0.684405;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 116.351;
MatrixA(45,37) = 0.00742691;
MatrixA(45,38) = 3.74594;
MatrixA(45,39) = 105.4;
MatrixA(45,40) = -98.6358;
MatrixA(45,41) = -3.38717;
MatrixA(45,42) = -3.39043;
MatrixA(45,43) = 7.00977;
MatrixA(45,44) = -2.95842;
MatrixA(45,45) = -52.3935;
MatrixA(45,46) = -0.000118529;
MatrixA(45,47) = -4.21715;
MatrixA(45,48) = 4.14039;
MatrixA(45,49) = 4.14177;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = -0.122464;
MatrixA(46,2) = -0.272579;
MatrixA(46,3) = -27709.9;
MatrixA(46,6) = -0.0118769;
MatrixA(46,7) = -0.0046332;
MatrixA(46,8) = -167.194;
MatrixA(46,9) = 46.4912;
MatrixA(46,12) = -33410.6;
MatrixA(46,13) = 830.263;
MatrixA(46,16) = 48.4642;
MatrixA(46,17) = -7.04659;
MatrixA(46,20) = 49.9411;
MatrixA(46,21) = 6.99427;
MatrixA(46,24) = -296.253;
MatrixA(46,26) = -295.971;
MatrixA(46,28) = -304.961;
MatrixA(46,30) = -305.254;
MatrixA(46,32) = -0.677346;
MatrixA(46,35) = 0.677346;
MatrixA(46,36) = 0.0179272;
MatrixA(46,37) = 0.0189182;
MatrixA(46,38) = 0.000537228;
MatrixA(46,39) = 10.3159;
MatrixA(46,40) = 0.00665568;
MatrixA(46,41) = -0.214556;
MatrixA(46,42) = -4.38192;
MatrixA(46,43) = -0.0172572;
MatrixA(46,44) = -0.320312;
MatrixA(46,45) = -0.161093;
MatrixA(46,46) = -79.919;
MatrixA(46,47) = -0.0115493;
MatrixA(46,48) = 1.15516;
MatrixA(46,49) = -0.592417;
MatrixA(46,52) = -0.0215606;
MatrixA(47,1) = -6552.44;
MatrixA(47,2) = -22140.1;
MatrixA(47,3) = 11.2283;
MatrixA(47,6) = -1.72967e-05;
MatrixA(47,7) = -1.6992e-06;
MatrixA(47,8) = 1.06108;
MatrixA(47,9) = -15.0347;
MatrixA(47,12) = -941.126;
MatrixA(47,13) = -11706.4;
MatrixA(47,16) = 0.503201;
MatrixA(47,17) = 4.2882;
MatrixA(47,20) = 0.506113;
MatrixA(47,21) = 4.26032;
MatrixA(47,24) = 5.37213;
MatrixA(47,26) = 5.36339;
MatrixA(47,28) = 5.3466;
MatrixA(47,30) = 5.35533;
MatrixA(47,32) = 0.0817698;
MatrixA(47,35) = -0.0817698;
MatrixA(47,36) = -7.42778;
MatrixA(47,37) = -0.000461205;
MatrixA(47,38) = -0.239236;
MatrixA(47,39) = -0.034835;
MatrixA(47,40) = 6.31581;
MatrixA(47,41) = 0.000113239;
MatrixA(47,42) = -0.00274441;
MatrixA(47,43) = -0.210519;
MatrixA(47,44) = 0.0456465;
MatrixA(47,45) = 0.0460534;
MatrixA(47,46) = 0.0123868;
MatrixA(47,47) = -68.135;
MatrixA(47,48) = 1.4034;
MatrixA(47,49) = 1.41401;
MatrixA(47,52) = 0.00260281;
MatrixA(48,1) = 744.544;
MatrixA(48,2) = 2518.08;
MatrixA(48,3) = 698.844;
MatrixA(48,6) = -6.28516e-06;
MatrixA(48,7) = 7.44584e-07;
MatrixA(48,8) = -17.8533;
MatrixA(48,9) = 269.123;
MatrixA(48,12) = 642.397;
MatrixA(48,13) = 425.423;
MatrixA(48,16) = 0.386806;
MatrixA(48,17) = 3.46564;
MatrixA(48,20) = 0.389268;
MatrixA(48,21) = 3.44371;
MatrixA(48,24) = -568.816;
MatrixA(48,26) = -567.885;
MatrixA(48,28) = 9.955;
MatrixA(48,30) = 9.97137;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 377.076;
MatrixA(48,37) = 0.0256672;
MatrixA(48,38) = 12.1451;
MatrixA(48,39) = -371.03;
MatrixA(48,40) = -321.449;
MatrixA(48,41) = 11.9705;
MatrixA(48,42) = 0.000340306;
MatrixA(48,43) = 3.22752;
MatrixA(48,44) = 5.31682;
MatrixA(48,45) = 5.31716;
MatrixA(48,46) = 11.9618;
MatrixA(48,47) = 47.9377;
MatrixA(48,48) = -158.564;
MatrixA(48,49) = -2.06436;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 739.324;
MatrixA(49,2) = 2500.01;
MatrixA(49,3) = -716.354;
MatrixA(49,6) = -6.28516e-06;
MatrixA(49,7) = 7.44584e-07;
MatrixA(49,8) = -17.8533;
MatrixA(49,9) = 269.123;
MatrixA(49,12) = -772.808;
MatrixA(49,13) = 420.223;
MatrixA(49,16) = 0.386806;
MatrixA(49,17) = 3.46564;
MatrixA(49,20) = 0.389268;
MatrixA(49,21) = 3.44371;
MatrixA(49,24) = 10.0073;
MatrixA(49,26) = 9.99093;
MatrixA(49,28) = -565.835;
MatrixA(49,30) = -566.765;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 379.896;
MatrixA(49,37) = 0.0258592;
MatrixA(49,38) = 12.236;
MatrixA(49,39) = 374.296;
MatrixA(49,40) = -322.253;
MatrixA(49,41) = -12.0337;
MatrixA(49,42) = 0.000340306;
MatrixA(49,43) = 3.22752;
MatrixA(49,44) = 5.31682;
MatrixA(49,45) = 5.31716;
MatrixA(49,46) = -12.0424;
MatrixA(49,47) = 48.3267;
MatrixA(49,48) = -2.08359;
MatrixA(49,49) = -159.655;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 0.000771875;
MatrixA(50,2) = 0.000771875;
MatrixA(50,3) = 0.000771875;
MatrixA(50,4) = 0.000771875;
MatrixA(50,5) = 0.000771875;
MatrixA(50,6) = 0.000771875;
MatrixA(50,7) = 0.000771875;
MatrixA(50,8) = 0.000771875;
MatrixA(50,9) = 0.000771875;
MatrixA(50,10) = 0.000771875;
MatrixA(50,11) = 0.000771875;
MatrixA(50,12) = 0.000771875;
MatrixA(50,13) = 0.000771875;
MatrixA(50,14) = 0.000771875;
MatrixA(50,15) = 0.000771875;
MatrixA(50,16) = 0.000771875;
MatrixA(50,17) = 0.000771875;
MatrixA(50,18) = 0.000771875;
MatrixA(50,19) = 0.000771875;
MatrixA(50,20) = 0.000771875;
MatrixA(50,21) = 0.000771875;
MatrixA(50,22) = 0.000771875;
MatrixA(50,23) = 0.000771875;
MatrixA(50,24) = 0.000771875;
MatrixA(50,25) = 0.000771875;
MatrixA(50,26) = 0.000771875;
MatrixA(50,27) = 0.000771875;
MatrixA(50,28) = 0.000771875;
MatrixA(50,29) = 0.000771875;
MatrixA(50,30) = 0.000771875;
MatrixA(50,31) = 0.000771875;
MatrixA(50,32) = 0.000771875;
MatrixA(50,33) = 0.000771875;
MatrixA(50,34) = 0.000771875;
MatrixA(50,35) = 0.000771875;
MatrixA(50,36) = -1096.22;
MatrixA(50,37) = 0.000771875;
MatrixA(50,38) = -35.3438;
MatrixA(50,39) = 0.000771875;
MatrixA(50,40) = 0.000771875;
MatrixA(50,41) = 0.000771875;
MatrixA(50,42) = 0.000771875;
MatrixA(50,43) = 0.000771875;
MatrixA(50,44) = 0.000771875;
MatrixA(50,45) = 0.215975;
MatrixA(50,46) = 0.215975;
MatrixA(50,47) = 0.000771875;
MatrixA(50,48) = 0.000771875;
MatrixA(50,49) = 0.215975;
MatrixA(50,50) = -2.06722;
MatrixA(50,51) = 0.000771875;
MatrixA(50,52) = 1.45015;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 41.6159;
MatrixA(51,52) = -81.9008;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 68.2229;
MatrixA(52,52) = -134.264;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 0.000771875;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0176216;
MatrixC(2,2) = 0.0526259;
MatrixC(2,3) = -3.00298;
MatrixC(2,6) = 0.00380993;
MatrixC(2,7) = -3.61676e-11;
MatrixC(2,8) = -1.88998;
MatrixC(2,9) = 0.0025197;
MatrixC(2,12) = -1.101;
MatrixC(2,13) = 0.015041;
MatrixC(2,16) = -34.5761;
MatrixC(2,17) = -0.000143838;
MatrixC(2,20) = -34.5065;
MatrixC(2,21) = -0.000142899;
MatrixC(2,24) = -12.3513;
MatrixC(2,26) = -12.3392;
MatrixC(2,28) = -12.4403;
MatrixC(2,30) = -12.4524;
MatrixC(2,32) = -9.21572e-16;
MatrixC(2,35) = 8.40257e-16;
MatrixC(2,36) = 8.86933e-06;
MatrixC(2,37) = -0.0167283;
MatrixC(2,38) = 3.60994e-05;
MatrixC(2,39) = 0.00137194;
MatrixC(2,40) = -9.9629e-06;
MatrixC(2,41) = -0.00121703;
MatrixC(2,42) = 0.00014148;
MatrixC(2,43) = 1.93795e-07;
MatrixC(2,44) = -1.47795e-06;
MatrixC(2,45) = -1.49415e-06;
MatrixC(2,46) = -0.000135592;
MatrixC(2,47) = 1.04062e-06;
MatrixC(2,48) = -1.55619e-06;
MatrixC(2,49) = -1.56115e-06;
MatrixC(2,52) = -5.42101e-17;

MatrixD = zeros(2, 1);
