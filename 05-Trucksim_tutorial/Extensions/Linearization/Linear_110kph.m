% MATLAB linearized TruckSim 2023.0 model, calculated at t = 240.015 s.
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

MatrixA(1,2) = -30.5561;
MatrixA(1,3) = -0.000327184;
MatrixA(1,36) = -0.0322726;
MatrixA(1,37) = 0.00148144;
MatrixA(1,38) = 0.999478;
MatrixA(1,39) = 0.00191106;
MatrixA(1,40) = -1.26189;
MatrixA(1,41) = 0.00125923;
MatrixA(2,3) = 2.31031e-05;
MatrixA(2,39) = -0.00148221;
MatrixA(2,40) = 0.999999;
MatrixA(3,2) = -2.3128e-05;
MatrixA(3,3) = 6.18209e-09;
MatrixA(3,39) = 0.0322893;
MatrixA(3,40) = 4.78598e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238012;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = -1.00955e-06;
MatrixA(16,2) = -0.000780068;
MatrixA(16,3) = 2.34371e-07;
MatrixA(16,6) = -2.54879;
MatrixA(16,7) = -0.000834947;
MatrixA(16,8) = 1.44061;
MatrixA(16,9) = -2.10816e-06;
MatrixA(16,16) = -43.1935;
MatrixA(16,36) = -7.63481e-06;
MatrixA(16,37) = 1.41105;
MatrixA(16,38) = -0.00209173;
MatrixA(16,39) = 1.83766;
MatrixA(16,40) = 0.00273031;
MatrixA(16,41) = 1.14152;
MatrixA(16,42) = 0.467033;
MatrixA(16,43) = 2.49582e-05;
MatrixA(20,1) = -1.01201e-06;
MatrixA(20,2) = -0.000781009;
MatrixA(20,3) = 1.8516e-06;
MatrixA(20,6) = -2.5518;
MatrixA(20,7) = -0.000836026;
MatrixA(20,8) = 1.34801;
MatrixA(20,9) = -2.11203e-06;
MatrixA(20,20) = -43.2456;
MatrixA(20,36) = -7.64404e-06;
MatrixA(20,37) = 1.41276;
MatrixA(20,38) = -0.00209426;
MatrixA(20,39) = 1.83987;
MatrixA(20,40) = 0.00273359;
MatrixA(20,41) = 1.1429;
MatrixA(20,42) = 0.467597;
MatrixA(20,43) = 2.49884e-05;
MatrixA(24,1) = -3.05427e-07;
MatrixA(24,2) = 0.00264368;
MatrixA(24,3) = 1.16688e-06;
MatrixA(24,12) = 3.48978;
MatrixA(24,13) = -1.17457e-05;
MatrixA(24,24) = -99.0322;
MatrixA(24,36) = -2.57977e-05;
MatrixA(24,37) = 3.23517;
MatrixA(24,38) = -0.00479605;
MatrixA(24,39) = -6.75215;
MatrixA(24,40) = -0.00998618;
MatrixA(24,41) = 2.97126;
MatrixA(24,46) = 1.58632;
MatrixA(24,47) = -5.96896e-05;
MatrixA(26,1) = -3.05591e-07;
MatrixA(26,2) = 0.00264594;
MatrixA(26,3) = 1.12485e-06;
MatrixA(26,12) = 3.6145;
MatrixA(26,13) = -1.17528e-05;
MatrixA(26,26) = -99.0853;
MatrixA(26,36) = -2.58115e-05;
MatrixA(26,37) = 3.2369;
MatrixA(26,38) = -0.00479862;
MatrixA(26,39) = -6.75576;
MatrixA(26,40) = -0.00999152;
MatrixA(26,41) = 2.97285;
MatrixA(26,46) = 1.58717;
MatrixA(26,47) = -5.97215e-05;
MatrixA(28,1) = -3.0452e-07;
MatrixA(28,2) = 0.00263121;
MatrixA(28,3) = 1.35518e-06;
MatrixA(28,12) = 2.93158;
MatrixA(28,13) = -1.17067e-05;
MatrixA(28,28) = -98.7387;
MatrixA(28,36) = -2.57213e-05;
MatrixA(28,37) = 3.22559;
MatrixA(28,38) = -0.00478184;
MatrixA(28,39) = -6.73219;
MatrixA(28,40) = -0.00995666;
MatrixA(28,41) = 2.96246;
MatrixA(28,46) = 1.58163;
MatrixA(28,47) = -5.95127e-05;
MatrixA(30,1) = -3.04357e-07;
MatrixA(30,2) = 0.00262898;
MatrixA(30,3) = 1.38273e-06;
MatrixA(30,12) = 2.85002;
MatrixA(30,13) = -1.16997e-05;
MatrixA(30,30) = -98.686;
MatrixA(30,36) = -2.57076e-05;
MatrixA(30,37) = 3.22387;
MatrixA(30,38) = -0.00477929;
MatrixA(30,39) = -6.72861;
MatrixA(30,40) = -0.00995136;
MatrixA(30,41) = 2.96088;
MatrixA(30,46) = 1.58078;
MatrixA(30,47) = -5.9481e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 70.2813;
MatrixA(36,2) = 220.165;
MatrixA(36,3) = -0.0283881;
MatrixA(36,6) = 8.09024e-05;
MatrixA(36,7) = -4.17111e-07;
MatrixA(36,8) = 0.718966;
MatrixA(36,9) = -14.9776;
MatrixA(36,12) = 8.36827;
MatrixA(36,13) = 128.909;
MatrixA(36,16) = 8.48055;
MatrixA(36,20) = 8.46823;
MatrixA(36,24) = 3.20123;
MatrixA(36,26) = 3.19908;
MatrixA(36,28) = 3.22173;
MatrixA(36,30) = 3.22388;
MatrixA(36,32) = -0.00367019;
MatrixA(36,35) = 0.00367019;
MatrixA(36,36) = -3.59404;
MatrixA(36,37) = -0.000194025;
MatrixA(36,38) = -0.116053;
MatrixA(36,39) = -0.00241144;
MatrixA(36,40) = 2.06452;
MatrixA(36,41) = -3.22474e-05;
MatrixA(36,42) = -9.06745e-05;
MatrixA(36,43) = -0.30247;
MatrixA(36,44) = 0.417581;
MatrixA(36,45) = 0.416977;
MatrixA(36,46) = -2.04562e-05;
MatrixA(36,47) = 0.698169;
MatrixA(36,48) = 0.285906;
MatrixA(36,49) = 0.287275;
MatrixA(36,52) = -0.000116826;
MatrixA(37,1) = 0.0298153;
MatrixA(37,2) = 0.0483799;
MatrixA(37,3) = 100.55;
MatrixA(37,6) = 0.0135446;
MatrixA(37,7) = 0.00900022;
MatrixA(37,8) = -167.002;
MatrixA(37,9) = 6.97693;
MatrixA(37,12) = 216.15;
MatrixA(37,13) = -0.907516;
MatrixA(37,16) = -32.1114;
MatrixA(37,20) = -31.8152;
MatrixA(37,24) = -6.98142;
MatrixA(37,26) = -6.97682;
MatrixA(37,28) = -6.7493;
MatrixA(37,30) = -6.75373;
MatrixA(37,32) = -0.00473593;
MatrixA(37,35) = 0.00473593;
MatrixA(37,36) = 0.000163611;
MatrixA(37,37) = -0.0355991;
MatrixA(37,38) = 5.80322e-05;
MatrixA(37,39) = -30.5718;
MatrixA(37,40) = -0.000162398;
MatrixA(37,41) = 0.967718;
MatrixA(37,42) = -1.06652;
MatrixA(37,43) = 0.00953321;
MatrixA(37,44) = -0.00185572;
MatrixA(37,45) = 0.0099506;
MatrixA(37,46) = 0.267614;
MatrixA(37,47) = 0.00740258;
MatrixA(37,48) = -0.0156679;
MatrixA(37,49) = 0.00813638;
MatrixA(37,52) = -0.000150749;
MatrixA(38,1) = -7.32423;
MatrixA(38,2) = -24.4441;
MatrixA(38,3) = -0.128646;
MatrixA(38,6) = -1.94539e-05;
MatrixA(38,7) = -1.35535e-05;
MatrixA(38,8) = -18.95;
MatrixA(38,9) = 603.394;
MatrixA(38,12) = 50.6743;
MatrixA(38,13) = 373.807;
MatrixA(38,16) = 0.147281;
MatrixA(38,20) = 0.146695;
MatrixA(38,24) = -0.355675;
MatrixA(38,26) = -0.355436;
MatrixA(38,28) = -0.358333;
MatrixA(38,30) = -0.358573;
MatrixA(38,32) = 0.000283275;
MatrixA(38,35) = -0.000283275;
MatrixA(38,36) = 0.1492;
MatrixA(38,37) = -5.78089e-06;
MatrixA(38,38) = 0.00481772;
MatrixA(38,39) = 0.000545525;
MatrixA(38,40) = 30.4188;
MatrixA(38,41) = -0.00164438;
MatrixA(38,42) = 0.0021887;
MatrixA(38,43) = 6.84043;
MatrixA(38,44) = 0.00486423;
MatrixA(38,45) = 0.0048396;
MatrixA(38,46) = -0.000376809;
MatrixA(38,47) = 5.46433;
MatrixA(38,48) = -0.0326541;
MatrixA(38,49) = -0.0328433;
MatrixA(38,52) = 9.01693e-06;
MatrixA(39,1) = 0.0150295;
MatrixA(39,2) = 0.0209161;
MatrixA(39,3) = -219.719;
MatrixA(39,6) = 0.00711704;
MatrixA(39,7) = 0.00569476;
MatrixA(39,8) = -77.1628;
MatrixA(39,9) = 2.68693;
MatrixA(39,12) = -202.572;
MatrixA(39,13) = 1.98593;
MatrixA(39,16) = -18.9843;
MatrixA(39,20) = -13.5095;
MatrixA(39,24) = 4.82583;
MatrixA(39,26) = 4.82265;
MatrixA(39,28) = 7.13845;
MatrixA(39,30) = 7.14316;
MatrixA(39,32) = -0.00619582;
MatrixA(39,35) = 0.00619582;
MatrixA(39,36) = -0.00105302;
MatrixA(39,37) = -0.00324906;
MatrixA(39,38) = -2.91866e-05;
MatrixA(39,39) = -0.924247;
MatrixA(39,40) = -0.000473432;
MatrixA(39,41) = -0.195693;
MatrixA(39,42) = -0.498376;
MatrixA(39,43) = 0.00500662;
MatrixA(39,44) = -0.13441;
MatrixA(39,45) = 0.133617;
MatrixA(39,46) = -0.539575;
MatrixA(39,47) = -0.00651502;
MatrixA(39,48) = -0.100795;
MatrixA(39,49) = 0.102812;
MatrixA(39,52) = -0.000197219;
MatrixA(40,1) = -19.6404;
MatrixA(40,2) = -62.0023;
MatrixA(40,3) = -0.298187;
MatrixA(40,6) = -4.81237e-07;
MatrixA(40,7) = 8.51365e-06;
MatrixA(40,8) = 8.9586;
MatrixA(40,9) = -286.083;
MatrixA(40,12) = 38.0795;
MatrixA(40,13) = 267.505;
MatrixA(40,16) = -1.28666;
MatrixA(40,20) = -1.27683;
MatrixA(40,24) = -0.924324;
MatrixA(40,26) = -0.923704;
MatrixA(40,28) = -0.926965;
MatrixA(40,30) = -0.927585;
MatrixA(40,32) = -0.0403622;
MatrixA(40,35) = 0.0403622;
MatrixA(40,36) = 0.736115;
MatrixA(40,37) = 3.33964e-05;
MatrixA(40,38) = 0.0237694;
MatrixA(40,39) = -0.000121054;
MatrixA(40,40) = -0.62928;
MatrixA(40,41) = -0.000296901;
MatrixA(40,42) = -0.000939292;
MatrixA(40,43) = -3.22381;
MatrixA(40,44) = -0.0608267;
MatrixA(40,45) = -0.0603451;
MatrixA(40,46) = -0.000690815;
MatrixA(40,47) = 4.15059;
MatrixA(40,48) = -0.081955;
MatrixA(40,49) = -0.0820608;
MatrixA(40,52) = -0.00128477;
MatrixA(41,1) = 0.0338567;
MatrixA(41,2) = 0.0554089;
MatrixA(41,3) = 116.816;
MatrixA(41,6) = 0.0149602;
MatrixA(41,7) = 0.00984609;
MatrixA(41,8) = 152.796;
MatrixA(41,9) = -20.6541;
MatrixA(41,12) = 526.419;
MatrixA(41,13) = -22.2963;
MatrixA(41,16) = -35.2603;
MatrixA(41,20) = -35.4553;
MatrixA(41,24) = -7.42808;
MatrixA(41,26) = -7.42318;
MatrixA(41,28) = -7.39378;
MatrixA(41,30) = -7.39864;
MatrixA(41,32) = 0.0595812;
MatrixA(41,35) = -0.0595812;
MatrixA(41,36) = 0.000170851;
MatrixA(41,37) = -0.0247484;
MatrixA(41,38) = 4.21999e-05;
MatrixA(41,39) = 0.072134;
MatrixA(41,40) = -3.75633e-05;
MatrixA(41,41) = -0.000983917;
MatrixA(41,42) = 3.75918;
MatrixA(41,43) = 0.0105213;
MatrixA(41,44) = 0.00864767;
MatrixA(41,45) = -0.00401466;
MatrixA(41,46) = 4.28;
MatrixA(41,47) = 0.0080199;
MatrixA(41,48) = -0.00943908;
MatrixA(41,49) = -0.00303625;
MatrixA(41,52) = 0.00189653;
MatrixA(42,1) = 0.235586;
MatrixA(42,2) = -0.0653764;
MatrixA(42,3) = -11486.8;
MatrixA(42,6) = 0.770903;
MatrixA(42,7) = 1.08663;
MatrixA(42,8) = -17688.3;
MatrixA(42,9) = 536.248;
MatrixA(42,12) = -436.186;
MatrixA(42,13) = 18.3426;
MatrixA(42,16) = -479.923;
MatrixA(42,20) = -500.808;
MatrixA(42,24) = 5.54527;
MatrixA(42,26) = 5.54162;
MatrixA(42,28) = 6.92343;
MatrixA(42,30) = 6.92799;
MatrixA(42,32) = -0.643639;
MatrixA(42,35) = 0.643639;
MatrixA(42,36) = -0.00239296;
MatrixA(42,37) = 0.00218771;
MatrixA(42,38) = -8.05071e-05;
MatrixA(42,39) = 20.6274;
MatrixA(42,40) = 0.0329536;
MatrixA(42,41) = -0.206555;
MatrixA(42,42) = -93.4809;
MatrixA(42,43) = -0.00861904;
MatrixA(42,44) = 0.805182;
MatrixA(42,45) = -0.265188;
MatrixA(42,46) = -3.57311;
MatrixA(42,47) = -0.00685393;
MatrixA(42,48) = -0.287594;
MatrixA(42,49) = -0.167463;
MatrixA(42,52) = -0.0204877;
MatrixA(43,1) = -3792;
MatrixA(43,2) = -4.40916;
MatrixA(43,3) = 1.22515;
MatrixA(43,6) = 6.81308e-05;
MatrixA(43,7) = 7.88976e-05;
MatrixA(43,8) = 239.042;
MatrixA(43,9) = -11375.3;
MatrixA(43,12) = -1.89615;
MatrixA(43,13) = -28.7107;
MatrixA(43,16) = 1.90295;
MatrixA(43,20) = 1.89813;
MatrixA(43,24) = -0.829801;
MatrixA(43,26) = -0.829244;
MatrixA(43,28) = -0.835288;
MatrixA(43,30) = -0.835846;
MatrixA(43,32) = -0.0524253;
MatrixA(43,35) = 0.0524253;
MatrixA(43,36) = -0.112285;
MatrixA(43,37) = 8.27189e-05;
MatrixA(43,38) = -0.00362583;
MatrixA(43,39) = 0.0028397;
MatrixA(43,40) = 0.0860067;
MatrixA(43,41) = -0.000382115;
MatrixA(43,42) = -0.0174478;
MatrixA(43,43) = -86.2164;
MatrixA(43,44) = 0.0963654;
MatrixA(43,45) = 0.0961273;
MatrixA(43,46) = -0.00322465;
MatrixA(43,47) = -0.110069;
MatrixA(43,48) = -0.0728653;
MatrixA(43,49) = -0.0732374;
MatrixA(43,52) = -0.00166875;
MatrixA(44,1) = 510.029;
MatrixA(44,2) = 52.3797;
MatrixA(44,3) = 433.92;
MatrixA(44,6) = -0.0353114;
MatrixA(44,7) = 0.158114;
MatrixA(44,8) = 425.295;
MatrixA(44,9) = 776.219;
MatrixA(44,12) = -38.3834;
MatrixA(44,13) = -267.501;
MatrixA(44,16) = -1492.36;
MatrixA(44,20) = 19.491;
MatrixA(44,24) = 0.931565;
MatrixA(44,26) = 0.930939;
MatrixA(44,28) = 0.937672;
MatrixA(44,30) = 0.938299;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 184.076;
MatrixA(44,37) = 0.00867359;
MatrixA(44,38) = 5.94389;
MatrixA(44,39) = -165.616;
MatrixA(44,40) = -156.907;
MatrixA(44,41) = 5.35487;
MatrixA(44,42) = 5.35055;
MatrixA(44,43) = 9.19148;
MatrixA(44,44) = -79.1215;
MatrixA(44,45) = -2.60373;
MatrixA(44,46) = -0.000119463;
MatrixA(44,47) = -4.1506;
MatrixA(44,48) = 4.04022;
MatrixA(44,49) = 4.04063;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 510.781;
MatrixA(45,2) = 52.3732;
MatrixA(45,3) = -446.388;
MatrixA(45,6) = 0.0240294;
MatrixA(45,7) = -0.157932;
MatrixA(45,8) = -455.012;
MatrixA(45,9) = 776.97;
MatrixA(45,12) = -38.3834;
MatrixA(45,13) = -267.501;
MatrixA(45,16) = 19.5204;
MatrixA(45,20) = -1490.09;
MatrixA(45,24) = 0.931565;
MatrixA(45,26) = 0.930939;
MatrixA(45,28) = 0.937672;
MatrixA(45,30) = 0.938299;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 183.79;
MatrixA(45,37) = 0.00866009;
MatrixA(45,38) = 5.93464;
MatrixA(45,39) = 165.566;
MatrixA(45,40) = -156.173;
MatrixA(45,41) = -5.33881;
MatrixA(45,42) = -5.34311;
MatrixA(45,43) = 9.18223;
MatrixA(45,44) = -2.60229;
MatrixA(45,45) = -79.0102;
MatrixA(45,46) = -0.000119463;
MatrixA(45,47) = -4.1506;
MatrixA(45,48) = 4.04022;
MatrixA(45,49) = 4.04063;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 0.651783;
MatrixA(46,2) = 2.47836;
MatrixA(46,3) = -27702.7;
MatrixA(46,6) = -0.0171272;
MatrixA(46,7) = -0.0103904;
MatrixA(46,8) = -178.969;
MatrixA(46,9) = 23.9156;
MatrixA(46,12) = -33677.6;
MatrixA(46,13) = 426.776;
MatrixA(46,16) = 38.4385;
MatrixA(46,20) = 43.5198;
MatrixA(46,24) = -235.754;
MatrixA(46,26) = -235.602;
MatrixA(46,28) = -245.943;
MatrixA(46,30) = -246.101;
MatrixA(46,32) = -0.677093;
MatrixA(46,35) = 0.677093;
MatrixA(46,36) = 0.00674429;
MatrixA(46,37) = 0.0417983;
MatrixA(46,38) = 0.000155829;
MatrixA(46,39) = 15.5656;
MatrixA(46,40) = 0.0170954;
MatrixA(46,41) = -0.244397;
MatrixA(46,42) = -4.44741;
MatrixA(46,43) = -0.0119112;
MatrixA(46,44) = -0.367727;
MatrixA(46,45) = -0.114101;
MatrixA(46,46) = -79.855;
MatrixA(46,47) = -0.00904787;
MatrixA(46,48) = 0.683759;
MatrixA(46,49) = -0.116226;
MatrixA(46,52) = -0.0215525;
MatrixA(47,1) = -6573.93;
MatrixA(47,2) = -22211.6;
MatrixA(47,3) = 7.58396;
MatrixA(47,6) = 6.94738e-06;
MatrixA(47,7) = -4.22797e-06;
MatrixA(47,8) = 0.483272;
MatrixA(47,9) = -16.4756;
MatrixA(47,12) = -627.552;
MatrixA(47,13) = -11254.3;
MatrixA(47,16) = 1.59212;
MatrixA(47,20) = 1.58962;
MatrixA(47,24) = 7.18935;
MatrixA(47,26) = 7.18453;
MatrixA(47,28) = 7.23644;
MatrixA(47,30) = 7.24128;
MatrixA(47,32) = 0.0818221;
MatrixA(47,35) = -0.0818221;
MatrixA(47,36) = -3.65316;
MatrixA(47,37) = -0.000106593;
MatrixA(47,38) = -0.117962;
MatrixA(47,39) = -0.0119176;
MatrixA(47,40) = 3.10933;
MatrixA(47,41) = -0.000379305;
MatrixA(47,42) = -0.00192943;
MatrixA(47,43) = -0.212483;
MatrixA(47,44) = 0.0750107;
MatrixA(47,45) = 0.0748894;
MatrixA(47,46) = 0.00836027;
MatrixA(47,47) = -67.6254;
MatrixA(47,48) = 0.635471;
MatrixA(47,49) = 0.638627;
MatrixA(47,52) = 0.00260448;
MatrixA(48,1) = 1788.87;
MatrixA(48,2) = 6074.81;
MatrixA(48,3) = 1731.45;
MatrixA(48,6) = 1.09066e-05;
MatrixA(48,7) = -1.71677e-07;
MatrixA(48,8) = -9.07163;
MatrixA(48,9) = 286.086;
MatrixA(48,12) = 1694.94;
MatrixA(48,13) = 1494.83;
MatrixA(48,16) = 1.25885;
MatrixA(48,20) = 1.25704;
MatrixA(48,24) = -775.007;
MatrixA(48,26) = -774.486;
MatrixA(48,28) = 13.7176;
MatrixA(48,30) = 13.7267;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 172.791;
MatrixA(48,37) = 0.0081698;
MatrixA(48,38) = 5.5795;
MatrixA(48,39) = -170.259;
MatrixA(48,40) = -147.31;
MatrixA(48,41) = 5.50434;
MatrixA(48,42) = 0.000209245;
MatrixA(48,43) = 3.22381;
MatrixA(48,44) = 5.33805;
MatrixA(48,45) = 5.33796;
MatrixA(48,46) = 5.50153;
MatrixA(48,47) = 19.4773;
MatrixA(48,48) = -76.772;
MatrixA(48,49) = -3.51523;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 1780.66;
MatrixA(49,2) = 6046.18;
MatrixA(49,3) = -1733.38;
MatrixA(49,6) = 1.09066e-05;
MatrixA(49,7) = -1.71677e-07;
MatrixA(49,8) = -9.07163;
MatrixA(49,9) = 286.086;
MatrixA(49,12) = -1769.9;
MatrixA(49,13) = 1486.65;
MatrixA(49,16) = 1.25885;
MatrixA(49,20) = 1.25704;
MatrixA(49,24) = 13.6311;
MatrixA(49,26) = 13.622;
MatrixA(49,28) = -779.915;
MatrixA(49,30) = -780.436;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 173.636;
MatrixA(49,37) = 0.00820976;
MatrixA(49,38) = 5.60677;
MatrixA(49,39) = 171.256;
MatrixA(49,40) = -147.523;
MatrixA(49,41) = -5.52294;
MatrixA(49,42) = 0.000209245;
MatrixA(49,43) = 3.22381;
MatrixA(49,44) = 5.33805;
MatrixA(49,45) = 5.33796;
MatrixA(49,46) = -5.52576;
MatrixA(49,47) = 19.5923;
MatrixA(49,48) = -3.52099;
MatrixA(49,49) = -77.0987;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 9.53843e-05;
MatrixA(50,2) = 9.53843e-05;
MatrixA(50,3) = 9.53843e-05;
MatrixA(50,4) = 9.53843e-05;
MatrixA(50,5) = 9.53843e-05;
MatrixA(50,6) = 9.53843e-05;
MatrixA(50,7) = 9.53843e-05;
MatrixA(50,8) = 9.53843e-05;
MatrixA(50,9) = 9.53843e-05;
MatrixA(50,10) = 9.53843e-05;
MatrixA(50,11) = 9.53843e-05;
MatrixA(50,12) = 9.53843e-05;
MatrixA(50,13) = 9.53843e-05;
MatrixA(50,14) = 9.53843e-05;
MatrixA(50,15) = 9.53843e-05;
MatrixA(50,16) = 9.53843e-05;
MatrixA(50,17) = 9.53843e-05;
MatrixA(50,18) = 9.53843e-05;
MatrixA(50,19) = 9.53843e-05;
MatrixA(50,20) = 9.53843e-05;
MatrixA(50,21) = 9.53843e-05;
MatrixA(50,22) = 9.53843e-05;
MatrixA(50,23) = 9.53843e-05;
MatrixA(50,24) = 9.53843e-05;
MatrixA(50,25) = 9.53843e-05;
MatrixA(50,26) = 9.53843e-05;
MatrixA(50,27) = 9.53843e-05;
MatrixA(50,28) = 9.53843e-05;
MatrixA(50,29) = 9.53843e-05;
MatrixA(50,30) = 9.53843e-05;
MatrixA(50,31) = 9.53843e-05;
MatrixA(50,32) = 9.53843e-05;
MatrixA(50,33) = 9.53843e-05;
MatrixA(50,34) = 9.53843e-05;
MatrixA(50,35) = 9.53843e-05;
MatrixA(50,36) = -1525.08;
MatrixA(50,37) = 9.53843e-05;
MatrixA(50,38) = -49.2686;
MatrixA(50,39) = 9.53843e-05;
MatrixA(50,40) = 9.53843e-05;
MatrixA(50,41) = 9.53843e-05;
MatrixA(50,42) = 9.53843e-05;
MatrixA(50,43) = 9.53843e-05;
MatrixA(50,44) = 9.53843e-05;
MatrixA(50,45) = -0.16786;
MatrixA(50,46) = -0.16786;
MatrixA(50,47) = 9.53843e-05;
MatrixA(50,48) = 9.53843e-05;
MatrixA(50,49) = -0.16786;
MatrixA(50,50) = -5.62561;
MatrixA(50,51) = 9.53843e-05;
MatrixA(50,52) = 4.76081;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 93.1864;
MatrixA(51,52) = -113.577;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 152.765;
MatrixA(52,52) = -186.192;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 9.53843e-05;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0522878;
MatrixC(2,2) = 0.148418;
MatrixC(2,3) = -2.96656;
MatrixC(2,6) = 0.00740815;
MatrixC(2,7) = 8.34012e-12;
MatrixC(2,8) = -1.80224;
MatrixC(2,9) = 0.0102324;
MatrixC(2,12) = -1.10759;
MatrixC(2,13) = 0.0418861;
MatrixC(2,16) = -28.7602;
MatrixC(2,20) = -28.7096;
MatrixC(2,24) = -9.896;
MatrixC(2,26) = -9.8895;
MatrixC(2,28) = -9.9462;
MatrixC(2,30) = -9.95271;
MatrixC(2,32) = -2.1684e-16;
MatrixC(2,35) = 4.33681e-16;
MatrixC(2,36) = 9.4109e-06;
MatrixC(2,37) = -0.0368118;
MatrixC(2,38) = 5.48675e-05;
MatrixC(2,39) = 0.00302012;
MatrixC(2,40) = -1.07713e-05;
MatrixC(2,41) = -0.00268219;
MatrixC(2,42) = 0.000310493;
MatrixC(2,43) = 2.42133e-07;
MatrixC(2,44) = -1.91797e-06;
MatrixC(2,45) = -1.91344e-06;
MatrixC(2,46) = -0.000301563;
MatrixC(2,47) = 1.16019e-06;
MatrixC(2,48) = -1.74468e-06;
MatrixC(2,49) = -1.75476e-06;
MatrixC(2,52) = 1.0842e-16;

MatrixD = zeros(2, 1);
