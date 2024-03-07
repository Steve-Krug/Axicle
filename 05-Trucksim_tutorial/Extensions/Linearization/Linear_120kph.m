% MATLAB linearized TruckSim 2023.0 model, calculated at t = 260.017 s.
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

MatrixA(1,2) = -33.3337;
MatrixA(1,3) = -0.000286581;
MatrixA(1,36) = -0.0322739;
MatrixA(1,37) = 0.00139664;
MatrixA(1,38) = 0.999478;
MatrixA(1,39) = 0.00180166;
MatrixA(1,40) = -1.26189;
MatrixA(1,41) = 0.00118714;
MatrixA(2,3) = 2.56565e-05;
MatrixA(2,39) = -0.00139737;
MatrixA(2,40) = 0.999999;
MatrixA(3,2) = -2.56846e-05;
MatrixA(3,3) = 3.43817e-08;
MatrixA(3,39) = 0.0322907;
MatrixA(3,40) = 4.5122e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -237999;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 1.64588e-06;
MatrixA(16,2) = -0.000231429;
MatrixA(16,3) = 6.01049e-06;
MatrixA(16,6) = -2.7913;
MatrixA(16,7) = -0.000838402;
MatrixA(16,8) = 1.57809;
MatrixA(16,9) = 4.18288e-07;
MatrixA(16,16) = -47.3034;
MatrixA(16,36) = -1.06525e-05;
MatrixA(16,37) = 1.41655;
MatrixA(16,38) = -0.00197978;
MatrixA(16,39) = 1.84482;
MatrixA(16,40) = 0.00258696;
MatrixA(16,41) = 1.14625;
MatrixA(16,42) = 0.469141;
MatrixA(16,43) = 6.18342e-06;
MatrixA(20,1) = 1.64736e-06;
MatrixA(20,2) = -0.000231501;
MatrixA(20,3) = 2.97815e-06;
MatrixA(20,6) = -2.7921;
MatrixA(20,7) = -0.000838665;
MatrixA(20,8) = 1.47478;
MatrixA(20,9) = 4.19361e-07;
MatrixA(20,20) = -47.3181;
MatrixA(20,36) = -1.06559e-05;
MatrixA(20,37) = 1.41699;
MatrixA(20,38) = -0.0019804;
MatrixA(20,39) = 1.84538;
MatrixA(20,40) = 0.00258775;
MatrixA(20,41) = 1.14661;
MatrixA(20,42) = 0.469289;
MatrixA(20,43) = 6.18536e-06;
MatrixA(24,1) = 6.85448e-07;
MatrixA(24,2) = 0.00173176;
MatrixA(24,3) = 1.90743e-06;
MatrixA(24,12) = 3.79958;
MatrixA(24,13) = -1.19632e-05;
MatrixA(24,24) = -107.839;
MatrixA(24,36) = -3.27162e-05;
MatrixA(24,37) = 3.22931;
MatrixA(24,38) = -0.00451359;
MatrixA(24,39) = -6.73997;
MatrixA(24,40) = -0.00939037;
MatrixA(24,41) = 2.96656;
MatrixA(24,46) = 1.58413;
MatrixA(24,47) = -3.9751e-05;
MatrixA(26,1) = 6.85766e-07;
MatrixA(26,2) = 0.00172987;
MatrixA(26,3) = 2.1827e-06;
MatrixA(26,12) = 3.93419;
MatrixA(26,13) = -1.19677e-05;
MatrixA(26,26) = -107.875;
MatrixA(26,36) = -3.27272e-05;
MatrixA(26,37) = 3.2304;
MatrixA(26,38) = -0.00451511;
MatrixA(26,39) = -6.74223;
MatrixA(26,40) = -0.00939352;
MatrixA(26,41) = 2.96756;
MatrixA(26,46) = 1.58466;
MatrixA(26,47) = -3.97644e-05;
MatrixA(28,1) = 6.83685e-07;
MatrixA(28,2) = 0.00174225;
MatrixA(28,3) = 6.73757e-07;
MatrixA(28,12) = 3.1961;
MatrixA(28,13) = -1.19384e-05;
MatrixA(28,28) = -107.638;
MatrixA(28,36) = -3.26552e-05;
MatrixA(28,37) = 3.22329;
MatrixA(28,38) = -0.00450518;
MatrixA(28,39) = -6.72746;
MatrixA(28,40) = -0.00937294;
MatrixA(28,41) = 2.96103;
MatrixA(28,46) = 1.58118;
MatrixA(28,47) = -3.96769e-05;
MatrixA(30,1) = 6.83368e-07;
MatrixA(30,2) = 0.00174414;
MatrixA(30,3) = 4.93291e-07;
MatrixA(30,12) = 3.10779;
MatrixA(30,13) = -1.1934e-05;
MatrixA(30,30) = -107.602;
MatrixA(30,36) = -3.26443e-05;
MatrixA(30,37) = 3.22221;
MatrixA(30,38) = -0.00450366;
MatrixA(30,39) = -6.72521;
MatrixA(30,40) = -0.00936981;
MatrixA(30,41) = 2.96004;
MatrixA(30,46) = 1.58065;
MatrixA(30,47) = -3.96636e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 67.4699;
MatrixA(36,2) = 213.159;
MatrixA(36,3) = -0.025826;
MatrixA(36,6) = 7.93731e-05;
MatrixA(36,7) = 3.99498e-07;
MatrixA(36,8) = 0.586837;
MatrixA(36,9) = -15.9706;
MatrixA(36,12) = 7.40177;
MatrixA(36,13) = 125.248;
MatrixA(36,16) = 8.29784;
MatrixA(36,20) = 8.29416;
MatrixA(36,24) = 3.00388;
MatrixA(36,26) = 3.0027;
MatrixA(36,28) = 3.01738;
MatrixA(36,30) = 3.01857;
MatrixA(36,32) = -0.00366866;
MatrixA(36,35) = 0.00366866;
MatrixA(36,36) = -3.29127;
MatrixA(36,37) = -0.000175821;
MatrixA(36,38) = -0.106282;
MatrixA(36,39) = -0.00165805;
MatrixA(36,40) = 1.71709;
MatrixA(36,41) = -3.59664e-05;
MatrixA(36,42) = -5.52859e-05;
MatrixA(36,43) = -0.296606;
MatrixA(36,44) = 0.38093;
MatrixA(36,45) = 0.380805;
MatrixA(36,46) = -5.95808e-05;
MatrixA(36,47) = 0.7128;
MatrixA(36,48) = 0.262802;
MatrixA(36,49) = 0.263598;
MatrixA(36,52) = -0.000116777;
MatrixA(37,1) = 0.0377126;
MatrixA(37,2) = 0.0782801;
MatrixA(37,3) = 101.143;
MatrixA(37,6) = 0.0145436;
MatrixA(37,7) = 0.00980681;
MatrixA(37,8) = -167.658;
MatrixA(37,9) = 5.31711;
MatrixA(37,12) = 216.753;
MatrixA(37,13) = -0.922757;
MatrixA(37,16) = -30.8396;
MatrixA(37,20) = -30.5908;
MatrixA(37,24) = -6.78419;
MatrixA(37,26) = -6.78141;
MatrixA(37,28) = -6.55451;
MatrixA(37,30) = -6.55719;
MatrixA(37,32) = -0.00472178;
MatrixA(37,35) = 0.00472178;
MatrixA(37,36) = 0.000176495;
MatrixA(37,37) = -0.0388352;
MatrixA(37,38) = 5.99477e-05;
MatrixA(37,39) = -33.3366;
MatrixA(37,40) = -0.000155408;
MatrixA(37,41) = 1.05526;
MatrixA(37,42) = -1.06681;
MatrixA(37,43) = 0.00890953;
MatrixA(37,44) = -0.0013355;
MatrixA(37,45) = 0.00943973;
MatrixA(37,46) = 0.267889;
MatrixA(37,47) = 0.00701165;
MatrixA(37,48) = -0.0147059;
MatrixA(37,49) = 0.00715915;
MatrixA(37,52) = -0.000150299;
MatrixA(38,1) = -7.06917;
MatrixA(38,2) = -23.5462;
MatrixA(38,3) = -0.125132;
MatrixA(38,6) = -1.95115e-05;
MatrixA(38,7) = -1.37899e-05;
MatrixA(38,8) = -15.4006;
MatrixA(38,9) = 610.424;
MatrixA(38,12) = 44.8852;
MatrixA(38,13) = 365.333;
MatrixA(38,16) = 0.139817;
MatrixA(38,20) = 0.13941;
MatrixA(38,24) = -0.332603;
MatrixA(38,26) = -0.332472;
MatrixA(38,28) = -0.334441;
MatrixA(38,30) = -0.334573;
MatrixA(38,32) = 0.000281455;
MatrixA(38,35) = -0.000281455;
MatrixA(38,36) = 0.137925;
MatrixA(38,37) = -7.05697e-06;
MatrixA(38,38) = 0.0044538;
MatrixA(38,39) = 0.000347148;
MatrixA(38,40) = 33.205;
MatrixA(38,41) = -0.00176764;
MatrixA(38,42) = 0.00204795;
MatrixA(38,43) = 6.84046;
MatrixA(38,44) = 0.00441923;
MatrixA(38,45) = 0.00440194;
MatrixA(38,46) = -0.000356756;
MatrixA(38,47) = 5.46293;
MatrixA(38,48) = -0.0298992;
MatrixA(38,49) = -0.0300187;
MatrixA(38,52) = 8.95899e-06;
MatrixA(39,1) = 0.00387891;
MatrixA(39,2) = -0.0195991;
MatrixA(39,3) = -219.217;
MatrixA(39,6) = 0.00763081;
MatrixA(39,7) = 0.00610786;
MatrixA(39,8) = -77.1766;
MatrixA(39,9) = 2.07267;
MatrixA(39,12) = -202.423;
MatrixA(39,13) = 1.97683;
MatrixA(39,16) = -18.2803;
MatrixA(39,20) = -12.9417;
MatrixA(39,24) = 4.73157;
MatrixA(39,26) = 4.72961;
MatrixA(39,28) = 6.88869;
MatrixA(39,30) = 6.89149;
MatrixA(39,32) = -0.00620542;
MatrixA(39,35) = 0.00620542;
MatrixA(39,36) = -0.000887175;
MatrixA(39,37) = -0.00354368;
MatrixA(39,38) = -2.36966e-05;
MatrixA(39,39) = -0.816876;
MatrixA(39,40) = -0.000386677;
MatrixA(39,41) = -0.219724;
MatrixA(39,42) = -0.511716;
MatrixA(39,43) = 0.00466761;
MatrixA(39,44) = -0.122645;
MatrixA(39,45) = 0.121999;
MatrixA(39,46) = -0.550912;
MatrixA(39,47) = -0.00610143;
MatrixA(39,48) = -0.0925722;
MatrixA(39,49) = 0.094377;
MatrixA(39,52) = -0.000197525;
MatrixA(40,1) = -18.9128;
MatrixA(40,2) = -59.905;
MatrixA(40,3) = -0.281965;
MatrixA(40,6) = -3.63476e-06;
MatrixA(40,7) = 8.42957e-06;
MatrixA(40,8) = 7.2822;
MatrixA(40,9) = -289.296;
MatrixA(40,12) = 33.7297;
MatrixA(40,13) = 261.584;
MatrixA(40,16) = -1.25735;
MatrixA(40,20) = -1.24952;
MatrixA(40,24) = -0.866635;
MatrixA(40,26) = -0.866293;
MatrixA(40,28) = -0.867623;
MatrixA(40,30) = -0.867966;
MatrixA(40,32) = -0.0403628;
MatrixA(40,35) = 0.0403628;
MatrixA(40,36) = 0.673592;
MatrixA(40,37) = 2.88765e-05;
MatrixA(40,38) = 0.0217514;
MatrixA(40,39) = -0.000203239;
MatrixA(40,40) = -0.576461;
MatrixA(40,41) = -0.000307781;
MatrixA(40,42) = -0.000897654;
MatrixA(40,43) = -3.2247;
MatrixA(40,44) = -0.055387;
MatrixA(40,45) = -0.0550346;
MatrixA(40,46) = -0.00065775;
MatrixA(40,47) = 4.14653;
MatrixA(40,48) = -0.0751479;
MatrixA(40,49) = -0.0751249;
MatrixA(40,52) = -0.00128479;
MatrixA(41,1) = 0.0424081;
MatrixA(41,2) = 0.0881606;
MatrixA(41,3) = 117.375;
MatrixA(41,6) = 0.0160647;
MatrixA(41,7) = 0.010738;
MatrixA(41,8) = 155.837;
MatrixA(41,9) = -15.0241;
MatrixA(41,12) = 527.348;
MatrixA(41,13) = -21.9953;
MatrixA(41,16) = -33.859;
MatrixA(41,20) = -34.0955;
MatrixA(41,24) = -7.22186;
MatrixA(41,26) = -7.21889;
MatrixA(41,28) = -7.17663;
MatrixA(41,30) = -7.17957;
MatrixA(41,32) = 0.0595968;
MatrixA(41,35) = -0.0595968;
MatrixA(41,36) = 0.000177049;
MatrixA(41,37) = -0.0269982;
MatrixA(41,38) = 4.34442e-05;
MatrixA(41,39) = 0.0758962;
MatrixA(41,40) = -4.7047e-05;
MatrixA(41,41) = -0.000987296;
MatrixA(41,42) = 3.76014;
MatrixA(41,43) = 0.009834;
MatrixA(41,44) = 0.00809305;
MatrixA(41,45) = -0.00346472;
MatrixA(41,46) = 4.28126;
MatrixA(41,47) = 0.00759086;
MatrixA(41,48) = -0.0091811;
MatrixA(41,49) = -0.00329404;
MatrixA(41,52) = 0.00189703;
MatrixA(42,1) = 0.213692;
MatrixA(42,2) = -0.0873777;
MatrixA(42,3) = -11489;
MatrixA(42,6) = 0.788962;
MatrixA(42,7) = 1.1862;
MatrixA(42,8) = -17762.8;
MatrixA(42,9) = 395.064;
MatrixA(42,12) = -436.659;
MatrixA(42,13) = 18.0981;
MatrixA(42,16) = -461.021;
MatrixA(42,20) = -482.105;
MatrixA(42,24) = 5.41697;
MatrixA(42,26) = 5.41474;
MatrixA(42,28) = 6.6965;
MatrixA(42,30) = 6.69923;
MatrixA(42,32) = -0.643712;
MatrixA(42,35) = 0.643712;
MatrixA(42,36) = -0.000524331;
MatrixA(42,37) = 0.00241053;
MatrixA(42,38) = -2.02954e-05;
MatrixA(42,39) = 22.136;
MatrixA(42,40) = 0.0314894;
MatrixA(42,41) = -0.213181;
MatrixA(42,42) = -93.4907;
MatrixA(42,43) = -0.00800952;
MatrixA(42,44) = 0.758298;
MatrixA(42,45) = -0.218947;
MatrixA(42,46) = -3.58105;
MatrixA(42,47) = -0.00645154;
MatrixA(42,48) = -0.282665;
MatrixA(42,49) = -0.172475;
MatrixA(42,52) = -0.02049;
MatrixA(43,1) = -3791.63;
MatrixA(43,2) = -2.39931;
MatrixA(43,3) = 1.14748;
MatrixA(43,6) = 9.1047e-05;
MatrixA(43,7) = 8.07131e-05;
MatrixA(43,8) = 194.176;
MatrixA(43,9) = -11464.2;
MatrixA(43,12) = -1.69759;
MatrixA(43,13) = -27.8758;
MatrixA(43,16) = 1.86759;
MatrixA(43,20) = 1.86488;
MatrixA(43,24) = -0.77916;
MatrixA(43,26) = -0.778851;
MatrixA(43,28) = -0.782755;
MatrixA(43,30) = -0.783063;
MatrixA(43,32) = -0.0524194;
MatrixA(43,35) = 0.0524194;
MatrixA(43,36) = -0.102245;
MatrixA(43,37) = 8.46972e-05;
MatrixA(43,38) = -0.00330176;
MatrixA(43,39) = 0.00221493;
MatrixA(43,40) = 0.07664;
MatrixA(43,41) = -0.000362797;
MatrixA(43,42) = -0.0162824;
MatrixA(43,43) = -86.2151;
MatrixA(43,44) = 0.0880416;
MatrixA(43,45) = 0.0879268;
MatrixA(43,46) = -0.00300612;
MatrixA(43,47) = -0.113915;
MatrixA(43,48) = -0.0668683;
MatrixA(43,49) = -0.0670838;
MatrixA(43,52) = -0.00166856;
MatrixA(44,1) = 581.226;
MatrixA(44,2) = 49.3;
MatrixA(44,3) = 499.033;
MatrixA(44,6) = -0.0391918;
MatrixA(44,7) = 0.144411;
MatrixA(44,8) = 492.111;
MatrixA(44,9) = 851.319;
MatrixA(44,12) = -34.0134;
MatrixA(44,13) = -261.581;
MatrixA(44,16) = -1460.17;
MatrixA(44,20) = 19.0899;
MatrixA(44,24) = 0.873268;
MatrixA(44,26) = 0.872922;
MatrixA(44,28) = 0.87728;
MatrixA(44,30) = 0.877627;
MatrixA(44,32) = 10.1514;
MatrixA(44,35) = -10.1514;
MatrixA(44,36) = 167.948;
MatrixA(44,37) = 0.00764145;
MatrixA(44,38) = 5.42333;
MatrixA(44,39) = -151.116;
MatrixA(44,40) = -143.181;
MatrixA(44,41) = 4.88604;
MatrixA(44,42) = 4.88215;
MatrixA(44,43) = 8.66979;
MatrixA(44,44) = -72.6732;
MatrixA(44,45) = -2.68634;
MatrixA(44,46) = -0.000114452;
MatrixA(44,47) = -4.14653;
MatrixA(44,48) = 4.03283;
MatrixA(44,49) = 4.03307;
MatrixA(44,52) = 0.323128;
MatrixA(45,1) = 581.457;
MatrixA(45,2) = 49.2978;
MatrixA(45,3) = -509.656;
MatrixA(45,6) = 0.0288077;
MatrixA(45,7) = -0.144367;
MatrixA(45,8) = -516.578;
MatrixA(45,9) = 851.55;
MatrixA(45,12) = -34.0134;
MatrixA(45,13) = -261.581;
MatrixA(45,16) = 19.0993;
MatrixA(45,20) = -1459.43;
MatrixA(45,24) = 0.873268;
MatrixA(45,26) = 0.872922;
MatrixA(45,28) = 0.87728;
MatrixA(45,30) = 0.877627;
MatrixA(45,32) = 10.1514;
MatrixA(45,35) = -10.1514;
MatrixA(45,36) = 167.881;
MatrixA(45,37) = 0.00763838;
MatrixA(45,38) = 5.42115;
MatrixA(45,39) = 151.225;
MatrixA(45,40) = -142.701;
MatrixA(45,41) = -4.87682;
MatrixA(45,42) = -4.88071;
MatrixA(45,43) = 8.66761;
MatrixA(45,44) = -2.68601;
MatrixA(45,45) = -72.647;
MatrixA(45,46) = -0.000114452;
MatrixA(45,47) = -4.14653;
MatrixA(45,48) = 4.03283;
MatrixA(45,49) = 4.03307;
MatrixA(45,52) = 0.323128;
MatrixA(46,1) = 0.947657;
MatrixA(46,2) = 3.50398;
MatrixA(46,3) = -27701.3;
MatrixA(46,6) = -0.0184069;
MatrixA(46,7) = -0.0114228;
MatrixA(46,8) = -182.36;
MatrixA(46,9) = 17.4068;
MatrixA(46,12) = -33682.4;
MatrixA(46,13) = 420.727;
MatrixA(46,16) = 36.8732;
MatrixA(46,20) = 41.9107;
MatrixA(46,24) = -229.605;
MatrixA(46,26) = -229.513;
MatrixA(46,28) = -238.728;
MatrixA(46,30) = -238.823;
MatrixA(46,32) = -0.677038;
MatrixA(46,35) = 0.677038;
MatrixA(46,36) = 0.00419501;
MatrixA(46,37) = 0.0456383;
MatrixA(46,38) = 7.16956e-05;
MatrixA(46,39) = 16.7477;
MatrixA(46,40) = 0.0196781;
MatrixA(46,41) = -0.259561;
MatrixA(46,42) = -4.46205;
MatrixA(46,43) = -0.011146;
MatrixA(46,44) = -0.356751;
MatrixA(46,45) = -0.124779;
MatrixA(46,46) = -79.8495;
MatrixA(46,47) = -0.0088152;
MatrixA(46,48) = 0.651172;
MatrixA(46,49) = -0.0829437;
MatrixA(46,52) = -0.0215508;
MatrixA(47,1) = -6578.93;
MatrixA(47,2) = -22228.3;
MatrixA(47,3) = 7.18402;
MatrixA(47,6) = 1.34659e-05;
MatrixA(47,7) = -4.19439e-06;
MatrixA(47,8) = 0.379462;
MatrixA(47,9) = -16.7773;
MatrixA(47,12) = -556.043;
MatrixA(47,13) = -11151.4;
MatrixA(47,16) = 1.562;
MatrixA(47,20) = 1.56137;
MatrixA(47,24) = 6.72881;
MatrixA(47,26) = 6.72615;
MatrixA(47,28) = 6.75998;
MatrixA(47,30) = 6.76265;
MatrixA(47,32) = 0.0818359;
MatrixA(47,35) = -0.0818359;
MatrixA(47,36) = -3.34748;
MatrixA(47,37) = -8.17793e-05;
MatrixA(47,38) = -0.108096;
MatrixA(47,39) = -0.00872276;
MatrixA(47,40) = 2.84994;
MatrixA(47,41) = -0.000473384;
MatrixA(47,42) = -0.00182488;
MatrixA(47,43) = -0.210788;
MatrixA(47,44) = 0.0684284;
MatrixA(47,45) = 0.0684078;
MatrixA(47,46) = 0.00784321;
MatrixA(47,47) = -67.5952;
MatrixA(47,48) = 0.582481;
MatrixA(47,49) = 0.584341;
MatrixA(47,52) = 0.00260492;
MatrixA(48,1) = 2026.23;
MatrixA(48,2) = 6883.13;
MatrixA(48,3) = 1965.3;
MatrixA(48,6) = 1.42144e-05;
MatrixA(48,7) = 3.85749e-08;
MatrixA(48,8) = -7.38919;
MatrixA(48,9) = 289.298;
MatrixA(48,12) = 1933.29;
MatrixA(48,13) = 1737.93;
MatrixA(48,16) = 1.232;
MatrixA(48,20) = 1.23158;
MatrixA(48,24) = -727.135;
MatrixA(48,26) = -726.847;
MatrixA(48,28) = 12.8452;
MatrixA(48,30) = 12.8503;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 158.852;
MatrixA(48,37) = 0.00710822;
MatrixA(48,38) = 5.1296;
MatrixA(48,39) = -156.519;
MatrixA(48,40) = -135.445;
MatrixA(48,41) = 5.06003;
MatrixA(48,42) = 0.000188193;
MatrixA(48,43) = 3.2247;
MatrixA(48,44) = 5.33185;
MatrixA(48,45) = 5.33183;
MatrixA(48,46) = 5.05758;
MatrixA(48,47) = 17.5109;
MatrixA(48,48) = -71.1692;
MatrixA(48,49) = -3.61546;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 2020.4;
MatrixA(49,2) = 6862.81;
MatrixA(49,3) = -1968.91;
MatrixA(49,6) = 1.42144e-05;
MatrixA(49,7) = 3.85749e-08;
MatrixA(49,8) = -7.38919;
MatrixA(49,9) = 289.298;
MatrixA(49,12) = -2000.92;
MatrixA(49,13) = 1732.12;
MatrixA(49,16) = 1.232;
MatrixA(49,20) = 1.23158;
MatrixA(49,24) = 12.7885;
MatrixA(49,26) = 12.7834;
MatrixA(49,28) = -730.355;
MatrixA(49,30) = -730.643;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 159.34;
MatrixA(49,37) = 0.00713005;
MatrixA(49,38) = 5.14534;
MatrixA(49,39) = 157.154;
MatrixA(49,40) = -135.421;
MatrixA(49,41) = -5.06872;
MatrixA(49,42) = 0.000188193;
MatrixA(49,43) = 3.2247;
MatrixA(49,44) = 5.33185;
MatrixA(49,45) = 5.33183;
MatrixA(49,46) = -5.07117;
MatrixA(49,47) = 17.5771;
MatrixA(49,48) = -3.61878;
MatrixA(49,49) = -71.3578;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 3.58319e-05;
MatrixA(50,2) = 3.58319e-05;
MatrixA(50,3) = 3.58319e-05;
MatrixA(50,4) = 3.58319e-05;
MatrixA(50,5) = 3.58319e-05;
MatrixA(50,6) = 3.58319e-05;
MatrixA(50,7) = 3.58319e-05;
MatrixA(50,8) = 3.58319e-05;
MatrixA(50,9) = 3.58319e-05;
MatrixA(50,10) = 3.58319e-05;
MatrixA(50,11) = 3.58319e-05;
MatrixA(50,12) = 3.58319e-05;
MatrixA(50,13) = 3.58319e-05;
MatrixA(50,14) = 3.58319e-05;
MatrixA(50,15) = 3.58319e-05;
MatrixA(50,16) = 3.58319e-05;
MatrixA(50,17) = 3.58319e-05;
MatrixA(50,18) = 3.58319e-05;
MatrixA(50,19) = 3.58319e-05;
MatrixA(50,20) = 3.58319e-05;
MatrixA(50,21) = 3.58319e-05;
MatrixA(50,22) = 3.58319e-05;
MatrixA(50,23) = 3.58319e-05;
MatrixA(50,24) = 3.58319e-05;
MatrixA(50,25) = 3.58319e-05;
MatrixA(50,26) = 3.58319e-05;
MatrixA(50,27) = 3.58319e-05;
MatrixA(50,28) = 3.58319e-05;
MatrixA(50,29) = 3.58319e-05;
MatrixA(50,30) = 3.58319e-05;
MatrixA(50,31) = 3.58319e-05;
MatrixA(50,32) = 3.58319e-05;
MatrixA(50,33) = 3.58319e-05;
MatrixA(50,34) = 3.58319e-05;
MatrixA(50,35) = 3.58319e-05;
MatrixA(50,36) = -538.519;
MatrixA(50,37) = 3.58319e-05;
MatrixA(50,38) = -17.3972;
MatrixA(50,39) = 3.58319e-05;
MatrixA(50,40) = 3.58319e-05;
MatrixA(50,41) = 3.58319e-05;
MatrixA(50,42) = 3.58319e-05;
MatrixA(50,43) = 3.58319e-05;
MatrixA(50,44) = 3.58319e-05;
MatrixA(50,45) = -0.0587724;
MatrixA(50,46) = -0.0587724;
MatrixA(50,47) = 3.58319e-05;
MatrixA(50,48) = 3.58319e-05;
MatrixA(50,49) = -0.0587724;
MatrixA(50,50) = -8.10871;
MatrixA(50,51) = 3.58319e-05;
MatrixA(50,52) = 5.25355;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 102.231;
MatrixA(51,52) = -119.006;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 167.592;
MatrixA(52,52) = -195.091;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 3.58319e-05;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0633562;
MatrixC(2,2) = 0.176448;
MatrixC(2,3) = -2.97181;
MatrixC(2,6) = 0.00828981;
MatrixC(2,7) = 2.22782e-12;
MatrixC(2,8) = -1.79416;
MatrixC(2,9) = 0.0134367;
MatrixC(2,12) = -1.1102;
MatrixC(2,13) = 0.0497184;
MatrixC(2,16) = -27.6206;
MatrixC(2,20) = -27.6081;
MatrixC(2,24) = -9.62918;
MatrixC(2,26) = -9.62524;
MatrixC(2,28) = -9.65886;
MatrixC(2,30) = -9.6628;
MatrixC(2,35) = -3.25261e-16;
MatrixC(2,36) = 8.54272e-06;
MatrixC(2,37) = -0.0401579;
MatrixC(2,38) = 5.63918e-05;
MatrixC(2,39) = 0.00329472;
MatrixC(2,40) = -1.01863e-05;
MatrixC(2,41) = -0.00292712;
MatrixC(2,42) = 0.000338359;
MatrixC(2,43) = 2.45824e-07;
MatrixC(2,44) = -1.7249e-06;
MatrixC(2,45) = -1.72371e-06;
MatrixC(2,46) = -0.000329742;
MatrixC(2,47) = 1.19841e-06;
MatrixC(2,48) = -1.83652e-06;
MatrixC(2,49) = -1.84329e-06;
MatrixC(2,52) = -2.1684e-16;

MatrixD = zeros(2, 1);
