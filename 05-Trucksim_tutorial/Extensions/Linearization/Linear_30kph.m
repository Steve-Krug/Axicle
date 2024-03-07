% MATLAB linearized TruckSim 2023.0 model, calculated at t = 80.0045 s.
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

MatrixA(1,2) = -8.31537;
MatrixA(1,3) = -0.000169565;
MatrixA(1,36) = -0.0326004;
MatrixA(1,37) = 0.00170171;
MatrixA(1,38) = 0.999467;
MatrixA(1,39) = 0.00219521;
MatrixA(1,40) = -1.2616;
MatrixA(1,41) = 0.00144645;
MatrixA(2,3) = 1.10466e-05;
MatrixA(2,39) = -0.00170262;
MatrixA(2,40) = 0.999999;
MatrixA(3,2) = -1.10621e-05;
MatrixA(3,3) = 2.17063e-07;
MatrixA(3,39) = 0.0326177;
MatrixA(3,40) = 5.55355e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238039;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = -1.68065e-05;
MatrixA(16,2) = 1.63104e-05;
MatrixA(16,3) = -4.11865e-06;
MatrixA(16,6) = -0.682914;
MatrixA(16,7) = -0.000810793;
MatrixA(16,8) = 0.389555;
MatrixA(16,9) = -1.64218e-05;
MatrixA(16,16) = -11.5728;
MatrixA(16,36) = 5.41397e-06;
MatrixA(16,37) = 1.38927;
MatrixA(16,38) = -0.00236522;
MatrixA(16,39) = 1.80944;
MatrixA(16,40) = 0.00307619;
MatrixA(16,41) = 1.12177;
MatrixA(16,42) = 0.457695;
MatrixA(16,43) = -2.30379e-06;
MatrixA(17,1) = 0.000133499;
MatrixA(17,2) = 0.0735528;
MatrixA(17,3) = 0.000116665;
MatrixA(17,6) = 0.000287093;
MatrixA(17,7) = -0.0166585;
MatrixA(17,8) = 1.80044e-05;
MatrixA(17,9) = 2.12935e-07;
MatrixA(17,17) = -166.667;
MatrixA(17,36) = -13.9298;
MatrixA(17,37) = -0.00102507;
MatrixA(17,38) = -0.653484;
MatrixA(17,39) = 12.2088;
MatrixA(17,40) = 11.8888;
MatrixA(17,41) = -0.572261;
MatrixA(17,42) = -0.571713;
MatrixA(17,43) = -0.653485;
MatrixA(17,44) = 5.49827;
MatrixA(20,1) = -1.6803e-05;
MatrixA(20,2) = 1.63085e-05;
MatrixA(20,3) = 2.17634e-05;
MatrixA(20,6) = -0.682815;
MatrixA(20,7) = -0.000810729;
MatrixA(20,8) = 0.364693;
MatrixA(20,9) = -1.64184e-05;
MatrixA(20,20) = -11.5714;
MatrixA(20,36) = 5.41334e-06;
MatrixA(20,37) = 1.38911;
MatrixA(20,38) = -0.00236495;
MatrixA(20,39) = 1.80924;
MatrixA(20,40) = 0.00307584;
MatrixA(20,41) = 1.12164;
MatrixA(20,42) = 0.45764;
MatrixA(20,43) = -2.30352e-06;
MatrixA(21,1) = 0.000133073;
MatrixA(21,2) = 0.073525;
MatrixA(21,3) = -0.000116462;
MatrixA(21,6) = 0.000287076;
MatrixA(21,7) = 0.0166581;
MatrixA(21,8) = 1.81984e-05;
MatrixA(21,9) = -2.13006e-07;
MatrixA(21,21) = -166.667;
MatrixA(21,36) = -13.9282;
MatrixA(21,37) = -0.00102507;
MatrixA(21,38) = -0.653486;
MatrixA(21,39) = -17.5411;
MatrixA(21,40) = 11.8458;
MatrixA(21,41) = 0.413087;
MatrixA(21,42) = 0.413469;
MatrixA(21,43) = -0.653487;
MatrixA(21,45) = 5.4976;
MatrixA(24,1) = -2.99188e-05;
MatrixA(24,2) = 0.000327611;
MatrixA(24,3) = -3.39373e-05;
MatrixA(24,12) = 0.965034;
MatrixA(24,13) = -3.60358e-05;
MatrixA(24,24) = -27.0945;
MatrixA(24,36) = -2.10803e-06;
MatrixA(24,37) = 3.2526;
MatrixA(24,38) = -0.005538;
MatrixA(24,39) = -6.788;
MatrixA(24,40) = -0.0115556;
MatrixA(24,41) = 2.9859;
MatrixA(24,46) = 1.5935;
MatrixA(24,47) = -3.79845e-05;
MatrixA(25,1) = 0.00106164;
MatrixA(25,2) = 0.00450027;
MatrixA(25,3) = 0.000855758;
MatrixA(25,12) = 0.000820948;
MatrixA(25,13) = 0.0011202;
MatrixA(25,25) = -62.1254;
MatrixA(25,36) = -7.68603;
MatrixA(25,37) = -0.000424177;
MatrixA(25,38) = -0.250835;
MatrixA(25,39) = 6.18795;
MatrixA(25,40) = 6.54984;
MatrixA(25,41) = -0.202105;
MatrixA(25,46) = -0.201964;
MatrixA(25,47) = -1.0561;
MatrixA(25,48) = 3.0228;
MatrixA(26,1) = -2.99284e-05;
MatrixA(26,2) = 0.000327812;
MatrixA(26,3) = -4.41477e-05;
MatrixA(26,12) = 0.99953;
MatrixA(26,13) = -3.60478e-05;
MatrixA(26,26) = -27.1043;
MatrixA(26,36) = -2.10877e-06;
MatrixA(26,37) = 3.25377;
MatrixA(26,38) = -0.00554;
MatrixA(26,39) = -6.79044;
MatrixA(26,40) = -0.0115597;
MatrixA(26,41) = 2.98697;
MatrixA(26,46) = 1.59407;
MatrixA(26,47) = -3.79981e-05;
MatrixA(27,1) = 0.00106094;
MatrixA(27,2) = 0.0044672;
MatrixA(27,3) = 0.00115889;
MatrixA(27,12) = 0.00111782;
MatrixA(27,13) = 0.00111942;
MatrixA(27,27) = -62.0653;
MatrixA(27,36) = -7.67865;
MatrixA(27,37) = -0.000423769;
MatrixA(27,38) = -0.250594;
MatrixA(27,39) = 8.41239;
MatrixA(27,40) = 6.54735;
MatrixA(27,41) = -0.274582;
MatrixA(27,46) = -0.274441;
MatrixA(27,47) = -1.05509;
MatrixA(27,48) = 3.0199;
MatrixA(28,1) = -2.98655e-05;
MatrixA(28,2) = 0.0003265;
MatrixA(28,3) = 1.17869e-05;
MatrixA(28,12) = 0.810639;
MatrixA(28,13) = -3.59688e-05;
MatrixA(28,28) = -27.0405;
MatrixA(28,36) = -2.10392e-06;
MatrixA(28,37) = 3.24612;
MatrixA(28,38) = -0.00552698;
MatrixA(28,39) = -6.7745;
MatrixA(28,40) = -0.0115326;
MatrixA(28,41) = 2.97996;
MatrixA(28,46) = 1.59033;
MatrixA(28,47) = -3.79089e-05;
MatrixA(29,1) = 0.00106232;
MatrixA(29,2) = 0.00467449;
MatrixA(29,3) = -0.000876742;
MatrixA(29,12) = -0.000831448;
MatrixA(29,13) = 0.00112135;
MatrixA(29,29) = -62.4731;
MatrixA(29,36) = -7.72745;
MatrixA(29,37) = -0.000426462;
MatrixA(29,38) = -0.252186;
MatrixA(29,39) = -6.22676;
MatrixA(29,40) = 6.5639;
MatrixA(29,41) = 0.202834;
MatrixA(29,46) = 0.202975;
MatrixA(29,47) = -1.06179;
MatrixA(29,49) = 3.0391;
MatrixA(30,1) = -2.9856e-05;
MatrixA(30,2) = 0.000326301;
MatrixA(30,3) = 1.84721e-05;
MatrixA(30,12) = 0.78808;
MatrixA(30,13) = -3.59568e-05;
MatrixA(30,30) = -27.0308;
MatrixA(30,36) = -2.10318e-06;
MatrixA(30,37) = 3.24496;
MatrixA(30,38) = -0.005525;
MatrixA(30,39) = -6.77207;
MatrixA(30,40) = -0.0115285;
MatrixA(30,41) = 2.97889;
MatrixA(30,46) = 1.58976;
MatrixA(30,47) = -3.78953e-05;
MatrixA(31,1) = 0.00106302;
MatrixA(31,2) = 0.00470757;
MatrixA(31,3) = -0.00119774;
MatrixA(31,12) = -0.00112985;
MatrixA(31,13) = 0.00112213;
MatrixA(31,31) = -62.5331;
MatrixA(31,36) = -7.73483;
MatrixA(31,37) = -0.000426869;
MatrixA(31,38) = -0.252427;
MatrixA(31,39) = -8.47469;
MatrixA(31,40) = 6.56634;
MatrixA(31,41) = 0.276235;
MatrixA(31,46) = 0.276377;
MatrixA(31,47) = -1.0628;
MatrixA(31,49) = 3.042;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 82.5856;
MatrixA(36,2) = 250.761;
MatrixA(36,3) = 0.439255;
MatrixA(36,6) = -2.16092e-05;
MatrixA(36,7) = 1.82272e-07;
MatrixA(36,8) = 1.31941;
MatrixA(36,9) = -11.276;
MatrixA(36,12) = 11.5344;
MatrixA(36,13) = 142.875;
MatrixA(36,16) = 1.71771;
MatrixA(36,17) = 33.1024;
MatrixA(36,20) = 1.71705;
MatrixA(36,21) = 33.1099;
MatrixA(36,24) = 1.98342;
MatrixA(36,25) = 4.11171;
MatrixA(36,26) = 1.98074;
MatrixA(36,27) = 4.10575;
MatrixA(36,28) = 1.97589;
MatrixA(36,29) = 4.14617;
MatrixA(36,30) = 1.97858;
MatrixA(36,31) = 4.15216;
MatrixA(36,32) = -0.00395028;
MatrixA(36,35) = 0.00395028;
MatrixA(36,36) = -3.27166;
MatrixA(36,37) = -0.000192121;
MatrixA(36,38) = -0.106705;
MatrixA(36,39) = -0.00126267;
MatrixA(36,40) = 2.50657;
MatrixA(36,41) = -0.000118055;
MatrixA(36,42) = -4.96232e-05;
MatrixA(36,43) = -0.233437;
MatrixA(36,44) = 0.00012849;
MatrixA(36,45) = 0.00012849;
MatrixA(36,46) = -0.000187582;
MatrixA(36,47) = 0.452228;
MatrixA(36,48) = 0.6427;
MatrixA(36,49) = 0.642245;
MatrixA(36,52) = -0.000125741;
MatrixA(37,1) = -0.0132934;
MatrixA(37,2) = -0.045887;
MatrixA(37,3) = 98.3241;
MatrixA(37,6) = 0.00905622;
MatrixA(37,7) = 0.00246215;
MatrixA(37,8) = -167.554;
MatrixA(37,9) = 8.97623;
MatrixA(37,12) = 214.002;
MatrixA(37,13) = -1.91218;
MatrixA(37,16) = -38.7189;
MatrixA(37,17) = -0.46242;
MatrixA(37,20) = -38.676;
MatrixA(37,21) = 0.462158;
MatrixA(37,24) = -8.79031;
MatrixA(37,25) = -0.172191;
MatrixA(37,26) = -8.78678;
MatrixA(37,27) = -0.171941;
MatrixA(37,28) = -8.65193;
MatrixA(37,29) = 0.172012;
MatrixA(37,30) = -8.65523;
MatrixA(37,31) = 0.17226;
MatrixA(37,32) = -0.00516449;
MatrixA(37,35) = 0.00516449;
MatrixA(37,36) = 0.000698952;
MatrixA(37,37) = -0.00968834;
MatrixA(37,38) = 3.45568e-05;
MatrixA(37,39) = -8.42564;
MatrixA(37,40) = -0.000779917;
MatrixA(37,41) = 0.269555;
MatrixA(37,42) = -1.06651;
MatrixA(37,43) = 0.0108085;
MatrixA(37,44) = 0.00407975;
MatrixA(37,45) = 0.00407975;
MatrixA(37,46) = 0.273562;
MatrixA(37,47) = 0.00862096;
MatrixA(37,48) = -0.0306524;
MatrixA(37,49) = 0.0228967;
MatrixA(37,52) = -0.000164391;
MatrixA(38,1) = -8.38733;
MatrixA(38,2) = -28.1949;
MatrixA(38,3) = -0.153965;
MatrixA(38,6) = -1.56983e-05;
MatrixA(38,7) = -4.19851e-06;
MatrixA(38,8) = -24.8733;
MatrixA(38,9) = 591.66;
MatrixA(38,12) = 68.9527;
MatrixA(38,13) = 400.6;
MatrixA(38,16) = 0.0862461;
MatrixA(38,17) = 0.390074;
MatrixA(38,20) = 0.0861593;
MatrixA(38,21) = 0.388472;
MatrixA(38,24) = -0.213663;
MatrixA(38,25) = -0.47357;
MatrixA(38,26) = -0.21336;
MatrixA(38,27) = -0.472883;
MatrixA(38,28) = -0.213017;
MatrixA(38,29) = -0.478097;
MatrixA(38,30) = -0.213321;
MatrixA(38,31) = -0.478788;
MatrixA(38,32) = 0.000308886;
MatrixA(38,35) = -0.000308886;
MatrixA(38,36) = 0.378664;
MatrixA(38,37) = 2.15578e-05;
MatrixA(38,38) = 0.0123492;
MatrixA(38,39) = 0.000394613;
MatrixA(38,40) = 7.99075;
MatrixA(38,41) = -0.000430948;
MatrixA(38,42) = 0.00249884;
MatrixA(38,43) = 6.84133;
MatrixA(38,44) = -1.66703e-05;
MatrixA(38,45) = -1.66703e-05;
MatrixA(38,46) = -0.000424756;
MatrixA(38,47) = 5.49204;
MatrixA(38,48) = -0.0740121;
MatrixA(38,49) = -0.0740461;
MatrixA(38,52) = 9.83213e-06;
MatrixA(39,1) = 0.0234189;
MatrixA(39,2) = 0.0748606;
MatrixA(39,3) = -223.187;
MatrixA(39,6) = 0.00480523;
MatrixA(39,7) = 0.00140484;
MatrixA(39,8) = -78.4734;
MatrixA(39,9) = 3.43964;
MatrixA(39,12) = -203.271;
MatrixA(39,13) = 3.76697;
MatrixA(39,16) = -20.2212;
MatrixA(39,17) = -10.63;
MatrixA(39,20) = -19.1192;
MatrixA(39,21) = 10.6315;
MatrixA(39,24) = 6.87648;
MatrixA(39,25) = -1.46031;
MatrixA(39,26) = 6.87446;
MatrixA(39,27) = -1.45819;
MatrixA(39,28) = 8.30664;
MatrixA(39,29) = 1.47472;
MatrixA(39,30) = 8.31058;
MatrixA(39,31) = 1.47685;
MatrixA(39,32) = -0.0066626;
MatrixA(39,35) = 0.0066626;
MatrixA(39,36) = -0.000444036;
MatrixA(39,37) = -0.000884949;
MatrixA(39,38) = -1.2949e-05;
MatrixA(39,39) = -1.05845;
MatrixA(39,40) = -0.00142164;
MatrixA(39,41) = -0.0267685;
MatrixA(39,42) = -0.425131;
MatrixA(39,43) = 0.00565802;
MatrixA(39,44) = -0.000262504;
MatrixA(39,45) = -0.000262504;
MatrixA(39,46) = -0.445252;
MatrixA(39,47) = -0.00733163;
MatrixA(39,48) = -0.227517;
MatrixA(39,49) = 0.229087;
MatrixA(39,52) = -0.000212077;
MatrixA(40,1) = -22.792;
MatrixA(40,2) = -71.0762;
MatrixA(40,3) = -0.430585;
MatrixA(40,6) = 1.07083e-05;
MatrixA(40,7) = 2.33552e-06;
MatrixA(40,8) = 11.7027;
MatrixA(40,9) = -281.028;
MatrixA(40,12) = 51.7925;
MatrixA(40,13) = 285.733;
MatrixA(40,16) = -0.288207;
MatrixA(40,17) = -4.91277;
MatrixA(40,20) = -0.286288;
MatrixA(40,21) = -4.87872;
MatrixA(40,24) = -0.566833;
MatrixA(40,25) = -1.20079;
MatrixA(40,26) = -0.566055;
MatrixA(40,27) = -1.19904;
MatrixA(40,28) = -0.562265;
MatrixA(40,29) = -1.20595;
MatrixA(40,30) = -0.563042;
MatrixA(40,31) = -1.2077;
MatrixA(40,32) = -0.0434338;
MatrixA(40,35) = 0.0434338;
MatrixA(40,36) = 0.951721;
MatrixA(40,37) = 5.18813e-05;
MatrixA(40,38) = 0.0310385;
MatrixA(40,39) = -0.00125793;
MatrixA(40,40) = -0.809408;
MatrixA(40,41) = -8.06193e-06;
MatrixA(40,42) = -0.000954491;
MatrixA(40,43) = -3.23402;
MatrixA(40,44) = 0.00141652;
MatrixA(40,45) = 0.00141652;
MatrixA(40,46) = -0.000587778;
MatrixA(40,47) = 4.22192;
MatrixA(40,48) = -0.186239;
MatrixA(40,49) = -0.185348;
MatrixA(40,52) = -0.00138254;
MatrixA(41,1) = -0.0116695;
MatrixA(41,2) = -0.0409687;
MatrixA(41,3) = 114.765;
MatrixA(41,6) = 0.00999818;
MatrixA(41,7) = 0.00270859;
MatrixA(41,8) = 147.871;
MatrixA(41,9) = -27.1219;
MatrixA(41,12) = 513.281;
MatrixA(41,13) = -40.0516;
MatrixA(41,16) = -42.7778;
MatrixA(41,17) = 0.508985;
MatrixA(41,20) = -42.8364;
MatrixA(41,21) = -0.509505;
MatrixA(41,24) = -9.42163;
MatrixA(41,25) = -0.0472095;
MatrixA(41,26) = -9.41792;
MatrixA(41,27) = -0.047141;
MatrixA(41,28) = -9.4056;
MatrixA(41,29) = 0.0461958;
MatrixA(41,30) = -9.40926;
MatrixA(41,31) = 0.0462625;
MatrixA(41,32) = 0.0640408;
MatrixA(41,35) = -0.0640408;
MatrixA(41,36) = 0.000568918;
MatrixA(41,37) = -0.00673557;
MatrixA(41,38) = 3.00254e-05;
MatrixA(41,39) = -0.0184039;
MatrixA(41,40) = -0.0005165;
MatrixA(41,41) = 0.000978636;
MatrixA(41,42) = 3.7521;
MatrixA(41,43) = 0.0119303;
MatrixA(41,44) = 0.00218213;
MatrixA(41,45) = 0.00218213;
MatrixA(41,46) = 4.27782;
MatrixA(41,47) = 0.00930583;
MatrixA(41,48) = -0.0137388;
MatrixA(41,49) = 0.000793321;
MatrixA(41,52) = 0.00203848;
MatrixA(42,1) = 0.00937856;
MatrixA(42,2) = 0.010127;
MatrixA(42,3) = -11474.2;
MatrixA(42,6) = 0.676356;
MatrixA(42,7) = 0.295763;
MatrixA(42,8) = -17585.7;
MatrixA(42,9) = 699.439;
MatrixA(42,12) = -426.352;
MatrixA(42,13) = 32.885;
MatrixA(42,16) = -588.027;
MatrixA(42,17) = 42.8581;
MatrixA(42,20) = -592.559;
MatrixA(42,21) = -42.874;
MatrixA(42,24) = 7.47072;
MatrixA(42,25) = -0.87019;
MatrixA(42,26) = 7.4682;
MatrixA(42,27) = -0.868928;
MatrixA(42,28) = 8.33265;
MatrixA(42,29) = 0.877493;
MatrixA(42,30) = 8.33632;
MatrixA(42,31) = 0.878761;
MatrixA(42,32) = -0.691928;
MatrixA(42,35) = 0.691928;
MatrixA(42,36) = 0.00023897;
MatrixA(42,37) = 0.000540106;
MatrixA(42,38) = 6.88845e-06;
MatrixA(42,39) = 4.37669;
MatrixA(42,40) = 0.00724547;
MatrixA(42,41) = -0.016673;
MatrixA(42,42) = -93.2574;
MatrixA(42,43) = -0.00969235;
MatrixA(42,44) = 0.271112;
MatrixA(42,45) = 0.271112;
MatrixA(42,46) = -3.50876;
MatrixA(42,47) = -0.00774586;
MatrixA(42,48) = -0.361954;
MatrixA(42,49) = -0.0900653;
MatrixA(42,52) = -0.0220247;
MatrixA(43,1) = -3793.6;
MatrixA(43,2) = -12.6793;
MatrixA(43,3) = 1.45458;
MatrixA(43,6) = 8.35392e-05;
MatrixA(43,7) = 2.44084e-05;
MatrixA(43,8) = 314.08;
MatrixA(43,9) = -11226.2;
MatrixA(43,12) = -2.51407;
MatrixA(43,13) = -31.9743;
MatrixA(43,16) = 0.38143;
MatrixA(43,17) = 7.66735;
MatrixA(43,20) = 0.380798;
MatrixA(43,21) = 7.6599;
MatrixA(43,24) = -0.509354;
MatrixA(43,25) = -1.07199;
MatrixA(43,26) = -0.508658;
MatrixA(43,27) = -1.07043;
MatrixA(43,28) = -0.507416;
MatrixA(43,29) = -1.08107;
MatrixA(43,30) = -0.508114;
MatrixA(43,31) = -1.08263;
MatrixA(43,32) = -0.0564295;
MatrixA(43,35) = 0.0564295;
MatrixA(43,36) = 0.849061;
MatrixA(43,37) = 7.36919e-05;
MatrixA(43,38) = 0.0276904;
MatrixA(43,39) = 0.000915208;
MatrixA(43,40) = -0.724294;
MatrixA(43,41) = -0.000313487;
MatrixA(43,42) = -0.0199219;
MatrixA(43,43) = -86.201;
MatrixA(43,44) = 0.00186028;
MatrixA(43,45) = 0.00186028;
MatrixA(43,46) = -0.003616;
MatrixA(43,47) = -0.0457719;
MatrixA(43,48) = -0.165706;
MatrixA(43,49) = -0.165603;
MatrixA(43,52) = -0.00179621;
MatrixA(44,1) = 182.32;
MatrixA(44,2) = 68.8378;
MatrixA(44,3) = 104.772;
MatrixA(44,6) = -0.00744891;
MatrixA(44,7) = -4.44349e-05;
MatrixA(44,8) = 93.1121;
MatrixA(44,9) = 440.473;
MatrixA(44,12) = -52.1385;
MatrixA(44,13) = -285.726;
MatrixA(44,16) = -302.668;
MatrixA(44,17) = -5823.57;
MatrixA(44,20) = 3.95848;
MatrixA(44,21) = 76.1686;
MatrixA(44,24) = 0.578534;
MatrixA(44,25) = 1.1983;
MatrixA(44,26) = 0.577753;
MatrixA(44,27) = 1.19657;
MatrixA(44,28) = 0.576395;
MatrixA(44,29) = 1.20846;
MatrixA(44,30) = 0.577178;
MatrixA(44,31) = 1.2102;
MatrixA(44,32) = 10.924;
MatrixA(44,35) = -10.924;
MatrixA(44,36) = -1.00236;
MatrixA(44,37) = -5.59505e-05;
MatrixA(44,38) = -0.0326902;
MatrixA(44,39) = 0.0448101;
MatrixA(44,40) = 0.852522;
MatrixA(44,41) = -0.0015197;
MatrixA(44,42) = -0.000853108;
MatrixA(44,43) = 3.23237;
MatrixA(44,44) = -5.70266;
MatrixA(44,45) = -3.5895;
MatrixA(44,46) = -0.000172715;
MatrixA(44,47) = -4.22193;
MatrixA(44,48) = 4.12052;
MatrixA(44,49) = 4.1204;
MatrixA(44,52) = 0.347722;
MatrixA(45,1) = 182.3;
MatrixA(45,2) = 68.8381;
MatrixA(45,3) = -186.029;
MatrixA(45,6) = 0.011589;
MatrixA(45,7) = 4.18674e-05;
MatrixA(45,8) = -197.689;
MatrixA(45,9) = 440.453;
MatrixA(45,12) = -52.1385;
MatrixA(45,13) = -285.726;
MatrixA(45,16) = 3.96021;
MatrixA(45,17) = 76.1555;
MatrixA(45,20) = -302.529;
MatrixA(45,21) = -5824.44;
MatrixA(45,24) = 0.578534;
MatrixA(45,25) = 1.1983;
MatrixA(45,26) = 0.577753;
MatrixA(45,27) = 1.19657;
MatrixA(45,28) = 0.576395;
MatrixA(45,29) = 1.20846;
MatrixA(45,30) = 0.577178;
MatrixA(45,31) = 1.2102;
MatrixA(45,32) = 10.924;
MatrixA(45,35) = -10.924;
MatrixA(45,36) = -1.00237;
MatrixA(45,37) = -5.59509e-05;
MatrixA(45,38) = -0.0326905;
MatrixA(45,39) = -0.0460103;
MatrixA(45,40) = 0.852374;
MatrixA(45,41) = 0.00144266;
MatrixA(45,42) = 0.00210925;
MatrixA(45,43) = 3.23237;
MatrixA(45,44) = -3.5895;
MatrixA(45,45) = -5.70266;
MatrixA(45,46) = -0.000172715;
MatrixA(45,47) = -4.22193;
MatrixA(45,48) = 4.12052;
MatrixA(45,49) = 4.1204;
MatrixA(45,52) = 0.347722;
MatrixA(46,1) = -0.0744054;
MatrixA(46,2) = -0.206077;
MatrixA(46,3) = -27699.1;
MatrixA(46,6) = -0.0113975;
MatrixA(46,7) = -0.00299816;
MatrixA(46,8) = -173.965;
MatrixA(46,9) = 31.3826;
MatrixA(46,12) = -33453.7;
MatrixA(46,13) = 759.797;
MatrixA(46,16) = 49.0586;
MatrixA(46,17) = -10.0301;
MatrixA(46,20) = 50.107;
MatrixA(46,21) = 10.0235;
MatrixA(46,24) = -302.111;
MatrixA(46,25) = 5.81975;
MatrixA(46,26) = -301.998;
MatrixA(46,27) = 5.8113;
MatrixA(46,28) = -308.653;
MatrixA(46,29) = -5.87513;
MatrixA(46,30) = -308.774;
MatrixA(46,31) = -5.88362;
MatrixA(46,32) = -0.728708;
MatrixA(46,35) = 0.728708;
MatrixA(46,36) = 0.000957535;
MatrixA(46,37) = 0.0113541;
MatrixA(46,38) = 1.18571e-05;
MatrixA(46,39) = 8.25555;
MatrixA(46,40) = 0.0132055;
MatrixA(46,41) = -0.197567;
MatrixA(46,42) = -4.36959;
MatrixA(46,43) = -0.0135209;
MatrixA(46,44) = -0.239265;
MatrixA(46,45) = -0.239265;
MatrixA(46,46) = -79.8908;
MatrixA(46,47) = -0.0112541;
MatrixA(46,48) = 1.19631;
MatrixA(46,49) = -0.623064;
MatrixA(46,52) = -0.0231955;
MatrixA(47,1) = -6552.51;
MatrixA(47,2) = -22139.8;
MatrixA(47,3) = 9.05788;
MatrixA(47,6) = -7.56553e-06;
MatrixA(47,7) = -1.25361e-06;
MatrixA(47,8) = 0.721943;
MatrixA(47,9) = -15.5814;
MatrixA(47,12) = -853.176;
MatrixA(47,13) = -11577.2;
MatrixA(47,16) = 0.336555;
MatrixA(47,17) = 6.08795;
MatrixA(47,20) = 0.336478;
MatrixA(47,21) = 6.09014;
MatrixA(47,24) = 4.51816;
MatrixA(47,25) = 9.24488;
MatrixA(47,26) = 4.51211;
MatrixA(47,27) = 9.23147;
MatrixA(47,28) = 4.50221;
MatrixA(47,29) = 9.32402;
MatrixA(47,30) = 4.50827;
MatrixA(47,31) = 9.33749;
MatrixA(47,32) = 0.088022;
MatrixA(47,35) = -0.088022;
MatrixA(47,36) = -7.35003;
MatrixA(47,37) = -0.000384296;
MatrixA(47,38) = -0.239707;
MatrixA(47,39) = -0.0052289;
MatrixA(47,40) = 6.24476;
MatrixA(47,41) = -0.000778529;
MatrixA(47,42) = -0.0022197;
MatrixA(47,43) = -0.200947;
MatrixA(47,44) = -0.00283276;
MatrixA(47,45) = -0.00283276;
MatrixA(47,46) = 0.00923;
MatrixA(47,47) = -68.1738;
MatrixA(47,48) = 1.44186;
MatrixA(47,49) = 1.4411;
MatrixA(47,52) = 0.00280183;
MatrixA(48,1) = 639.933;
MatrixA(48,2) = 2162.39;
MatrixA(48,3) = 595.323;
MatrixA(48,6) = -2.58249e-06;
MatrixA(48,7) = 4.00958e-08;
MatrixA(48,8) = -11.8354;
MatrixA(48,9) = 281.033;
MatrixA(48,12) = 543.986;
MatrixA(48,13) = 328.958;
MatrixA(48,16) = 0.254012;
MatrixA(48,17) = 4.89478;
MatrixA(48,20) = 0.253956;
MatrixA(48,21) = 4.89669;
MatrixA(48,24) = -480.273;
MatrixA(48,25) = -995.821;
MatrixA(48,26) = -479.624;
MatrixA(48,27) = -994.376;
MatrixA(48,28) = 8.41588;
MatrixA(48,29) = 17.662;
MatrixA(48,30) = 8.42732;
MatrixA(48,31) = 17.6875;
MatrixA(48,32) = 14.5495;
MatrixA(48,35) = -14.5495;
MatrixA(48,36) = 388.978;
MatrixA(48,37) = 0.021451;
MatrixA(48,38) = 12.6858;
MatrixA(48,39) = -382.367;
MatrixA(48,40) = -331.165;
MatrixA(48,41) = 12.492;
MatrixA(48,42) = 0.000235582;
MatrixA(48,43) = 3.23402;
MatrixA(48,44) = 5.2443;
MatrixA(48,45) = 5.2443;
MatrixA(48,46) = 12.4847;
MatrixA(48,47) = 49.3241;
MatrixA(48,48) = -163.239;
MatrixA(48,49) = -2.03804;
MatrixA(48,52) = 0.463124;
MatrixA(49,1) = 637.96;
MatrixA(49,2) = 2155.57;
MatrixA(49,3) = -617.997;
MatrixA(49,6) = -2.58249e-06;
MatrixA(49,7) = 4.00958e-08;
MatrixA(49,8) = -11.8354;
MatrixA(49,9) = 281.033;
MatrixA(49,12) = -669.341;
MatrixA(49,13) = 326.992;
MatrixA(49,16) = 0.254012;
MatrixA(49,17) = 4.89478;
MatrixA(49,20) = 0.253956;
MatrixA(49,21) = 4.89669;
MatrixA(49,24) = 8.44853;
MatrixA(49,25) = 17.5165;
MatrixA(49,26) = 8.43711;
MatrixA(49,27) = 17.491;
MatrixA(49,28) = -478.412;
MatrixA(49,29) = -1004.09;
MatrixA(49,30) = -479.062;
MatrixA(49,31) = -1005.54;
MatrixA(49,32) = 14.5495;
MatrixA(49,35) = -14.5495;
MatrixA(49,36) = 388.659;
MatrixA(49,37) = 0.0214334;
MatrixA(49,38) = 12.6754;
MatrixA(49,39) = 382.728;
MatrixA(49,40) = -329.591;
MatrixA(49,41) = -12.4637;
MatrixA(49,42) = 0.000235582;
MatrixA(49,43) = 3.23402;
MatrixA(49,44) = 5.2443;
MatrixA(49,45) = 5.2443;
MatrixA(49,46) = -12.471;
MatrixA(49,47) = 49.2803;
MatrixA(49,48) = -2.03591;
MatrixA(49,49) = -163.116;
MatrixA(49,52) = 0.463124;
MatrixA(50,1) = 0.0215963;
MatrixA(50,2) = 0.0215963;
MatrixA(50,3) = 0.0215963;
MatrixA(50,4) = 0.0215963;
MatrixA(50,5) = 0.0215963;
MatrixA(50,6) = 0.0215963;
MatrixA(50,7) = 0.0215963;
MatrixA(50,8) = 0.0215963;
MatrixA(50,9) = 0.0215963;
MatrixA(50,10) = 0.0215963;
MatrixA(50,11) = 0.0215963;
MatrixA(50,12) = 0.0215963;
MatrixA(50,13) = 0.0215963;
MatrixA(50,14) = 0.0215963;
MatrixA(50,15) = 0.0215963;
MatrixA(50,16) = 0.0215963;
MatrixA(50,17) = 0.0215963;
MatrixA(50,18) = 0.0215963;
MatrixA(50,19) = 0.0215963;
MatrixA(50,20) = 0.0215963;
MatrixA(50,21) = 0.0215963;
MatrixA(50,22) = 0.0215963;
MatrixA(50,23) = 0.0215963;
MatrixA(50,24) = 0.0215963;
MatrixA(50,25) = 0.0215963;
MatrixA(50,26) = 0.0215963;
MatrixA(50,27) = 0.0215963;
MatrixA(50,28) = 0.0215963;
MatrixA(50,29) = 0.0215963;
MatrixA(50,30) = 0.0215963;
MatrixA(50,31) = 0.0215963;
MatrixA(50,32) = 0.0215963;
MatrixA(50,33) = 0.0215963;
MatrixA(50,34) = 0.0215963;
MatrixA(50,35) = 0.0215963;
MatrixA(50,36) = -796.177;
MatrixA(50,37) = 0.0215963;
MatrixA(50,38) = -25.9963;
MatrixA(50,39) = 0.0215963;
MatrixA(50,40) = 0.0215963;
MatrixA(50,41) = 0.0215963;
MatrixA(50,42) = 0.0215963;
MatrixA(50,43) = 0.0215963;
MatrixA(50,44) = 0.0215963;
MatrixA(50,45) = 0.369514;
MatrixA(50,46) = 0.369514;
MatrixA(50,47) = 0.0215963;
MatrixA(50,48) = 0.0215963;
MatrixA(50,49) = 0.369514;
MatrixA(50,50) = 0.106011;
MatrixA(50,51) = 0.0215963;
MatrixA(50,52) = 0.723948;
MatrixA(51,32) = -2232.69;
MatrixA(51,35) = 2232.69;
MatrixA(51,44) = 72.8456;
MatrixA(51,45) = 72.8456;
MatrixA(51,48) = 72.8456;
MatrixA(51,49) = 72.8456;
MatrixA(51,50) = 33.5948;
MatrixA(51,52) = -87.0608;
MatrixA(52,32) = -3144.64;
MatrixA(52,35) = 3144.64;
MatrixA(52,44) = 102.599;
MatrixA(52,45) = 102.599;
MatrixA(52,48) = 102.599;
MatrixA(52,49) = 102.599;
MatrixA(52,50) = 47.3166;
MatrixA(52,52) = -122.621;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 0.0215963;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.00774593;
MatrixC(2,2) = 0.0231783;
MatrixC(2,3) = -3.06198;
MatrixC(2,6) = 0.00353476;
MatrixC(2,7) = -7.69784e-15;
MatrixC(2,8) = -1.9559;
MatrixC(2,9) = 0.00109627;
MatrixC(2,12) = -1.10167;
MatrixC(2,13) = 0.00662269;
MatrixC(2,16) = -34.7625;
MatrixC(2,17) = -0.000159542;
MatrixC(2,20) = -34.7671;
MatrixC(2,21) = -0.000159567;
MatrixC(2,24) = -12.5656;
MatrixC(2,25) = -5.08225e-06;
MatrixC(2,26) = -12.5607;
MatrixC(2,27) = -5.07383e-06;
MatrixC(2,28) = -12.604;
MatrixC(2,29) = -5.12693e-06;
MatrixC(2,30) = -12.6089;
MatrixC(2,31) = -5.13539e-06;
MatrixC(2,32) = 1.09775e-15;
MatrixC(2,35) = -1.0842e-15;
MatrixC(2,36) = 1.01869e-06;
MatrixC(2,37) = -0.0100177;
MatrixC(2,38) = 1.70926e-05;
MatrixC(2,39) = 0.000821783;
MatrixC(2,40) = -1.75958e-06;
MatrixC(2,41) = -0.000728667;
MatrixC(2,42) = 8.53372e-05;
MatrixC(2,43) = -5.57067e-09;
MatrixC(2,44) = -4.74338e-16;
MatrixC(2,45) = -4.74338e-16;
MatrixC(2,46) = -8.16587e-05;
MatrixC(2,47) = 5.11609e-07;
MatrixC(2,48) = -7.71758e-07;
MatrixC(2,49) = -7.71102e-07;
MatrixC(2,52) = 4.06576e-17;

MatrixD = zeros(2, 1);
