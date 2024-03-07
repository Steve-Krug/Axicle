% MATLAB linearized TruckSim 2023.0 model, calculated at t = 180.011 s.
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

MatrixA(1,2) = -22.215;
MatrixA(1,3) = -0.000327708;
MatrixA(1,36) = -0.0320795;
MatrixA(1,37) = 0.00192145;
MatrixA(1,38) = 0.999483;
MatrixA(1,39) = 0.00247867;
MatrixA(1,40) = -1.26207;
MatrixA(1,41) = 0.00163323;
MatrixA(2,3) = 2.07644e-05;
MatrixA(2,39) = -0.00192244;
MatrixA(2,40) = 0.999998;
MatrixA(3,2) = -2.07873e-05;
MatrixA(3,3) = 4.96493e-08;
MatrixA(3,39) = 0.032096;
MatrixA(3,40) = 6.17027e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238027;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = -6.59969e-07;
MatrixA(16,2) = -0.00104082;
MatrixA(16,3) = 4.48614e-06;
MatrixA(16,6) = -1.83667;
MatrixA(16,7) = -0.000833113;
MatrixA(16,8) = 1.0314;
MatrixA(16,9) = -1.69195e-06;
MatrixA(16,16) = -31.1255;
MatrixA(16,36) = -1.77948e-06;
MatrixA(16,37) = 1.3986;
MatrixA(16,38) = -0.00268879;
MatrixA(16,39) = 1.82133;
MatrixA(16,40) = 0.00350292;
MatrixA(16,41) = 1.13126;
MatrixA(16,42) = 0.462724;
MatrixA(16,43) = 4.6522e-05;
MatrixA(17,1) = 1.06446e-05;
MatrixA(17,2) = 0.00561088;
MatrixA(17,3) = 9.35367e-06;
MatrixA(17,6) = 1.64058e-05;
MatrixA(17,7) = -0.000416899;
MatrixA(17,8) = 1.08608e-05;
MatrixA(17,9) = 1.03441e-05;
MatrixA(17,17) = -9.40623;
MatrixA(17,36) = -0.500118;
MatrixA(17,37) = -2.92065e-05;
MatrixA(17,38) = -0.0160636;
MatrixA(17,39) = 0.437867;
MatrixA(17,40) = 0.426867;
MatrixA(17,41) = -0.014069;
MatrixA(17,42) = -0.0140534;
MatrixA(17,43) = -0.0160637;
MatrixA(17,44) = 0.196688;
MatrixA(20,1) = -6.64625e-07;
MatrixA(20,2) = -0.00104313;
MatrixA(20,3) = 5.37411e-06;
MatrixA(20,6) = -1.84071;
MatrixA(20,7) = -0.00083513;
MatrixA(20,8) = 0.966954;
MatrixA(20,9) = -1.69905e-06;
MatrixA(20,20) = -31.1947;
MatrixA(20,36) = -1.78344e-06;
MatrixA(20,37) = 1.40171;
MatrixA(20,38) = -0.00269477;
MatrixA(20,39) = 1.82538;
MatrixA(20,40) = 0.00351071;
MatrixA(20,41) = 1.13377;
MatrixA(20,42) = 0.463753;
MatrixA(20,43) = 4.66254e-05;
MatrixA(21,1) = 1.06366e-05;
MatrixA(21,2) = 0.0054098;
MatrixA(21,3) = -1.00891e-05;
MatrixA(21,6) = 1.58117e-05;
MatrixA(21,7) = 0.000402064;
MatrixA(21,8) = -3.15516e-06;
MatrixA(21,9) = 1.03638e-05;
MatrixA(21,21) = -9.00338;
MatrixA(21,36) = -0.482028;
MatrixA(21,37) = -2.81508e-05;
MatrixA(21,38) = -0.015483;
MatrixA(21,39) = -0.422164;
MatrixA(21,40) = 0.409821;
MatrixA(21,41) = 0.0135355;
MatrixA(21,42) = 0.0135506;
MatrixA(21,43) = -0.015483;
MatrixA(21,45) = 0.189578;
MatrixA(24,1) = -5.68936e-06;
MatrixA(24,2) = 0.00304287;
MatrixA(24,3) = -3.86611e-06;
MatrixA(24,12) = 2.53287;
MatrixA(24,13) = -1.61331e-05;
MatrixA(24,24) = -72.2804;
MatrixA(24,36) = -1.44278e-05;
MatrixA(24,37) = 3.24786;
MatrixA(24,38) = -0.00624429;
MatrixA(24,39) = -6.77863;
MatrixA(24,40) = -0.0130193;
MatrixA(24,41) = 2.98034;
MatrixA(24,46) = 1.58997;
MatrixA(24,47) = -9.11251e-05;
MatrixA(26,1) = -5.69582e-06;
MatrixA(26,2) = 0.003047;
MatrixA(26,3) = -5.68822e-06;
MatrixA(26,12) = 2.62475;
MatrixA(26,13) = -1.61496e-05;
MatrixA(26,26) = -72.3419;
MatrixA(26,36) = -1.444e-05;
MatrixA(26,37) = 3.25062;
MatrixA(26,38) = -0.0062496;
MatrixA(26,39) = -6.78439;
MatrixA(26,40) = -0.0130303;
MatrixA(26,41) = 2.98288;
MatrixA(26,46) = 1.59132;
MatrixA(26,47) = -9.12026e-05;
MatrixA(28,1) = -5.65375e-06;
MatrixA(28,2) = 0.00302012;
MatrixA(28,3) = 4.25872e-06;
MatrixA(28,12) = 2.12282;
MatrixA(28,13) = -1.60424e-05;
MatrixA(28,28) = -71.941;
MatrixA(28,36) = -1.43601e-05;
MatrixA(28,37) = 3.23262;
MatrixA(28,38) = -0.00621498;
MatrixA(28,39) = -6.74684;
MatrixA(28,40) = -0.0129582;
MatrixA(28,41) = 2.96635;
MatrixA(28,46) = 1.58251;
MatrixA(28,47) = -9.06974e-05;
MatrixA(30,1) = -5.64738e-06;
MatrixA(30,2) = 0.00301606;
MatrixA(30,3) = 5.44139e-06;
MatrixA(30,12) = 2.06307;
MatrixA(30,13) = -1.60262e-05;
MatrixA(30,30) = -71.8803;
MatrixA(30,36) = -1.43479e-05;
MatrixA(30,37) = 3.22989;
MatrixA(30,38) = -0.00620973;
MatrixA(30,39) = -6.74115;
MatrixA(30,40) = -0.0129473;
MatrixA(30,41) = 2.96385;
MatrixA(30,46) = 1.58117;
MatrixA(30,47) = -9.06208e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 77.2135;
MatrixA(36,2) = 237.866;
MatrixA(36,3) = 0.00742842;
MatrixA(36,6) = 7.02088e-05;
MatrixA(36,7) = 1.08291e-06;
MatrixA(36,8) = 1.32671;
MatrixA(36,9) = -12.1521;
MatrixA(36,12) = 11.5051;
MatrixA(36,13) = 139.308;
MatrixA(36,16) = 6.86948;
MatrixA(36,17) = 1.85239;
MatrixA(36,20) = 6.87424;
MatrixA(36,21) = 1.76826;
MatrixA(36,24) = 3.37988;
MatrixA(36,26) = 3.37587;
MatrixA(36,28) = 3.39544;
MatrixA(36,30) = 3.39945;
MatrixA(36,32) = -0.00367745;
MatrixA(36,35) = 0.00367745;
MatrixA(36,36) = -4.76222;
MatrixA(36,37) = -0.000304729;
MatrixA(36,38) = -0.152852;
MatrixA(36,39) = -0.00931168;
MatrixA(36,40) = 3.33245;
MatrixA(36,41) = 8.55704e-05;
MatrixA(36,42) = -5.68102e-05;
MatrixA(36,43) = -0.322126;
MatrixA(36,44) = 0.542029;
MatrixA(36,45) = 0.54196;
MatrixA(36,46) = 6.85692e-05;
MatrixA(36,47) = 0.630244;
MatrixA(36,48) = 0.390871;
MatrixA(36,49) = 0.393838;
MatrixA(36,52) = -0.000117057;
MatrixA(37,1) = 0.0123759;
MatrixA(37,2) = -0.0122284;
MatrixA(37,3) = 98.8399;
MatrixA(37,6) = 0.011174;
MatrixA(37,7) = 0.00654981;
MatrixA(37,8) = -164.86;
MatrixA(37,9) = 11.3586;
MatrixA(37,12) = 213.598;
MatrixA(37,13) = -1.40344;
MatrixA(37,16) = -36.1015;
MatrixA(37,17) = -0.0264319;
MatrixA(37,20) = -35.7957;
MatrixA(37,21) = 0.0252063;
MatrixA(37,24) = -7.80678;
MatrixA(37,26) = -7.79871;
MatrixA(37,28) = -7.5908;
MatrixA(37,30) = -7.59855;
MatrixA(37,32) = -0.00476874;
MatrixA(37,35) = 0.00476874;
MatrixA(37,36) = 0.000173013;
MatrixA(37,37) = -0.0258797;
MatrixA(37,38) = 5.50677e-05;
MatrixA(37,39) = -22.2781;
MatrixA(37,40) = -0.000267315;
MatrixA(37,41) = 0.700914;
MatrixA(37,42) = -1.06305;
MatrixA(37,43) = 0.012428;
MatrixA(37,44) = -0.00369264;
MatrixA(37,45) = 0.0117638;
MatrixA(37,46) = 0.266118;
MatrixA(37,47) = 0.00957139;
MatrixA(37,48) = -0.0200041;
MatrixA(37,49) = 0.012496;
MatrixA(37,52) = -0.000151794;
MatrixA(38,1) = -8.0145;
MatrixA(38,2) = -26.8646;
MatrixA(38,3) = -0.163634;
MatrixA(38,6) = -2.11479e-05;
MatrixA(38,7) = -1.28428e-05;
MatrixA(38,8) = -35.119;
MatrixA(38,9) = 571.347;
MatrixA(38,12) = 68.9675;
MatrixA(38,13) = 400.63;
MatrixA(38,16) = 0.152161;
MatrixA(38,17) = 0.0219688;
MatrixA(38,20) = 0.151633;
MatrixA(38,21) = 0.0208763;
MatrixA(38,24) = -0.377069;
MatrixA(38,26) = -0.37662;
MatrixA(38,28) = -0.379244;
MatrixA(38,30) = -0.379694;
MatrixA(38,32) = 0.000290322;
MatrixA(38,35) = -0.000290322;
MatrixA(38,36) = 0.204102;
MatrixA(38,37) = 6.02966e-07;
MatrixA(38,38) = 0.00655115;
MatrixA(38,39) = 0.00114834;
MatrixA(38,40) = 22.0341;
MatrixA(38,41) = -0.0014293;
MatrixA(38,42) = 0.00284407;
MatrixA(38,43) = 6.84035;
MatrixA(38,44) = 0.00640998;
MatrixA(38,45) = 0.00638014;
MatrixA(38,46) = -0.000484157;
MatrixA(38,47) = 5.47125;
MatrixA(38,48) = -0.0452795;
MatrixA(38,49) = -0.0456806;
MatrixA(38,52) = 9.24123e-06;
MatrixA(39,1) = 0.0331483;
MatrixA(39,2) = 0.0833913;
MatrixA(39,3) = -220.277;
MatrixA(39,6) = 0.00589708;
MatrixA(39,7) = 0.00445991;
MatrixA(39,8) = -76.8369;
MatrixA(39,9) = 4.31984;
MatrixA(39,12) = -201.619;
MatrixA(39,13) = 3.00521;
MatrixA(39,16) = -20.5064;
MatrixA(39,17) = -0.595135;
MatrixA(39,20) = -16.0333;
MatrixA(39,21) = 0.568052;
MatrixA(39,24) = 5.47406;
MatrixA(39,26) = 5.46859;
MatrixA(39,28) = 7.93986;
MatrixA(39,30) = 7.9482;
MatrixA(39,32) = -0.00614503;
MatrixA(39,35) = 0.00614503;
MatrixA(39,36) = -0.00317703;
MatrixA(39,37) = -0.0023634;
MatrixA(39,38) = -9.74348e-05;
MatrixA(39,39) = -1.33018;
MatrixA(39,40) = 0.000146752;
MatrixA(39,41) = -0.121202;
MatrixA(39,42) = -0.456449;
MatrixA(39,43) = 0.00650867;
MatrixA(39,44) = -0.174389;
MatrixA(39,45) = 0.173781;
MatrixA(39,46) = -0.503033;
MatrixA(39,47) = -0.00859733;
MatrixA(39,48) = -0.138171;
MatrixA(39,49) = 0.14083;
MatrixA(39,52) = -0.000195602;
MatrixA(40,1) = -21.4784;
MatrixA(40,2) = -67.384;
MatrixA(40,3) = -0.395384;
MatrixA(40,6) = 6.0856e-06;
MatrixA(40,7) = 8.44317e-06;
MatrixA(40,8) = 16.5951;
MatrixA(40,9) = -271.182;
MatrixA(40,12) = 51.8052;
MatrixA(40,13) = 286.498;
MatrixA(40,16) = -1.0587;
MatrixA(40,17) = -0.275897;
MatrixA(40,20) = -1.05087;
MatrixA(40,21) = -0.261197;
MatrixA(40,24) = -0.97628;
MatrixA(40,26) = -0.975121;
MatrixA(40,28) = -0.976244;
MatrixA(40,30) = -0.977399;
MatrixA(40,32) = -0.0403602;
MatrixA(40,35) = 0.0403602;
MatrixA(40,36) = 0.989145;
MatrixA(40,37) = 5.79463e-05;
MatrixA(40,38) = 0.0317484;
MatrixA(40,39) = 0.00036531;
MatrixA(40,40) = -0.843462;
MatrixA(40,41) = -0.000272258;
MatrixA(40,42) = -0.00115517;
MatrixA(40,43) = -3.2208;
MatrixA(40,44) = -0.0793964;
MatrixA(40,45) = -0.0787214;
MatrixA(40,46) = -0.000847826;
MatrixA(40,47) = 4.16973;
MatrixA(40,48) = -0.112967;
MatrixA(40,49) = -0.113314;
MatrixA(40,52) = -0.00128471;
MatrixA(41,1) = 0.015916;
MatrixA(41,2) = -0.00717007;
MatrixA(41,3) = 115.169;
MatrixA(41,6) = 0.0123394;
MatrixA(41,7) = 0.00713441;
MatrixA(41,8) = 145.361;
MatrixA(41,9) = -35.2265;
MatrixA(41,12) = 516.38;
MatrixA(41,13) = -33.4197;
MatrixA(41,16) = -39.724;
MatrixA(41,17) = 0.0278728;
MatrixA(41,20) = -39.8095;
MatrixA(41,21) = -0.0266344;
MatrixA(41,24) = -8.31289;
MatrixA(41,26) = -8.30431;
MatrixA(41,28) = -8.30798;
MatrixA(41,30) = -8.31649;
MatrixA(41,32) = 0.0595445;
MatrixA(41,35) = -0.0595445;
MatrixA(41,36) = 0.000320832;
MatrixA(41,37) = -0.0179908;
MatrixA(41,38) = 4.48879e-05;
MatrixA(41,39) = 0.05915;
MatrixA(41,40) = -0.000156566;
MatrixA(41,41) = -0.000926772;
MatrixA(41,42) = 3.75912;
MatrixA(41,43) = 0.013718;
MatrixA(41,44) = 0.0104534;
MatrixA(41,45) = -0.00586221;
MatrixA(41,46) = 4.27533;
MatrixA(41,47) = 0.0103812;
MatrixA(41,48) = -0.010571;
MatrixA(41,49) = -0.00191664;
MatrixA(41,52) = 0.00189536;
MatrixA(42,1) = 0.247841;
MatrixA(42,2) = -0.0328447;
MatrixA(42,3) = -11484.5;
MatrixA(42,6) = 0.731462;
MatrixA(42,7) = 0.788343;
MatrixA(42,8) = -17500.4;
MatrixA(42,9) = 903.522;
MatrixA(42,12) = -428.881;
MatrixA(42,13) = 27.4964;
MatrixA(42,16) = -543.473;
MatrixA(42,17) = 2.36024;
MatrixA(42,20) = -559.311;
MatrixA(42,21) = -2.25354;
MatrixA(42,24) = 6.25113;
MatrixA(42,26) = 6.24478;
MatrixA(42,28) = 7.73088;
MatrixA(42,30) = 7.73891;
MatrixA(42,32) = -0.64366;
MatrixA(42,35) = 0.64366;
MatrixA(42,36) = -0.00142432;
MatrixA(42,37) = 0.00159991;
MatrixA(42,38) = -4.87486e-05;
MatrixA(42,39) = 16.1441;
MatrixA(42,40) = 0.0327006;
MatrixA(42,41) = -0.186796;
MatrixA(42,42) = -93.4871;
MatrixA(42,43) = -0.0111648;
MatrixA(42,44) = 0.960243;
MatrixA(42,45) = -0.420783;
MatrixA(42,46) = -3.54994;
MatrixA(42,47) = -0.00895442;
MatrixA(42,48) = -0.309723;
MatrixA(42,49) = -0.145179;
MatrixA(42,52) = -0.0204883;
MatrixA(43,1) = -3792.94;
MatrixA(43,2) = -9.75306;
MatrixA(43,3) = 1.58142;
MatrixA(43,6) = 4.61853e-05;
MatrixA(43,7) = 7.49089e-05;
MatrixA(43,8) = 443.381;
MatrixA(43,9) = -10970.8;
MatrixA(43,12) = -2.57511;
MatrixA(43,13) = -31.0176;
MatrixA(43,16) = 1.50629;
MatrixA(43,17) = 0.415069;
MatrixA(43,20) = 1.50529;
MatrixA(43,21) = 0.39566;
MatrixA(43,24) = -0.872454;
MatrixA(43,26) = -0.871419;
MatrixA(43,28) = -0.876727;
MatrixA(43,30) = -0.877764;
MatrixA(43,32) = -0.0524524;
MatrixA(43,35) = 0.0524524;
MatrixA(43,36) = -0.10591;
MatrixA(43,37) = 7.85525e-05;
MatrixA(43,38) = -0.00339861;
MatrixA(43,39) = 0.00369612;
MatrixA(43,40) = 0.0830148;
MatrixA(43,41) = -0.000411921;
MatrixA(43,42) = -0.022744;
MatrixA(43,43) = -86.2207;
MatrixA(43,44) = 0.12316;
MatrixA(43,45) = 0.122974;
MatrixA(43,46) = -0.00422564;
MatrixA(43,47) = -0.0923058;
MatrixA(43,48) = -0.100082;
MatrixA(43,49) = -0.100888;
MatrixA(43,52) = -0.00166961;
MatrixA(44,1) = 337.546;
MatrixA(44,2) = 60.3651;
MatrixA(44,3) = 273.212;
MatrixA(44,6) = -0.0244274;
MatrixA(44,7) = 0.204679;
MatrixA(44,8) = 256.864;
MatrixA(44,9) = 587.091;
MatrixA(44,12) = -52.1997;
MatrixA(44,13) = -286.492;
MatrixA(44,16) = -1209.09;
MatrixA(44,17) = -325.896;
MatrixA(44,20) = 15.8264;
MatrixA(44,21) = 4.06873;
MatrixA(44,24) = 0.986991;
MatrixA(44,26) = 0.985822;
MatrixA(44,28) = 0.991771;
MatrixA(44,30) = 0.992942;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 238.802;
MatrixA(44,37) = 0.0139304;
MatrixA(44,38) = 7.66456;
MatrixA(44,39) = -214.838;
MatrixA(44,40) = -203.545;
MatrixA(44,41) = 6.90733;
MatrixA(44,42) = 6.90048;
MatrixA(44,43) = 10.9171;
MatrixA(44,44) = -101.017;
MatrixA(44,45) = -2.31717;
MatrixA(44,46) = -0.000139041;
MatrixA(44,47) = -4.16974;
MatrixA(44,48) = 4.0721;
MatrixA(44,49) = 4.07299;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 338.445;
MatrixA(45,2) = 60.3528;
MatrixA(45,3) = -295.29;
MatrixA(45,6) = 0.0141123;
MatrixA(45,7) = -0.204759;
MatrixA(45,8) = -311.637;
MatrixA(45,9) = 587.989;
MatrixA(45,12) = -52.1997;
MatrixA(45,13) = -286.492;
MatrixA(45,16) = 15.8165;
MatrixA(45,17) = 4.2626;
MatrixA(45,20) = -1209.82;
MatrixA(45,21) = -311.066;
MatrixA(45,24) = 0.986991;
MatrixA(45,26) = 0.985822;
MatrixA(45,28) = 0.991771;
MatrixA(45,30) = 0.992942;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 238.75;
MatrixA(45,37) = 0.0139274;
MatrixA(45,38) = 7.66288;
MatrixA(45,39) = 215.136;
MatrixA(45,40) = -202.674;
MatrixA(45,41) = -6.89314;
MatrixA(45,42) = -6.89999;
MatrixA(45,43) = 10.9154;
MatrixA(45,44) = -2.31693;
MatrixA(45,45) = -100.996;
MatrixA(45,46) = -0.000139041;
MatrixA(45,47) = -4.16974;
MatrixA(45,48) = 4.0721;
MatrixA(45,49) = 4.07299;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 0.17884;
MatrixA(46,2) = 0.832626;
MatrixA(46,3) = -27711.2;
MatrixA(46,6) = -0.0140895;
MatrixA(46,7) = -0.00723713;
MatrixA(46,8) = -170.584;
MatrixA(46,9) = 40.7349;
MatrixA(46,12) = -33539.1;
MatrixA(46,13) = 638.271;
MatrixA(46,16) = 44.0396;
MatrixA(46,17) = -0.558785;
MatrixA(46,20) = 48.0447;
MatrixA(46,21) = 0.532879;
MatrixA(46,24) = -263.353;
MatrixA(46,26) = -263.088;
MatrixA(46,28) = -275.038;
MatrixA(46,30) = -275.315;
MatrixA(46,32) = -0.677317;
MatrixA(46,35) = 0.677317;
MatrixA(46,36) = 0.0128666;
MatrixA(46,37) = 0.0302867;
MatrixA(46,38) = 0.000354789;
MatrixA(46,39) = 12.2273;
MatrixA(46,40) = 0.0122832;
MatrixA(46,41) = -0.2055;
MatrixA(46,42) = -4.40553;
MatrixA(46,43) = -0.0155282;
MatrixA(46,44) = -0.404417;
MatrixA(46,45) = -0.0776582;
MatrixA(46,46) = -79.8842;
MatrixA(46,47) = -0.011057;
MatrixA(46,48) = 0.827947;
MatrixA(46,49) = -0.262545;
MatrixA(46,52) = -0.0215597;
MatrixA(47,1) = -6560.89;
MatrixA(47,2) = -22168.4;
MatrixA(47,3) = 9.90854;
MatrixA(47,6) = -3.90423e-06;
MatrixA(47,7) = -3.70887e-06;
MatrixA(47,8) = 0.957879;
MatrixA(47,9) = -15.3895;
MatrixA(47,12) = -853.49;
MatrixA(47,13) = -11581.1;
MatrixA(47,16) = 1.28594;
MatrixA(47,17) = 0.340987;
MatrixA(47,20) = 1.28641;
MatrixA(47,21) = 0.325412;
MatrixA(47,24) = 7.66587;
MatrixA(47,26) = 7.6568;
MatrixA(47,28) = 7.70291;
MatrixA(47,30) = 7.712;
MatrixA(47,32) = 0.081775;
MatrixA(47,35) = -0.081775;
MatrixA(47,36) = -5.00103;
MatrixA(47,37) = -0.000240835;
MatrixA(47,38) = -0.160519;
MatrixA(47,39) = -0.0227519;
MatrixA(47,40) = 4.2543;
MatrixA(47,41) = -0.000132449;
MatrixA(47,42) = -0.00248583;
MatrixA(47,43) = -0.218393;
MatrixA(47,44) = 0.0971304;
MatrixA(47,45) = 0.0970905;
MatrixA(47,46) = 0.0109285;
MatrixA(47,47) = -67.7691;
MatrixA(47,48) = 0.876656;
MatrixA(47,49) = 0.883507;
MatrixA(47,52) = 0.00260298;
MatrixA(48,1) = 1194.92;
MatrixA(48,2) = 4051.95;
MatrixA(48,3) = 1145.45;
MatrixA(48,6) = 5.08933e-06;
MatrixA(48,7) = 8.34359e-09;
MatrixA(48,8) = -16.7406;
MatrixA(48,9) = 271.19;
MatrixA(48,12) = 1094.84;
MatrixA(48,13) = 882.342;
MatrixA(48,16) = 1.01984;
MatrixA(48,17) = 0.274768;
MatrixA(48,20) = 1.02048;
MatrixA(48,21) = 0.262273;
MatrixA(48,24) = -818.62;
MatrixA(48,26) = -817.65;
MatrixA(48,28) = 14.4663;
MatrixA(48,30) = 14.4834;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 236.221;
MatrixA(48,37) = 0.0143658;
MatrixA(48,38) = 7.58209;
MatrixA(48,39) = -232.72;
MatrixA(48,40) = -201.403;
MatrixA(48,41) = 7.48129;
MatrixA(48,42) = 0.000290198;
MatrixA(48,43) = 3.2208;
MatrixA(48,44) = 5.35778;
MatrixA(48,45) = 5.35777;
MatrixA(48,46) = 7.47638;
MatrixA(48,47) = 28.4367;
MatrixA(48,48) = -102.232;
MatrixA(48,49) = -3.06172;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 1186.19;
MatrixA(49,2) = 4021.61;
MatrixA(49,3) = -1150.59;
MatrixA(49,6) = 5.08933e-06;
MatrixA(49,7) = 8.34359e-09;
MatrixA(49,8) = -16.7406;
MatrixA(49,9) = 271.19;
MatrixA(49,12) = -1201.21;
MatrixA(49,13) = 873.646;
MatrixA(49,16) = 1.01984;
MatrixA(49,17) = 0.274768;
MatrixA(49,20) = 1.02048;
MatrixA(49,21) = 0.262273;
MatrixA(49,24) = 14.4011;
MatrixA(49,26) = 14.384;
MatrixA(49,28) = -822.316;
MatrixA(49,30) = -823.287;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 238.057;
MatrixA(49,37) = 0.0144775;
MatrixA(49,38) = 7.64103;
MatrixA(49,39) = 234.803;
MatrixA(49,40) = -202.066;
MatrixA(49,41) = -7.52427;
MatrixA(49,42) = 0.000290198;
MatrixA(49,43) = 3.2208;
MatrixA(49,44) = 5.35778;
MatrixA(49,45) = 5.35777;
MatrixA(49,46) = -7.52922;
MatrixA(49,47) = 28.6891;
MatrixA(49,48) = -3.07423;
MatrixA(49,49) = -102.942;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 0.000667783;
MatrixA(50,2) = 0.000667783;
MatrixA(50,3) = 0.000667783;
MatrixA(50,4) = 0.000667783;
MatrixA(50,5) = 0.000667783;
MatrixA(50,6) = 0.000667783;
MatrixA(50,7) = 0.000667783;
MatrixA(50,8) = 0.000667783;
MatrixA(50,9) = 0.000667783;
MatrixA(50,10) = 0.000667783;
MatrixA(50,11) = 0.000667783;
MatrixA(50,12) = 0.000667783;
MatrixA(50,13) = 0.000667783;
MatrixA(50,14) = 0.000667783;
MatrixA(50,15) = 0.000667783;
MatrixA(50,16) = 0.000667783;
MatrixA(50,17) = 0.000667783;
MatrixA(50,18) = 0.000667783;
MatrixA(50,19) = 0.000667783;
MatrixA(50,20) = 0.000667783;
MatrixA(50,21) = 0.000667783;
MatrixA(50,22) = 0.000667783;
MatrixA(50,23) = 0.000667783;
MatrixA(50,24) = 0.000667783;
MatrixA(50,25) = 0.000667783;
MatrixA(50,26) = 0.000667783;
MatrixA(50,27) = 0.000667783;
MatrixA(50,28) = 0.000667783;
MatrixA(50,29) = 0.000667783;
MatrixA(50,30) = 0.000667783;
MatrixA(50,31) = 0.000667783;
MatrixA(50,32) = 0.000667783;
MatrixA(50,33) = 0.000667783;
MatrixA(50,34) = 0.000667783;
MatrixA(50,35) = 0.000667783;
MatrixA(50,36) = -1274.12;
MatrixA(50,37) = 0.000667783;
MatrixA(50,38) = -40.922;
MatrixA(50,39) = 0.000667783;
MatrixA(50,40) = 0.000667783;
MatrixA(50,41) = 0.000667783;
MatrixA(50,42) = 0.000667783;
MatrixA(50,43) = 0.000667783;
MatrixA(50,44) = 0.000667783;
MatrixA(50,45) = 0.0873158;
MatrixA(50,46) = 0.0873158;
MatrixA(50,47) = 0.000667783;
MatrixA(50,48) = 0.000667783;
MatrixA(50,49) = 0.0873158;
MatrixA(50,50) = -4.60498;
MatrixA(50,51) = 0.000667783;
MatrixA(50,52) = 3.19692;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 71.8753;
MatrixA(51,52) = -101.106;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 117.828;
MatrixA(52,52) = -165.747;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 0.000667783;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0348146;
MatrixC(2,2) = 0.101907;
MatrixC(2,3) = -2.95781;
MatrixC(2,6) = 0.00530899;
MatrixC(2,7) = -3.2461e-13;
MatrixC(2,8) = -1.82562;
MatrixC(2,9) = 0.00580236;
MatrixC(2,12) = -1.10191;
MatrixC(2,13) = 0.0288955;
MatrixC(2,16) = -32.3728;
MatrixC(2,17) = -1.04998e-05;
MatrixC(2,20) = -32.2741;
MatrixC(2,21) = -1.00163e-05;
MatrixC(2,24) = -11.0516;
MatrixC(2,26) = -11.0402;
MatrixC(2,28) = -11.1449;
MatrixC(2,30) = -11.1562;
MatrixC(2,32) = -1.46367e-15;
MatrixC(2,35) = 1.57209e-15;
MatrixC(2,36) = 1.58695e-05;
MatrixC(2,37) = -0.026763;
MatrixC(2,38) = 5.19631e-05;
MatrixC(2,39) = 0.00219548;
MatrixC(2,40) = -1.611e-05;
MatrixC(2,41) = -0.00194828;
MatrixC(2,42) = 0.000225572;
MatrixC(2,43) = 4.10671e-07;
MatrixC(2,44) = -3.06258e-06;
MatrixC(2,45) = -3.06085e-06;
MatrixC(2,46) = -0.000217349;
MatrixC(2,47) = 1.19389e-06;
MatrixC(2,48) = -1.75745e-06;
MatrixC(2,49) = -1.77117e-06;

MatrixD = zeros(2, 1);
