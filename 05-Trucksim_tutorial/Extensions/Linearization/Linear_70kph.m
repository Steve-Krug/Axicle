% MATLAB linearized TruckSim 2023.0 model, calculated at t = 160.009 s.
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

MatrixA(1,2) = -19.4427;
MatrixA(1,3) = -0.000289365;
MatrixA(1,36) = -0.0320666;
MatrixA(1,37) = 0.00207028;
MatrixA(1,38) = 0.999484;
MatrixA(1,39) = 0.00267066;
MatrixA(1,40) = -1.26208;
MatrixA(1,41) = 0.00175974;
MatrixA(2,3) = 2.57642e-05;
MatrixA(2,39) = -0.00207135;
MatrixA(2,40) = 0.999998;
MatrixA(3,2) = -2.5792e-05;
MatrixA(3,3) = 3.07109e-08;
MatrixA(3,39) = 0.0320831;
MatrixA(3,40) = 6.64553e-05;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238019;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 6.55425e-07;
MatrixA(16,2) = -6.06153e-05;
MatrixA(16,3) = 4.09582e-06;
MatrixA(16,6) = -1.60556;
MatrixA(16,7) = -0.000832457;
MatrixA(16,8) = 0.901195;
MatrixA(16,9) = -6.02813e-07;
MatrixA(16,16) = -27.2089;
MatrixA(16,36) = -1.57202e-06;
MatrixA(16,37) = 1.39694;
MatrixA(16,38) = -0.00289361;
MatrixA(16,39) = 1.81916;
MatrixA(16,40) = 0.00376945;
MatrixA(16,41) = 1.12953;
MatrixA(16,42) = 0.46179;
MatrixA(16,43) = 2.49306e-06;
MatrixA(17,1) = 5.16102e-06;
MatrixA(17,2) = 0.0184943;
MatrixA(17,3) = 4.55156e-06;
MatrixA(17,6) = 5.50385e-05;
MatrixA(17,7) = -0.00157839;
MatrixA(17,8) = 9.69686e-06;
MatrixA(17,9) = 3.7489e-06;
MatrixA(17,17) = -35.1672;
MatrixA(17,36) = -1.89485;
MatrixA(17,37) = -0.000119909;
MatrixA(17,38) = -0.0608125;
MatrixA(17,39) = 1.65758;
MatrixA(17,40) = 1.61573;
MatrixA(17,41) = -0.0532664;
MatrixA(17,42) = -0.0532024;
MatrixA(17,43) = -0.0608126;
MatrixA(17,44) = 0.745012;
MatrixA(20,1) = 6.55545e-07;
MatrixA(20,2) = -6.06226e-05;
MatrixA(20,3) = 2.86941e-06;
MatrixA(20,6) = -1.60571;
MatrixA(20,7) = -0.000832585;
MatrixA(20,8) = 0.843311;
MatrixA(20,9) = -6.02854e-07;
MatrixA(20,20) = -27.2121;
MatrixA(20,36) = -1.57221e-06;
MatrixA(20,37) = 1.39711;
MatrixA(20,38) = -0.00289396;
MatrixA(20,39) = 1.81938;
MatrixA(20,40) = 0.0037699;
MatrixA(20,41) = 1.12967;
MatrixA(20,42) = 0.461846;
MatrixA(20,43) = 2.49336e-06;
MatrixA(21,1) = 5.17617e-06;
MatrixA(21,2) = 0.0184821;
MatrixA(21,3) = -5.15608e-06;
MatrixA(21,6) = 5.49973e-05;
MatrixA(21,7) = 0.00157739;
MatrixA(21,8) = 6.09852e-06;
MatrixA(21,9) = 3.76523e-06;
MatrixA(21,21) = -35.1425;
MatrixA(21,36) = -1.8936;
MatrixA(21,37) = -0.000119829;
MatrixA(21,38) = -0.0607721;
MatrixA(21,39) = -1.65842;
MatrixA(21,40) = 1.60778;
MatrixA(21,41) = 0.0531215;
MatrixA(21,42) = 0.0531855;
MatrixA(21,43) = -0.0607722;
MatrixA(21,45) = 0.744517;
MatrixA(24,1) = -1.65735e-06;
MatrixA(24,2) = 0.00144632;
MatrixA(24,3) = -5.05136e-07;
MatrixA(24,12) = 2.21551;
MatrixA(24,13) = -1.46745e-05;
MatrixA(24,24) = -63.2503;
MatrixA(24,36) = -1.82479e-05;
MatrixA(24,37) = 3.24734;
MatrixA(24,38) = -0.00672695;
MatrixA(24,39) = -6.77744;
MatrixA(24,40) = -0.0140229;
MatrixA(24,41) = 2.97882;
MatrixA(24,46) = 1.58867;
MatrixA(24,47) = -5.18259e-05;
MatrixA(26,1) = -1.65859e-06;
MatrixA(26,2) = 0.0014474;
MatrixA(26,3) = -1.0146e-06;
MatrixA(26,12) = 2.29486;
MatrixA(26,13) = -1.46827e-05;
MatrixA(26,26) = -63.28;
MatrixA(26,36) = -1.82565e-05;
MatrixA(26,37) = 3.24886;
MatrixA(26,38) = -0.00673012;
MatrixA(26,39) = -6.78062;
MatrixA(26,40) = -0.0140295;
MatrixA(26,41) = 2.98022;
MatrixA(26,46) = 1.58942;
MatrixA(26,47) = -5.18503e-05;
MatrixA(28,1) = -1.65047e-06;
MatrixA(28,2) = 0.00144032;
MatrixA(28,3) = 1.77133e-06;
MatrixA(28,12) = 1.86046;
MatrixA(28,13) = -1.46295e-05;
MatrixA(28,28) = -63.0856;
MatrixA(28,36) = -1.82005e-05;
MatrixA(28,37) = 3.23889;
MatrixA(28,38) = -0.00670945;
MatrixA(28,39) = -6.75984;
MatrixA(28,40) = -0.0139865;
MatrixA(28,41) = 2.97107;
MatrixA(28,46) = 1.58454;
MatrixA(28,47) = -5.16911e-05;
MatrixA(30,1) = -1.64923e-06;
MatrixA(30,2) = 0.00143925;
MatrixA(30,3) = 2.10332e-06;
MatrixA(30,12) = 1.8086;
MatrixA(30,13) = -1.46215e-05;
MatrixA(30,30) = -63.056;
MatrixA(30,36) = -1.8192e-05;
MatrixA(30,37) = 3.23737;
MatrixA(30,38) = -0.00670631;
MatrixA(30,39) = -6.75668;
MatrixA(30,40) = -0.01398;
MatrixA(30,41) = 2.96968;
MatrixA(30,46) = 1.5838;
MatrixA(30,47) = -5.16669e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 79.3311;
MatrixA(36,2) = 243.379;
MatrixA(36,3) = 0.0751914;
MatrixA(36,6) = 3.46518e-05;
MatrixA(36,7) = 6.99574e-07;
MatrixA(36,8) = 1.35753;
MatrixA(36,9) = -11.6823;
MatrixA(36,12) = 12.6883;
MatrixA(36,13) = 142.857;
MatrixA(36,16) = 5.5;
MatrixA(36,17) = 6.93586;
MatrixA(36,20) = 5.50164;
MatrixA(36,21) = 6.93058;
MatrixA(36,24) = 3.17173;
MatrixA(36,26) = 3.16913;
MatrixA(36,28) = 3.17439;
MatrixA(36,30) = 3.177;
MatrixA(36,32) = -0.00367957;
MatrixA(36,35) = 0.00367957;
MatrixA(36,36) = -4.91794;
MatrixA(36,37) = -0.000344153;
MatrixA(36,38) = -0.157786;
MatrixA(36,39) = -0.00746044;
MatrixA(36,40) = 3.55338;
MatrixA(36,41) = -4.8943e-06;
MatrixA(36,42) = -4.91508e-05;
MatrixA(36,43) = -0.317933;
MatrixA(36,44) = 0.517598;
MatrixA(36,45) = 0.517667;
MatrixA(36,46) = -3.04101e-05;
MatrixA(36,47) = 0.593336;
MatrixA(36,48) = 0.446701;
MatrixA(36,49) = 0.448598;
MatrixA(36,52) = -0.000117124;
MatrixA(37,1) = 0.00851514;
MatrixA(37,2) = 9.77154e-05;
MatrixA(37,3) = 97.9783;
MatrixA(37,6) = 0.0104977;
MatrixA(37,7) = 0.00574431;
MatrixA(37,8) = -165.518;
MatrixA(37,9) = 10.6679;
MatrixA(37,12) = 212.257;
MatrixA(37,13) = -2.11063;
MatrixA(37,16) = -37.2165;
MatrixA(37,17) = -0.0989793;
MatrixA(37,20) = -37.0534;
MatrixA(37,21) = 0.0988094;
MatrixA(37,24) = -8.17207;
MatrixA(37,26) = -8.16782;
MatrixA(37,28) = -7.9463;
MatrixA(37,30) = -7.95033;
MatrixA(37,32) = -0.00479165;
MatrixA(37,35) = 0.00479165;
MatrixA(37,36) = 0.000391602;
MatrixA(37,37) = -0.02265;
MatrixA(37,38) = 5.94419e-05;
MatrixA(37,39) = -19.5211;
MatrixA(37,40) = -0.000494433;
MatrixA(37,41) = 0.613945;
MatrixA(37,42) = -1.06349;
MatrixA(37,43) = 0.0131749;
MatrixA(37,44) = -0.00334601;
MatrixA(37,45) = 0.0114174;
MatrixA(37,46) = 0.265484;
MatrixA(37,47) = 0.0104125;
MatrixA(37,48) = -0.0223292;
MatrixA(37,49) = 0.0147395;
MatrixA(37,52) = -0.000152523;
MatrixA(38,1) = -8.24366;
MatrixA(38,2) = -27.6643;
MatrixA(38,3) = -0.183998;
MatrixA(38,6) = -2.14048e-05;
MatrixA(38,7) = -1.19426e-05;
MatrixA(38,8) = -34.6017;
MatrixA(38,9) = 572.328;
MatrixA(38,12) = 75.6156;
MatrixA(38,13) = 410.413;
MatrixA(38,16) = 0.142842;
MatrixA(38,17) = 0.0827436;
MatrixA(38,20) = 0.142502;
MatrixA(38,21) = 0.0822448;
MatrixA(38,24) = -0.352973;
MatrixA(38,26) = -0.352679;
MatrixA(38,28) = -0.353722;
MatrixA(38,30) = -0.354018;
MatrixA(38,32) = 0.000292731;
MatrixA(38,35) = -0.000292731;
MatrixA(38,36) = 0.238822;
MatrixA(38,37) = 4.32768e-06;
MatrixA(38,38) = 0.00766262;
MatrixA(38,39) = 0.000935049;
MatrixA(38,40) = 19.2332;
MatrixA(38,41) = -0.00134115;
MatrixA(38,42) = 0.00302569;
MatrixA(38,43) = 6.84046;
MatrixA(38,44) = 0.00615591;
MatrixA(38,45) = 0.00612418;
MatrixA(38,46) = -0.000514898;
MatrixA(38,47) = 5.47521;
MatrixA(38,48) = -0.0520364;
MatrixA(38,49) = -0.0523301;
MatrixA(38,52) = 9.31793e-06;
MatrixA(39,1) = 0.0214551;
MatrixA(39,2) = 0.050469;
MatrixA(39,3) = -220.396;
MatrixA(39,6) = 0.00554896;
MatrixA(39,7) = 0.00396654;
MatrixA(39,8) = -77.2501;
MatrixA(39,9) = 4.07911;
MatrixA(39,12) = -200.502;
MatrixA(39,13) = 4.28494;
MatrixA(39,16) = -20.6434;
MatrixA(39,17) = -2.22821;
MatrixA(39,20) = -17.1041;
MatrixA(39,21) = 2.2263;
MatrixA(39,24) = 5.8732;
MatrixA(39,26) = 5.87051;
MatrixA(39,28) = 8.16282;
MatrixA(39,30) = 8.16736;
MatrixA(39,32) = -0.00613119;
MatrixA(39,35) = 0.00613119;
MatrixA(39,36) = -0.00246506;
MatrixA(39,37) = -0.00206909;
MatrixA(39,38) = -7.4802e-05;
MatrixA(39,39) = -1.40538;
MatrixA(39,40) = -0.000815131;
MatrixA(39,41) = -0.0983287;
MatrixA(39,42) = -0.446275;
MatrixA(39,43) = 0.00689591;
MatrixA(39,44) = -0.166522;
MatrixA(39,45) = 0.165973;
MatrixA(39,46) = -0.489501;
MatrixA(39,47) = -0.00917509;
MatrixA(39,48) = -0.15805;
MatrixA(39,49) = 0.160369;
MatrixA(39,52) = -0.000195162;
MatrixA(40,1) = -22.0526;
MatrixA(40,2) = -69.0894;
MatrixA(40,3) = -0.440942;
MatrixA(40,6) = 4.56079e-06;
MatrixA(40,7) = 8.01313e-06;
MatrixA(40,8) = 16.3444;
MatrixA(40,9) = -271.716;
MatrixA(40,12) = 56.786;
MatrixA(40,13) = 293.478;
MatrixA(40,16) = -0.8576;
MatrixA(40,17) = -1.03239;
MatrixA(40,20) = -0.850706;
MatrixA(40,21) = -1.02263;
MatrixA(40,24) = -0.915119;
MatrixA(40,26) = -0.914364;
MatrixA(40,28) = -0.911276;
MatrixA(40,30) = -0.91203;
MatrixA(40,32) = -0.0403593;
MatrixA(40,35) = 0.0403593;
MatrixA(40,36) = 1.05357;
MatrixA(40,37) = 6.72181e-05;
MatrixA(40,38) = 0.0338028;
MatrixA(40,39) = -0.000574832;
MatrixA(40,40) = -0.897709;
MatrixA(40,41) = -0.000218619;
MatrixA(40,42) = -0.00120154;
MatrixA(40,43) = -3.2214;
MatrixA(40,44) = -0.0757097;
MatrixA(40,45) = -0.0750495;
MatrixA(40,46) = -0.000855925;
MatrixA(40,47) = 4.18026;
MatrixA(40,48) = -0.129493;
MatrixA(40,49) = -0.129404;
MatrixA(40,52) = -0.00128468;
MatrixA(41,1) = 0.0124136;
MatrixA(41,2) = 0.00951784;
MatrixA(41,3) = 114.293;
MatrixA(41,6) = 0.0115917;
MatrixA(41,7) = 0.0062516;
MatrixA(41,8) = 146.433;
MatrixA(41,9) = -32.4683;
MatrixA(41,12) = 506.826;
MatrixA(41,13) = -46.3903;
MatrixA(41,16) = -40.9996;
MatrixA(41,17) = 0.10435;
MatrixA(41,20) = -41.1585;
MatrixA(41,21) = -0.104376;
MatrixA(41,24) = -8.71418;
MatrixA(41,26) = -8.70968;
MatrixA(41,28) = -8.68428;
MatrixA(41,30) = -8.68872;
MatrixA(41,32) = 0.0595191;
MatrixA(41,35) = -0.0595191;
MatrixA(41,36) = 0.000447838;
MatrixA(41,37) = -0.0157456;
MatrixA(41,38) = 4.70052e-05;
MatrixA(41,39) = 0.0495614;
MatrixA(41,40) = -0.000282446;
MatrixA(41,41) = -0.000735408;
MatrixA(41,42) = 3.75763;
MatrixA(41,43) = 0.0145424;
MatrixA(41,44) = 0.0100836;
MatrixA(41,45) = -0.00549626;
MatrixA(41,46) = 4.27352;
MatrixA(41,47) = 0.011276;
MatrixA(41,48) = -0.0111927;
MatrixA(41,49) = -0.00133811;
MatrixA(41,52) = 0.00189455;
MatrixA(42,1) = 0.12774;
MatrixA(42,2) = -0.0372112;
MatrixA(42,3) = -11481.6;
MatrixA(42,6) = 0.718673;
MatrixA(42,7) = 0.689503;
MatrixA(42,8) = -17530.5;
MatrixA(42,9) = 836.542;
MatrixA(42,12) = -421.127;
MatrixA(42,13) = 38.1544;
MatrixA(42,16) = -562.023;
MatrixA(42,17) = 8.82894;
MatrixA(42,20) = -575.944;
MatrixA(42,21) = -8.82438;
MatrixA(42,24) = 6.6303;
MatrixA(42,26) = 6.62709;
MatrixA(42,28) = 7.99776;
MatrixA(42,30) = 8.00207;
MatrixA(42,32) = -0.643518;
MatrixA(42,35) = 0.643518;
MatrixA(42,36) = -0.00042882;
MatrixA(42,37) = 0.00137457;
MatrixA(42,38) = -1.63689e-05;
MatrixA(42,39) = 14.2609;
MatrixA(42,40) = 0.0299305;
MatrixA(42,41) = -0.167941;
MatrixA(42,42) = -93.458;
MatrixA(42,43) = -0.0118159;
MatrixA(42,44) = 0.928449;
MatrixA(42,45) = -0.389239;
MatrixA(42,46) = -3.53987;
MatrixA(42,47) = -0.00961414;
MatrixA(42,48) = -0.321609;
MatrixA(42,49) = -0.13346;
MatrixA(42,52) = -0.0204838;
MatrixA(43,1) = -3793.24;
MatrixA(43,2) = -11.2943;
MatrixA(43,3) = 1.68037;
MatrixA(43,6) = 0.000102871;
MatrixA(43,7) = 6.93714e-05;
MatrixA(43,8) = 437;
MatrixA(43,9) = -10982.9;
MatrixA(43,12) = -2.81394;
MatrixA(43,13) = -31.7832;
MatrixA(43,16) = 1.21072;
MatrixA(43,17) = 1.55365;
MatrixA(43,20) = 1.20926;
MatrixA(43,21) = 1.55015;
MatrixA(43,24) = -0.816929;
MatrixA(43,26) = -0.816257;
MatrixA(43,28) = -0.817695;
MatrixA(43,30) = -0.81837;
MatrixA(43,32) = -0.0524595;
MatrixA(43,35) = 0.0524595;
MatrixA(43,36) = -0.00394147;
MatrixA(43,37) = 7.87427e-05;
MatrixA(43,38) = -0.000125195;
MatrixA(43,39) = 0.00288012;
MatrixA(43,40) = -0.00291746;
MatrixA(43,41) = -0.000388601;
MatrixA(43,42) = -0.0241457;
MatrixA(43,43) = -86.2198;
MatrixA(43,44) = 0.117651;
MatrixA(43,45) = 0.117494;
MatrixA(43,46) = -0.00445443;
MatrixA(43,47) = -0.0826844;
MatrixA(43,48) = -0.114564;
MatrixA(43,49) = -0.115074;
MatrixA(43,52) = -0.00166984;
MatrixA(44,1) = 288.751;
MatrixA(44,2) = 63.1886;
MatrixA(44,3) = 224.683;
MatrixA(44,6) = -0.0181693;
MatrixA(44,7) = 0.195356;
MatrixA(44,8) = 208.524;
MatrixA(44,9) = 538.283;
MatrixA(44,12) = -57.2018;
MatrixA(44,13) = -293.468;
MatrixA(44,16) = -968.17;
MatrixA(44,17) = -1220.23;
MatrixA(44,20) = 12.6669;
MatrixA(44,21) = 15.946;
MatrixA(44,24) = 0.927298;
MatrixA(44,26) = 0.926539;
MatrixA(44,28) = 0.928198;
MatrixA(44,30) = 0.928961;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 227.889;
MatrixA(44,37) = 0.0144112;
MatrixA(44,38) = 7.31123;
MatrixA(44,39) = -205.102;
MatrixA(44,40) = -194.201;
MatrixA(44,41) = 6.59272;
MatrixA(44,42) = 6.58557;
MatrixA(44,43) = 10.5665;
MatrixA(44,44) = -96.7175;
MatrixA(44,45) = -2.37331;
MatrixA(44,46) = -0.000161178;
MatrixA(44,47) = -4.18027;
MatrixA(44,48) = 4.08873;
MatrixA(44,49) = 4.0893;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 288.803;
MatrixA(45,2) = 63.1879;
MatrixA(45,3) = -255.228;
MatrixA(45,6) = 0.0143388;
MatrixA(45,7) = -0.195374;
MatrixA(45,8) = -271.387;
MatrixA(45,9) = 538.335;
MatrixA(45,12) = -57.2018;
MatrixA(45,13) = -293.468;
MatrixA(45,16) = 12.6639;
MatrixA(45,17) = 15.9593;
MatrixA(45,20) = -968.367;
MatrixA(45,21) = -1219.19;
MatrixA(45,24) = 0.927298;
MatrixA(45,26) = 0.926539;
MatrixA(45,28) = 0.928198;
MatrixA(45,30) = 0.928961;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 227.899;
MatrixA(45,37) = 0.0144118;
MatrixA(45,38) = 7.31153;
MatrixA(45,39) = 205.465;
MatrixA(45,40) = -193.359;
MatrixA(45,41) = -6.57958;
MatrixA(45,42) = -6.58673;
MatrixA(45,43) = 10.5668;
MatrixA(45,44) = -2.37338;
MatrixA(45,45) = -96.721;
MatrixA(45,46) = -0.000161178;
MatrixA(45,47) = -4.18027;
MatrixA(45,48) = 4.08873;
MatrixA(45,49) = 4.0893;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 0.41182;
MatrixA(46,2) = 1.58754;
MatrixA(46,3) = -27714.9;
MatrixA(46,6) = -0.0132227;
MatrixA(46,7) = -0.00629091;
MatrixA(46,8) = -171.86;
MatrixA(46,9) = 37.5339;
MatrixA(46,12) = -33380.6;
MatrixA(46,13) = 883.018;
MatrixA(46,16) = 45.89;
MatrixA(46,17) = -2.08579;
MatrixA(46,20) = 49.1908;
MatrixA(46,21) = 2.08199;
MatrixA(46,24) = -276.349;
MatrixA(46,26) = -276.212;
MatrixA(46,28) = -286.472;
MatrixA(46,30) = -286.617;
MatrixA(46,32) = -0.677394;
MatrixA(46,35) = 0.677394;
MatrixA(46,36) = 0.0094327;
MatrixA(46,37) = 0.026472;
MatrixA(46,38) = 0.000247935;
MatrixA(46,39) = 11.3477;
MatrixA(46,40) = 0.0153583;
MatrixA(46,41) = -0.200131;
MatrixA(46,42) = -4.39235;
MatrixA(46,43) = -0.0164538;
MatrixA(46,44) = -0.396626;
MatrixA(46,45) = -0.085532;
MatrixA(46,46) = -79.9005;
MatrixA(46,47) = -0.0125961;
MatrixA(46,48) = 0.905965;
MatrixA(46,49) = -0.339121;
MatrixA(46,52) = -0.0215621;
MatrixA(47,1) = -6556.71;
MatrixA(47,2) = -22154.3;
MatrixA(47,3) = 10.8523;
MatrixA(47,6) = 3.05319e-06;
MatrixA(47,7) = -3.49715e-06;
MatrixA(47,8) = 0.946175;
MatrixA(47,9) = -15.4038;
MatrixA(47,12) = -935.531;
MatrixA(47,13) = -11700.4;
MatrixA(47,16) = 1.03095;
MatrixA(47,17) = 1.26973;
MatrixA(47,20) = 1.03137;
MatrixA(47,21) = 1.26892;
MatrixA(47,24) = 7.22814;
MatrixA(47,26) = 7.22224;
MatrixA(47,28) = 7.23599;
MatrixA(47,30) = 7.24191;
MatrixA(47,32) = 0.0817561;
MatrixA(47,35) = -0.0817561;
MatrixA(47,36) = -5.62582;
MatrixA(47,37) = -0.000310844;
MatrixA(47,38) = -0.180502;
MatrixA(47,39) = -0.0177895;
MatrixA(47,40) = 4.78415;
MatrixA(47,41) = -0.000356269;
MatrixA(47,42) = -0.00270093;
MatrixA(47,43) = -0.218493;
MatrixA(47,44) = 0.0921133;
MatrixA(47,45) = 0.0921378;
MatrixA(47,46) = 0.0115792;
MatrixA(47,47) = -67.8493;
MatrixA(47,48) = 1.00575;
MatrixA(47,49) = 1.01025;
MatrixA(47,52) = 0.00260238;
MatrixA(48,1) = 1017.45;
MatrixA(48,2) = 3447.34;
MatrixA(48,3) = 969.598;
MatrixA(48,6) = 6.84878e-06;
MatrixA(48,7) = 1.42734e-07;
MatrixA(48,8) = -16.5032;
MatrixA(48,9) = 271.724;
MatrixA(48,12) = 913.842;
MatrixA(48,13) = 698.007;
MatrixA(48,16) = 0.815152;
MatrixA(48,17) = 1.02781;
MatrixA(48,20) = 0.815535;
MatrixA(48,21) = 1.0272;
MatrixA(48,24) = -768.337;
MatrixA(48,26) = -767.708;
MatrixA(48,28) = 13.5279;
MatrixA(48,30) = 13.539;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 270.064;
MatrixA(48,37) = 0.0178146;
MatrixA(48,38) = 8.66494;
MatrixA(48,39) = -265.951;
MatrixA(48,40) = -230.222;
MatrixA(48,41) = 8.54727;
MatrixA(48,42) = 0.000283922;
MatrixA(48,43) = 3.2214;
MatrixA(48,44) = 5.35429;
MatrixA(48,45) = 5.35432;
MatrixA(48,46) = 8.5412;
MatrixA(48,47) = 33.2446;
MatrixA(48,48) = -115.777;
MatrixA(48,49) = -2.8281;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 1013.36;
MatrixA(49,2) = 3433.13;
MatrixA(49,3) = -982.176;
MatrixA(49,6) = 6.84878e-06;
MatrixA(49,7) = 1.42734e-07;
MatrixA(49,8) = -16.5032;
MatrixA(49,9) = 271.724;
MatrixA(49,12) = -1037.94;
MatrixA(49,13) = 693.93;
MatrixA(49,16) = 0.815152;
MatrixA(49,17) = 1.02781;
MatrixA(49,20) = 0.815535;
MatrixA(49,21) = 1.0272;
MatrixA(49,24) = 13.5177;
MatrixA(49,26) = 13.5066;
MatrixA(49,28) = -768.908;
MatrixA(49,30) = -769.54;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 271.225;
MatrixA(49,37) = 0.0178912;
MatrixA(49,38) = 8.70219;
MatrixA(49,39) = 267.483;
MatrixA(49,40) = -230.104;
MatrixA(49,41) = -8.56695;
MatrixA(49,42) = 0.000283922;
MatrixA(49,43) = 3.2214;
MatrixA(49,44) = 5.35429;
MatrixA(49,45) = 5.35432;
MatrixA(49,46) = -8.57305;
MatrixA(49,47) = 33.4048;
MatrixA(49,48) = -2.83603;
MatrixA(49,49) = -116.226;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 0.000227362;
MatrixA(50,2) = 0.000227362;
MatrixA(50,3) = 0.000227362;
MatrixA(50,4) = 0.000227362;
MatrixA(50,5) = 0.000227362;
MatrixA(50,6) = 0.000227362;
MatrixA(50,7) = 0.000227362;
MatrixA(50,8) = 0.000227362;
MatrixA(50,9) = 0.000227362;
MatrixA(50,10) = 0.000227362;
MatrixA(50,11) = 0.000227362;
MatrixA(50,12) = 0.000227362;
MatrixA(50,13) = 0.000227362;
MatrixA(50,14) = 0.000227362;
MatrixA(50,15) = 0.000227362;
MatrixA(50,16) = 0.000227362;
MatrixA(50,17) = 0.000227362;
MatrixA(50,18) = 0.000227362;
MatrixA(50,19) = 0.000227362;
MatrixA(50,20) = 0.000227362;
MatrixA(50,21) = 0.000227362;
MatrixA(50,22) = 0.000227362;
MatrixA(50,23) = 0.000227362;
MatrixA(50,24) = 0.000227362;
MatrixA(50,25) = 0.000227362;
MatrixA(50,26) = 0.000227362;
MatrixA(50,27) = 0.000227362;
MatrixA(50,28) = 0.000227362;
MatrixA(50,29) = 0.000227362;
MatrixA(50,30) = 0.000227362;
MatrixA(50,31) = 0.000227362;
MatrixA(50,32) = 0.000227362;
MatrixA(50,33) = 0.000227362;
MatrixA(50,34) = 0.000227362;
MatrixA(50,35) = 0.000227362;
MatrixA(50,36) = -1222.18;
MatrixA(50,37) = 0.000227362;
MatrixA(50,38) = -39.2422;
MatrixA(50,39) = 0.000227362;
MatrixA(50,40) = 0.000227362;
MatrixA(50,41) = 0.000227362;
MatrixA(50,42) = 0.000227362;
MatrixA(50,43) = 0.000227362;
MatrixA(50,44) = 0.000227362;
MatrixA(50,45) = 0.124854;
MatrixA(50,46) = 0.124854;
MatrixA(50,47) = 0.000227362;
MatrixA(50,48) = 0.000227362;
MatrixA(50,49) = 0.124854;
MatrixA(50,50) = -4.22606;
MatrixA(50,51) = 0.000227362;
MatrixA(50,52) = 2.65688;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 62.2079;
MatrixA(51,52) = -95.1447;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 101.98;
MatrixA(52,52) = -155.975;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 0.000227362;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0387525;
MatrixC(2,2) = 0.107719;
MatrixC(2,3) = -2.96181;
MatrixC(2,6) = 0.00470969;
MatrixC(2,7) = -1.80921e-12;
MatrixC(2,8) = -1.83756;
MatrixC(2,9) = 0.00823139;
MatrixC(2,12) = -1.10096;
MatrixC(2,13) = 0.0303967;
MatrixC(2,16) = -33.3883;
MatrixC(2,17) = -4.02327e-05;
MatrixC(2,20) = -33.3829;
MatrixC(2,21) = -4.01988e-05;
MatrixC(2,24) = -11.5794;
MatrixC(2,26) = -11.5735;
MatrixC(2,28) = -11.6328;
MatrixC(2,30) = -11.6387;
MatrixC(2,32) = 2.1684e-16;
MatrixC(2,35) = -6.50521e-16;
MatrixC(2,36) = 1.42175e-05;
MatrixC(2,37) = -0.0234231;
MatrixC(2,38) = 4.89936e-05;
MatrixC(2,39) = 0.00192103;
MatrixC(2,40) = -1.53143e-05;
MatrixC(2,41) = -0.0017041;
MatrixC(2,42) = 0.000197808;
MatrixC(2,43) = 4.2791e-07;
MatrixC(2,44) = -2.79283e-06;
MatrixC(2,45) = -2.79342e-06;
MatrixC(2,46) = -0.000189564;
MatrixC(2,47) = 1.15427e-06;
MatrixC(2,48) = -1.75037e-06;
MatrixC(2,49) = -1.75428e-06;
MatrixC(2,52) = -2.1684e-16;

MatrixD = zeros(2, 1);
