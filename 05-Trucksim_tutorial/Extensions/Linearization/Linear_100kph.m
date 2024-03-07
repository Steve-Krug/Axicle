% MATLAB linearized TruckSim 2023.0 model, calculated at t = 220.014 s.
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

MatrixA(1,2) = -27.7743;
MatrixA(1,3) = -0.000241137;
MatrixA(1,36) = -0.0322929;
MatrixA(1,37) = 0.0015036;
MatrixA(1,38) = 0.999477;
MatrixA(1,39) = 0.00193964;
MatrixA(1,40) = -1.26188;
MatrixA(1,41) = 0.00127806;
MatrixA(2,3) = 3.13862e-05;
MatrixA(2,39) = -0.00150438;
MatrixA(2,40) = 0.999999;
MatrixA(3,2) = -3.14207e-05;
MatrixA(3,3) = 4.70971e-08;
MatrixA(3,39) = 0.0323097;
MatrixA(3,40) = 4.86063e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -237982;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 4.28553e-07;
MatrixA(16,2) = 0.00140652;
MatrixA(16,3) = 6.24238e-06;
MatrixA(16,6) = -2.31386;
MatrixA(16,7) = -0.00083319;
MatrixA(16,8) = 1.30856;
MatrixA(16,9) = -1.06843e-06;
MatrixA(16,16) = -39.2122;
MatrixA(16,36) = -1.0487e-05;
MatrixA(16,37) = 1.40929;
MatrixA(16,38) = -0.00212046;
MatrixA(16,39) = 1.83538;
MatrixA(16,40) = 0.00277004;
MatrixA(16,41) = 1.13974;
MatrixA(16,42) = 0.466096;
MatrixA(16,43) = -5.1714e-05;
MatrixA(20,1) = 4.24824e-07;
MatrixA(20,2) = 0.00140308;
MatrixA(20,3) = 5.15174e-06;
MatrixA(20,6) = -2.30812;
MatrixA(20,7) = -0.000830969;
MatrixA(20,8) = 1.22037;
MatrixA(20,9) = -1.06826e-06;
MatrixA(20,20) = -39.1161;
MatrixA(20,36) = -1.04613e-05;
MatrixA(20,37) = 1.40584;
MatrixA(20,38) = -0.00211526;
MatrixA(20,39) = 1.83086;
MatrixA(20,40) = 0.00276322;
MatrixA(20,41) = 1.13695;
MatrixA(20,42) = 0.464956;
MatrixA(20,43) = -5.15873e-05;
MatrixA(24,1) = 2.44523e-07;
MatrixA(24,2) = -0.000857137;
MatrixA(24,3) = 1.00376e-06;
MatrixA(24,12) = 3.17113;
MatrixA(24,13) = -1.538e-05;
MatrixA(24,24) = -89.9411;
MatrixA(24,36) = -3.64426e-05;
MatrixA(24,37) = 3.23244;
MatrixA(24,38) = -0.00486402;
MatrixA(24,39) = -6.74637;
MatrixA(24,40) = -0.0101181;
MatrixA(24,41) = 2.96817;
MatrixA(24,46) = 1.5844;
MatrixA(24,47) = 1.33063e-05;
MatrixA(26,1) = 2.44505e-07;
MatrixA(26,2) = -0.000856899;
MatrixA(26,3) = 1.10351e-06;
MatrixA(26,12) = 3.28169;
MatrixA(26,13) = -1.53769e-05;
MatrixA(26,26) = -89.9255;
MatrixA(26,36) = -3.64362e-05;
MatrixA(26,37) = 3.23188;
MatrixA(26,38) = -0.00486317;
MatrixA(26,39) = -6.74518;
MatrixA(26,40) = -0.0101164;
MatrixA(26,41) = 2.96765;
MatrixA(26,46) = 1.58412;
MatrixA(26,47) = 1.3304e-05;
MatrixA(28,1) = 2.4462e-07;
MatrixA(28,2) = -0.000858462;
MatrixA(28,3) = 5.55486e-07;
MatrixA(28,12) = 2.67393;
MatrixA(28,13) = -1.53969e-05;
MatrixA(28,28) = -90.028;
MatrixA(28,36) = -3.64779e-05;
MatrixA(28,37) = 3.23557;
MatrixA(28,38) = -0.00486873;
MatrixA(28,39) = -6.75295;
MatrixA(28,40) = -0.010128;
MatrixA(28,41) = 2.97104;
MatrixA(28,46) = 1.58593;
MatrixA(28,47) = 1.33192e-05;
MatrixA(30,1) = 2.44638e-07;
MatrixA(30,2) = -0.000858701;
MatrixA(30,3) = 4.89738e-07;
MatrixA(30,12) = 2.60095;
MatrixA(30,13) = -1.54e-05;
MatrixA(30,30) = -90.0437;
MatrixA(30,36) = -3.64843e-05;
MatrixA(30,37) = 3.23614;
MatrixA(30,38) = -0.00486958;
MatrixA(30,39) = -6.75414;
MatrixA(30,40) = -0.0101298;
MatrixA(30,41) = 2.97156;
MatrixA(30,46) = 1.58621;
MatrixA(30,47) = 1.33215e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 72.779;
MatrixA(36,2) = 226.405;
MatrixA(36,3) = 0.0303076;
MatrixA(36,6) = 6.51478e-05;
MatrixA(36,7) = 2.98201e-06;
MatrixA(36,8) = 0.796993;
MatrixA(36,9) = -14.1862;
MatrixA(36,12) = 9.2658;
MatrixA(36,13) = 132.148;
MatrixA(36,16) = 8.35018;
MatrixA(36,20) = 8.36805;
MatrixA(36,24) = 3.37632;
MatrixA(36,26) = 3.37728;
MatrixA(36,28) = 3.37077;
MatrixA(36,30) = 3.36981;
MatrixA(36,32) = -0.00367125;
MatrixA(36,35) = 0.00367125;
MatrixA(36,36) = -3.95748;
MatrixA(36,37) = -0.000226981;
MatrixA(36,38) = -0.127871;
MatrixA(36,39) = -0.00272255;
MatrixA(36,40) = 2.46294;
MatrixA(36,41) = -4.26933e-05;
MatrixA(36,42) = 5.96401e-05;
MatrixA(36,43) = -0.309555;
MatrixA(36,44) = 0.460106;
MatrixA(36,45) = 0.461557;
MatrixA(36,46) = -0.000169476;
MatrixA(36,47) = 0.679867;
MatrixA(36,48) = 0.314995;
MatrixA(36,49) = 0.314534;
MatrixA(36,52) = -0.00011686;
MatrixA(37,1) = 0.0318517;
MatrixA(37,2) = 0.0912478;
MatrixA(37,3) = 99.9811;
MatrixA(37,6) = 0.0126599;
MatrixA(37,7) = 0.00819543;
MatrixA(37,8) = -168.577;
MatrixA(37,9) = 4.25458;
MatrixA(37,12) = 214.977;
MatrixA(37,13) = -1.86245;
MatrixA(37,16) = -33.3998;
MatrixA(37,20) = -33.282;
MatrixA(37,24) = -7.25382;
MatrixA(37,26) = -7.2558;
MatrixA(37,28) = -6.96175;
MatrixA(37,30) = -6.95985;
MatrixA(37,32) = -0.00475124;
MatrixA(37,35) = 0.00475124;
MatrixA(37,36) = 0.000327982;
MatrixA(37,37) = -0.0323582;
MatrixA(37,38) = 5.92069e-05;
MatrixA(37,39) = -27.8041;
MatrixA(37,40) = -0.000325862;
MatrixA(37,41) = 0.880694;
MatrixA(37,42) = -1.06653;
MatrixA(37,43) = 0.00932805;
MatrixA(37,44) = -0.0024514;
MatrixA(37,45) = 0.0105759;
MatrixA(37,46) = 0.267539;
MatrixA(37,47) = 0.00766062;
MatrixA(37,48) = -0.0168842;
MatrixA(37,49) = 0.00926354;
MatrixA(37,52) = -0.000151237;
MatrixA(38,1) = -7.55221;
MatrixA(38,2) = -25.2464;
MatrixA(38,3) = -0.145252;
MatrixA(38,6) = -1.77641e-05;
MatrixA(38,7) = -1.20308e-05;
MatrixA(38,8) = -20.8304;
MatrixA(38,9) = 599.71;
MatrixA(38,12) = 55.6974;
MatrixA(38,13) = 381.22;
MatrixA(38,16) = 0.146881;
MatrixA(38,20) = 0.146838;
MatrixA(38,24) = -0.376221;
MatrixA(38,26) = -0.376328;
MatrixA(38,28) = -0.376022;
MatrixA(38,30) = -0.375915;
MatrixA(38,32) = 0.000284059;
MatrixA(38,35) = -0.000284059;
MatrixA(38,36) = 0.16285;
MatrixA(38,37) = -4.02219e-06;
MatrixA(38,38) = 0.0052618;
MatrixA(38,39) = 3.11093e-05;
MatrixA(38,40) = 27.6263;
MatrixA(38,41) = -0.00156588;
MatrixA(38,42) = 0.00215674;
MatrixA(38,43) = 6.84039;
MatrixA(38,44) = 0.00538082;
MatrixA(38,45) = 0.0053743;
MatrixA(38,46) = -0.000380515;
MatrixA(38,47) = 5.4662;
MatrixA(38,48) = -0.0360962;
MatrixA(38,49) = -0.0360826;
MatrixA(38,52) = 9.04189e-06;
MatrixA(39,1) = -0.0136901;
MatrixA(39,2) = -0.0730716;
MatrixA(39,3) = -220.202;
MatrixA(39,6) = 0.00666198;
MatrixA(39,7) = 0.00529203;
MatrixA(39,8) = -77.9485;
MatrixA(39,9) = 1.6894;
MatrixA(39,12) = -201.635;
MatrixA(39,13) = 3.61566;
MatrixA(39,16) = -19.5982;
MatrixA(39,20) = -14.287;
MatrixA(39,24) = 4.99422;
MatrixA(39,26) = 4.99557;
MatrixA(39,28) = 7.38183;
MatrixA(39,30) = 7.3798;
MatrixA(39,32) = -0.00619163;
MatrixA(39,35) = 0.00619163;
MatrixA(39,36) = -0.00112451;
MatrixA(39,37) = -0.00295387;
MatrixA(39,38) = -3.18895e-05;
MatrixA(39,39) = -1.04996;
MatrixA(39,40) = -0.000625071;
MatrixA(39,41) = -0.171029;
MatrixA(39,42) = -0.484853;
MatrixA(39,43) = 0.00484587;
MatrixA(39,44) = -0.148057;
MatrixA(39,45) = 0.147935;
MatrixA(39,46) = -0.528089;
MatrixA(39,47) = -0.00648784;
MatrixA(39,48) = -0.111144;
MatrixA(39,49) = 0.112517;
MatrixA(39,52) = -0.000197086;
MatrixA(40,1) = -20.2879;
MatrixA(40,2) = -63.8728;
MatrixA(40,3) = -0.319985;
MatrixA(40,6) = -1.12797e-05;
MatrixA(40,7) = 7.26778e-06;
MatrixA(40,8) = 9.84638;
MatrixA(40,9) = -284.438;
MatrixA(40,12) = 41.8448;
MatrixA(40,13) = 272.678;
MatrixA(40,16) = -1.26689;
MatrixA(40,20) = -1.262;
MatrixA(40,24) = -0.975574;
MatrixA(40,26) = -0.97585;
MatrixA(40,28) = -0.970408;
MatrixA(40,30) = -0.970133;
MatrixA(40,32) = -0.0403614;
MatrixA(40,35) = 0.0403614;
MatrixA(40,36) = 0.811053;
MatrixA(40,37) = 3.82623e-05;
MatrixA(40,38) = 0.0262059;
MatrixA(40,39) = -0.0008913;
MatrixA(40,40) = -0.692626;
MatrixA(40,41) = -0.000244332;
MatrixA(40,42) = -0.000913179;
MatrixA(40,43) = -3.22275;
MatrixA(40,44) = -0.0671081;
MatrixA(40,45) = -0.0669034;
MatrixA(40,46) = -0.000645626;
MatrixA(40,47) = 4.15576;
MatrixA(40,48) = -0.0905077;
MatrixA(40,49) = -0.0900414;
MatrixA(40,52) = -0.00128474;
MatrixA(41,1) = 0.0370309;
MatrixA(41,2) = 0.107157;
MatrixA(41,3) = 116.272;
MatrixA(41,6) = 0.0139821;
MatrixA(41,7) = 0.00895522;
MatrixA(41,8) = 157.4;
MatrixA(41,9) = -11.1823;
MatrixA(41,12) = 515.437;
MatrixA(41,13) = -38.1934;
MatrixA(41,16) = -36.6895;
MatrixA(41,20) = -37.0747;
MatrixA(41,24) = -7.71619;
MatrixA(41,26) = -7.71829;
MatrixA(41,28) = -7.62812;
MatrixA(41,30) = -7.62604;
MatrixA(41,32) = 0.0595645;
MatrixA(41,35) = -0.0595645;
MatrixA(41,36) = 0.000335326;
MatrixA(41,37) = -0.0224953;
MatrixA(41,38) = 4.46806e-05;
MatrixA(41,39) = 0.0685682;
MatrixA(41,40) = -0.000194295;
MatrixA(41,41) = -0.00098677;
MatrixA(41,42) = 3.75785;
MatrixA(41,43) = 0.0102996;
MatrixA(41,44) = 0.00929968;
MatrixA(41,45) = -0.00469742;
MatrixA(41,46) = 4.27893;
MatrixA(41,47) = 0.00827672;
MatrixA(41,48) = -0.00976997;
MatrixA(41,49) = -0.00273729;
MatrixA(41,52) = 0.001896;
MatrixA(42,1) = 0.0525593;
MatrixA(42,2) = -0.095897;
MatrixA(42,3) = -11484.2;
MatrixA(42,6) = 0.754179;
MatrixA(42,7) = 0.98692;
MatrixA(42,8) = -17804.6;
MatrixA(42,9) = 299.877;
MatrixA(42,12) = -427.36;
MatrixA(42,13) = 31.4105;
MatrixA(42,16) = -499.413;
MatrixA(42,20) = -522.691;
MatrixA(42,24) = 5.74633;
MatrixA(42,26) = 5.74789;
MatrixA(42,28) = 7.15251;
MatrixA(42,30) = 7.15055;
MatrixA(42,32) = -0.643524;
MatrixA(42,35) = 0.643524;
MatrixA(42,36) = 0.0053803;
MatrixA(42,37) = 0.00196012;
MatrixA(42,38) = 0.000170943;
MatrixA(42,39) = 19.1544;
MatrixA(42,40) = 0.0236525;
MatrixA(42,41) = -0.201209;
MatrixA(42,42) = -93.4682;
MatrixA(42,43) = -0.00821163;
MatrixA(42,44) = 0.85991;
MatrixA(42,45) = -0.322625;
MatrixA(42,46) = -3.56483;
MatrixA(42,47) = -0.00692378;
MatrixA(42,48) = -0.293791;
MatrixA(42,49) = -0.161634;
MatrixA(42,52) = -0.020484;
MatrixA(43,1) = -3792.32;
MatrixA(43,2) = -6.15654;
MatrixA(43,3) = 1.20049;
MatrixA(43,6) = 0.000167669;
MatrixA(43,7) = 7.08902e-05;
MatrixA(43,8) = 262.646;
MatrixA(43,9) = -11328.6;
MatrixA(43,12) = -2.04631;
MatrixA(43,13) = -29.4401;
MatrixA(43,16) = 1.89716;
MatrixA(43,20) = 1.89924;
MatrixA(43,24) = -0.875215;
MatrixA(43,26) = -0.875463;
MatrixA(43,28) = -0.873654;
MatrixA(43,30) = -0.873406;
MatrixA(43,32) = -0.0524233;
MatrixA(43,35) = 0.0524233;
MatrixA(43,36) = -0.124961;
MatrixA(43,37) = 7.17416e-05;
MatrixA(43,38) = -0.00403772;
MatrixA(43,39) = 0.000428832;
MatrixA(43,40) = 0.0976064;
MatrixA(43,41) = -0.000320382;
MatrixA(43,42) = -0.0170598;
MatrixA(43,43) = -86.2181;
MatrixA(43,44) = 0.106164;
MatrixA(43,45) = 0.106384;
MatrixA(43,46) = -0.00312482;
MatrixA(43,47) = -0.10527;
MatrixA(43,48) = -0.0804394;
MatrixA(43,49) = -0.0803081;
MatrixA(43,52) = -0.00166869;
MatrixA(44,1) = 448.195;
MatrixA(44,2) = 55.1047;
MatrixA(44,3) = 376.022;
MatrixA(44,6) = -0.0295681;
MatrixA(44,7) = 0.174143;
MatrixA(44,8) = 366.426;
MatrixA(44,9) = 712.125;
MatrixA(44,12) = -42.1406;
MatrixA(44,13) = -272.673;
MatrixA(44,16) = -1469.37;
MatrixA(44,20) = 19.2575;
MatrixA(44,24) = 0.982901;
MatrixA(44,26) = 0.983179;
MatrixA(44,28) = 0.981243;
MatrixA(44,30) = 0.980965;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 202.776;
MatrixA(44,37) = 0.0099973;
MatrixA(44,38) = 6.55187;
MatrixA(44,39) = -182.463;
MatrixA(44,40) = -172.808;
MatrixA(44,41) = 5.90368;
MatrixA(44,42) = 5.89844;
MatrixA(44,43) = 9.80084;
MatrixA(44,44) = -86.6025;
MatrixA(44,45) = -2.50163;
MatrixA(44,46) = -0.000128291;
MatrixA(44,47) = -4.15577;
MatrixA(44,48) = 4.0492;
MatrixA(44,49) = 4.04906;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 446.893;
MatrixA(45,2) = 55.1147;
MatrixA(45,3) = -390.804;
MatrixA(45,6) = 0.0220607;
MatrixA(45,7) = -0.174554;
MatrixA(45,8) = -400.401;
MatrixA(45,9) = 710.823;
MatrixA(45,12) = -42.1406;
MatrixA(45,13) = -272.673;
MatrixA(45,16) = 19.2173;
MatrixA(45,20) = -1472.42;
MatrixA(45,24) = 0.982901;
MatrixA(45,26) = 0.983179;
MatrixA(45,28) = 0.981243;
MatrixA(45,30) = 0.980965;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 203.42;
MatrixA(45,37) = 0.0100291;
MatrixA(45,38) = 6.57267;
MatrixA(45,39) = 183.224;
MatrixA(45,40) = -172.805;
MatrixA(45,41) = -5.9116;
MatrixA(45,42) = -5.91686;
MatrixA(45,43) = 9.82164;
MatrixA(45,44) = -2.50492;
MatrixA(45,45) = -86.8526;
MatrixA(45,46) = -0.000128291;
MatrixA(45,47) = -4.15577;
MatrixA(45,48) = 4.0492;
MatrixA(45,49) = 4.04906;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 1.22771;
MatrixA(46,2) = 4.40059;
MatrixA(46,3) = -27703.8;
MatrixA(46,6) = -0.0159948;
MatrixA(46,7) = -0.00935142;
MatrixA(46,8) = -184.409;
MatrixA(46,9) = 12.9566;
MatrixA(46,12) = -33483.7;
MatrixA(46,13) = 725.009;
MatrixA(46,16) = 40.1261;
MatrixA(46,20) = 45.3525;
MatrixA(46,24) = -244.618;
MatrixA(46,26) = -244.683;
MatrixA(46,28) = -253.639;
MatrixA(46,30) = -253.571;
MatrixA(46,32) = -0.677137;
MatrixA(46,35) = 0.677137;
MatrixA(46,36) = -0.00112698;
MatrixA(46,37) = 0.0379635;
MatrixA(46,38) = -9.35055e-05;
MatrixA(46,39) = 14.4064;
MatrixA(46,40) = 0.0227354;
MatrixA(46,41) = -0.230179;
MatrixA(46,42) = -4.43228;
MatrixA(46,43) = -0.0116976;
MatrixA(46,44) = -0.380472;
MatrixA(46,45) = -0.100858;
MatrixA(46,46) = -79.8606;
MatrixA(46,47) = -0.0102136;
MatrixA(46,48) = 0.725046;
MatrixA(46,49) = -0.154911;
MatrixA(46,52) = -0.0215539;
MatrixA(47,1) = -6569.47;
MatrixA(47,2) = -22196.7;
MatrixA(47,3) = 7.94775;
MatrixA(47,6) = 2.89305e-05;
MatrixA(47,7) = -3.21111e-06;
MatrixA(47,8) = 0.536364;
MatrixA(47,9) = -16.2887;
MatrixA(47,12) = -689.479;
MatrixA(47,13) = -11344.2;
MatrixA(47,16) = 1.56354;
MatrixA(47,20) = 1.56775;
MatrixA(47,24) = 7.59682;
MatrixA(47,26) = 7.59897;
MatrixA(47,28) = 7.58551;
MatrixA(47,30) = 7.58336;
MatrixA(47,32) = 0.0818093;
MatrixA(47,35) = -0.0818093;
MatrixA(47,36) = -4.02044;
MatrixA(47,37) = -0.000134323;
MatrixA(47,38) = -0.129904;
MatrixA(47,39) = -0.00295505;
MatrixA(47,40) = 3.42096;
MatrixA(47,41) = -0.000710561;
MatrixA(47,42) = -0.00197678;
MatrixA(47,43) = -0.214308;
MatrixA(47,44) = 0.0826139;
MatrixA(47,45) = 0.0829296;
MatrixA(47,46) = 0.00826675;
MatrixA(47,47) = -67.6643;
MatrixA(47,48) = 0.701961;
MatrixA(47,49) = 0.701043;
MatrixA(47,52) = 0.00260407;
MatrixA(48,1) = 1569.73;
MatrixA(48,2) = 5328.01;
MatrixA(48,3) = 1515.4;
MatrixA(48,6) = 2.13395e-05;
MatrixA(48,7) = 7.23412e-07;
MatrixA(48,8) = -9.96407;
MatrixA(48,9) = 284.44;
MatrixA(48,12) = 1474.93;
MatrixA(48,13) = 1270.7;
MatrixA(48,16) = 1.23729;
MatrixA(48,20) = 1.24043;
MatrixA(48,24) = -817.488;
MatrixA(48,26) = -817.72;
MatrixA(48,28) = 14.3544;
MatrixA(48,30) = 14.3503;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 190.374;
MatrixA(48,37) = 0.00928535;
MatrixA(48,38) = 6.15115;
MatrixA(48,39) = -187.556;
MatrixA(48,40) = -162.263;
MatrixA(48,41) = 6.06757;
MatrixA(48,42) = 0.00018103;
MatrixA(48,43) = 3.22275;
MatrixA(48,44) = 5.34488;
MatrixA(48,45) = 5.34512;
MatrixA(48,46) = 6.06437;
MatrixA(48,47) = 21.9467;
MatrixA(48,48) = -83.8242;
MatrixA(48,49) = -3.39953;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 1572.16;
MatrixA(49,2) = 5336.48;
MatrixA(49,3) = -1528.86;
MatrixA(49,6) = 2.13395e-05;
MatrixA(49,7) = 7.23412e-07;
MatrixA(49,8) = -9.96407;
MatrixA(49,9) = 284.44;
MatrixA(49,12) = -1569.33;
MatrixA(49,13) = 1273.13;
MatrixA(49,16) = 1.23729;
MatrixA(49,20) = 1.24043;
MatrixA(49,24) = 14.379;
MatrixA(49,26) = 14.383;
MatrixA(49,28) = -816.085;
MatrixA(49,30) = -815.853;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 190.072;
MatrixA(49,37) = 0.00927061;
MatrixA(49,38) = 6.14138;
MatrixA(49,39) = 187.501;
MatrixA(49,40) = -161.441;
MatrixA(49,41) = -6.05044;
MatrixA(49,42) = 0.00018103;
MatrixA(49,43) = 3.22275;
MatrixA(49,44) = 5.34488;
MatrixA(49,45) = 5.34512;
MatrixA(49,46) = -6.05363;
MatrixA(49,47) = 21.9055;
MatrixA(49,48) = -3.39749;
MatrixA(49,49) = -83.7073;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = -0.000328823;
MatrixA(50,2) = -0.000328823;
MatrixA(50,3) = -0.000328823;
MatrixA(50,4) = -0.000328823;
MatrixA(50,5) = -0.000328823;
MatrixA(50,6) = -0.000328823;
MatrixA(50,7) = -0.000328823;
MatrixA(50,8) = -0.000328823;
MatrixA(50,9) = -0.000328823;
MatrixA(50,10) = -0.000328823;
MatrixA(50,11) = -0.000328823;
MatrixA(50,12) = -0.000328823;
MatrixA(50,13) = -0.000328823;
MatrixA(50,14) = -0.000328823;
MatrixA(50,15) = -0.000328823;
MatrixA(50,16) = -0.000328823;
MatrixA(50,17) = -0.000328823;
MatrixA(50,18) = -0.000328823;
MatrixA(50,19) = -0.000328823;
MatrixA(50,20) = -0.000328823;
MatrixA(50,21) = -0.000328823;
MatrixA(50,22) = -0.000328823;
MatrixA(50,23) = -0.000328823;
MatrixA(50,24) = -0.000328823;
MatrixA(50,25) = -0.000328823;
MatrixA(50,26) = -0.000328823;
MatrixA(50,27) = -0.000328823;
MatrixA(50,28) = -0.000328823;
MatrixA(50,29) = -0.000328823;
MatrixA(50,30) = -0.000328823;
MatrixA(50,31) = -0.000328823;
MatrixA(50,32) = -0.000328823;
MatrixA(50,33) = -0.000328823;
MatrixA(50,34) = -0.000328823;
MatrixA(50,35) = -0.000328823;
MatrixA(50,36) = -1439.68;
MatrixA(50,37) = -0.000328823;
MatrixA(50,38) = -46.5417;
MatrixA(50,39) = -0.000328823;
MatrixA(50,40) = -0.000328823;
MatrixA(50,41) = -0.000328823;
MatrixA(50,42) = -0.000328823;
MatrixA(50,43) = -0.000328823;
MatrixA(50,44) = -0.000328823;
MatrixA(50,45) = -0.0939671;
MatrixA(50,46) = -0.0939671;
MatrixA(50,47) = -0.000328823;
MatrixA(50,48) = -0.000328823;
MatrixA(50,49) = -0.0939671;
MatrixA(50,50) = -5.62769;
MatrixA(50,51) = -0.000328823;
MatrixA(50,52) = 4.24981;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 83.9244;
MatrixA(51,52) = -107.952;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 137.581;
MatrixA(52,52) = -176.971;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = -0.000328823;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0664608;
MatrixC(2,2) = 0.176942;
MatrixC(2,3) = -2.963;
MatrixC(2,6) = 0.00662997;
MatrixC(2,7) = -1.70071e-11;
MatrixC(2,8) = -1.81062;
MatrixC(2,9) = 0.0165971;
MatrixC(2,12) = -1.10547;
MatrixC(2,13) = 0.0496598;
MatrixC(2,16) = -29.9173;
MatrixC(2,20) = -30.0239;
MatrixC(2,24) = -10.2732;
MatrixC(2,26) = -10.276;
MatrixC(2,28) = -10.2563;
MatrixC(2,30) = -10.2535;
MatrixC(2,32) = -9.75782e-16;
MatrixC(2,35) = 9.75782e-16;
MatrixC(2,36) = 1.19135e-05;
MatrixC(2,37) = -0.0334604;
MatrixC(2,38) = 5.07262e-05;
MatrixC(2,39) = 0.00274504;
MatrixC(2,40) = -1.29051e-05;
MatrixC(2,41) = -0.00243701;
MatrixC(2,42) = 0.000282658;
MatrixC(2,43) = 4.21e-07;
MatrixC(2,44) = -2.12594e-06;
MatrixC(2,45) = -2.13542e-06;
MatrixC(2,46) = -0.000273554;
MatrixC(2,47) = 1.22318e-06;
MatrixC(2,48) = -1.93195e-06;
MatrixC(2,49) = -1.92881e-06;

MatrixD = zeros(2, 1);
