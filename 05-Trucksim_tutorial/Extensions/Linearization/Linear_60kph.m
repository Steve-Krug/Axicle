% MATLAB linearized TruckSim 2023.0 model, calculated at t = 140.008 s.
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

MatrixA(1,2) = -16.6647;
MatrixA(1,3) = -0.00027703;
MatrixA(1,36) = -0.0321287;
MatrixA(1,37) = 0.00213652;
MatrixA(1,38) = 0.999481;
MatrixA(1,39) = 0.00275611;
MatrixA(1,40) = -1.26202;
MatrixA(1,41) = 0.00181604;
MatrixA(2,3) = 2.33196e-05;
MatrixA(2,39) = -0.00213763;
MatrixA(2,40) = 0.999998;
MatrixA(3,2) = -2.3345e-05;
MatrixA(3,3) = 3.27247e-08;
MatrixA(3,39) = 0.0321452;
MatrixA(3,40) = 6.87145e-05;
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
MatrixA(16,1) = -1.80595e-07;
MatrixA(16,2) = -7.54578e-05;
MatrixA(16,3) = 3.41936e-06;
MatrixA(16,6) = -1.37346;
MatrixA(16,7) = -0.000828747;
MatrixA(16,8) = 0.772326;
MatrixA(16,9) = -1.32658e-06;
MatrixA(16,16) = -23.2755;
MatrixA(16,36) = 8.13934e-07;
MatrixA(16,37) = 1.39421;
MatrixA(16,38) = -0.00298028;
MatrixA(16,39) = 1.81563;
MatrixA(16,40) = 0.00388045;
MatrixA(16,41) = 1.12711;
MatrixA(16,42) = 0.460681;
MatrixA(16,43) = 3.97416e-06;
MatrixA(17,1) = 9.99903e-06;
MatrixA(17,2) = 0.0357602;
MatrixA(17,3) = 8.7976e-06;
MatrixA(17,6) = 0.000110517;
MatrixA(17,7) = -0.00356282;
MatrixA(17,8) = 1.56858e-05;
MatrixA(17,9) = 6.23778e-06;
MatrixA(17,17) = -69.6408;
MatrixA(17,36) = -4.2797;
MatrixA(17,37) = -0.000277184;
MatrixA(17,38) = -0.137606;
MatrixA(17,39) = 3.74317;
MatrixA(17,40) = 3.64873;
MatrixA(17,41) = -0.120533;
MatrixA(17,42) = -0.120385;
MatrixA(17,43) = -0.137607;
MatrixA(17,44) = 1.68277;
MatrixA(20,1) = -1.80783e-07;
MatrixA(20,2) = -7.54719e-05;
MatrixA(20,3) = 3.58699e-06;
MatrixA(20,6) = -1.37368;
MatrixA(20,7) = -0.000828943;
MatrixA(20,8) = 0.722918;
MatrixA(20,9) = -1.32699e-06;
MatrixA(20,20) = -23.2798;
MatrixA(20,36) = 8.14088e-07;
MatrixA(20,37) = 1.39447;
MatrixA(20,38) = -0.00298083;
MatrixA(20,39) = 1.81597;
MatrixA(20,40) = 0.00388118;
MatrixA(20,41) = 1.12732;
MatrixA(20,42) = 0.460767;
MatrixA(20,43) = 3.9749e-06;
MatrixA(21,1) = 1.00179e-05;
MatrixA(21,2) = 0.0357381;
MatrixA(21,3) = -9.67655e-06;
MatrixA(21,6) = 0.00011044;
MatrixA(21,7) = 0.00356078;
MatrixA(21,8) = 7.42249e-06;
MatrixA(21,9) = 6.25939e-06;
MatrixA(21,21) = -69.5958;
MatrixA(21,36) = -4.27703;
MatrixA(21,37) = -0.000277011;
MatrixA(21,38) = -0.13752;
MatrixA(21,39) = -3.7459;
MatrixA(21,40) = 3.63044;
MatrixA(21,41) = 0.120206;
MatrixA(21,42) = 0.120354;
MatrixA(21,43) = -0.137521;
MatrixA(21,45) = 1.68171;
MatrixA(24,1) = -3.29764e-06;
MatrixA(24,2) = 0.00132128;
MatrixA(24,3) = -1.91003e-06;
MatrixA(24,12) = 1.90441;
MatrixA(24,13) = -1.50736e-05;
MatrixA(24,24) = -54.2589;
MatrixA(24,36) = -1.35247e-05;
MatrixA(24,37) = 3.2501;
MatrixA(24,38) = -0.00694795;
MatrixA(24,39) = -6.78316;
MatrixA(24,40) = -0.0144884;
MatrixA(24,41) = 2.98156;
MatrixA(24,46) = 1.59023;
MatrixA(24,47) = -5.47064e-05;
MatrixA(26,1) = -3.30013e-06;
MatrixA(26,2) = 0.00132234;
MatrixA(26,3) = -2.95056e-06;
MatrixA(26,12) = 1.97276;
MatrixA(26,13) = -1.50828e-05;
MatrixA(26,26) = -54.2862;
MatrixA(26,36) = -1.35315e-05;
MatrixA(26,37) = 3.25174;
MatrixA(26,38) = -0.00695145;
MatrixA(26,39) = -6.78657;
MatrixA(26,40) = -0.0144957;
MatrixA(26,41) = 2.98306;
MatrixA(26,46) = 1.59103;
MatrixA(26,47) = -5.47339e-05;
MatrixA(28,1) = -3.28387e-06;
MatrixA(28,2) = 0.00131541;
MatrixA(28,3) = 2.73872e-06;
MatrixA(28,12) = 1.5987;
MatrixA(28,13) = -1.50229e-05;
MatrixA(28,28) = -54.1075;
MatrixA(28,36) = -1.3487e-05;
MatrixA(28,37) = 3.24104;
MatrixA(28,38) = -0.00692858;
MatrixA(28,39) = -6.76427;
MatrixA(28,40) = -0.0144481;
MatrixA(28,41) = 2.97325;
MatrixA(28,46) = 1.5858;
MatrixA(28,47) = -5.45538e-05;
MatrixA(30,1) = -3.2814e-06;
MatrixA(30,2) = 0.00131436;
MatrixA(30,3) = 3.41662e-06;
MatrixA(30,12) = 1.55406;
MatrixA(30,13) = -1.50138e-05;
MatrixA(30,30) = -54.0803;
MatrixA(30,36) = -1.34803e-05;
MatrixA(30,37) = 3.23941;
MatrixA(30,38) = -0.0069251;
MatrixA(30,39) = -6.76088;
MatrixA(30,40) = -0.0144408;
MatrixA(30,41) = 2.97176;
MatrixA(30,46) = 1.585;
MatrixA(30,47) = -5.45265e-05;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 80.8075;
MatrixA(36,2) = 246.972;
MatrixA(36,3) = 0.149771;
MatrixA(36,6) = 7.42013e-06;
MatrixA(36,7) = 8.19034e-07;
MatrixA(36,8) = 1.47296;
MatrixA(36,9) = -11.1701;
MatrixA(36,12) = 12.79;
MatrixA(36,13) = 144.026;
MatrixA(36,16) = 4.03064;
MatrixA(36,17) = 13.769;
MatrixA(36,20) = 4.03304;
MatrixA(36,21) = 13.7582;
MatrixA(36,24) = 2.81058;
MatrixA(36,26) = 2.80759;
MatrixA(36,28) = 2.8074;
MatrixA(36,30) = 2.8104;
MatrixA(36,32) = -0.00367887;
MatrixA(36,35) = 0.00367887;
MatrixA(36,36) = -4.92167;
MatrixA(36,37) = -0.000352142;
MatrixA(36,38) = -0.158209;
MatrixA(36,39) = -0.00919873;
MatrixA(36,40) = 3.6449;
MatrixA(36,41) = 3.78049e-05;
MatrixA(36,42) = -4.4984e-05;
MatrixA(36,43) = -0.306131;
MatrixA(36,44) = 0.4445;
MatrixA(36,45) = 0.444648;
MatrixA(36,46) = 3.77986e-07;
MatrixA(36,47) = 0.540899;
MatrixA(36,48) = 0.52055;
MatrixA(36,49) = 0.522918;
MatrixA(36,52) = -0.000117102;
MatrixA(37,1) = 0.0010255;
MatrixA(37,2) = -0.0198499;
MatrixA(37,3) = 97.9565;
MatrixA(37,6) = 0.0099212;
MatrixA(37,7) = 0.00492678;
MatrixA(37,8) = -165.33;
MatrixA(37,9) = 11.3473;
MatrixA(37,12) = 212.257;
MatrixA(37,13) = -2.23795;
MatrixA(37,16) = -37.9963;
MatrixA(37,17) = -0.196047;
MatrixA(37,20) = -37.8726;
MatrixA(37,21) = 0.1957;
MatrixA(37,24) = -8.4584;
MatrixA(37,26) = -8.45364;
MatrixA(37,28) = -8.26503;
MatrixA(37,30) = -8.26954;
MatrixA(37,32) = -0.00479279;
MatrixA(37,35) = 0.00479279;
MatrixA(37,36) = 0.000441668;
MatrixA(37,37) = -0.019414;
MatrixA(37,38) = 5.5644e-05;
MatrixA(37,39) = -16.7595;
MatrixA(37,40) = -0.000577525;
MatrixA(37,41) = 0.528155;
MatrixA(37,42) = -1.06327;
MatrixA(37,43) = 0.0136023;
MatrixA(37,44) = -0.00228542;
MatrixA(37,45) = 0.0103649;
MatrixA(37,46) = 0.267033;
MatrixA(37,47) = 0.0107496;
MatrixA(37,48) = -0.025427;
MatrixA(37,49) = 0.0178085;
MatrixA(37,52) = -0.000152559;
MatrixA(38,1) = -8.3543;
MatrixA(38,2) = -28.0584;
MatrixA(38,3) = -0.190446;
MatrixA(38,6) = -2.12057e-05;
MatrixA(38,7) = -1.0573e-05;
MatrixA(38,8) = -36.0373;
MatrixA(38,9) = 569.47;
MatrixA(38,12) = 76.1848;
MatrixA(38,13) = 411.236;
MatrixA(38,16) = 0.129496;
MatrixA(38,17) = 0.164111;
MatrixA(38,20) = 0.129245;
MatrixA(38,21) = 0.163094;
MatrixA(38,24) = -0.309398;
MatrixA(38,26) = -0.309059;
MatrixA(38,28) = -0.309413;
MatrixA(38,30) = -0.309753;
MatrixA(38,32) = 0.000292739;
MatrixA(38,35) = -0.000292739;
MatrixA(38,36) = 0.286234;
MatrixA(38,37) = 9.4522e-06;
MatrixA(38,38) = 0.00920173;
MatrixA(38,39) = 0.00114547;
MatrixA(38,40) = 16.4158;
MatrixA(38,41) = -0.00116591;
MatrixA(38,42) = 0.00312456;
MatrixA(38,43) = 6.84059;
MatrixA(38,44) = 0.00527873;
MatrixA(38,45) = 0.00525179;
MatrixA(38,46) = -0.000538438;
MatrixA(38,47) = 5.48136;
MatrixA(38,48) = -0.0605803;
MatrixA(38,49) = -0.0609433;
MatrixA(38,52) = 9.31818e-06;
MatrixA(39,1) = 0.025363;
MatrixA(39,2) = 0.0672948;
MatrixA(39,3) = -221.019;
MatrixA(39,6) = 0.00525193;
MatrixA(39,7) = 0.00340223;
MatrixA(39,8) = -77.3143;
MatrixA(39,9) = 4.33313;
MatrixA(39,12) = -200.833;
MatrixA(39,13) = 4.51661;
MatrixA(39,16) = -20.5787;
MatrixA(39,17) = -4.42323;
MatrixA(39,20) = -17.9818;
MatrixA(39,21) = 4.41933;
MatrixA(39,24) = 6.26396;
MatrixA(39,26) = 6.26099;
MatrixA(39,28) = 8.29645;
MatrixA(39,30) = 8.30155;
MatrixA(39,32) = -0.0061325;
MatrixA(39,35) = 0.0061325;
MatrixA(39,36) = -0.00310653;
MatrixA(39,37) = -0.00177356;
MatrixA(39,38) = -9.60723e-05;
MatrixA(39,39) = -1.4429;
MatrixA(39,40) = -0.00044293;
MatrixA(39,41) = -0.0765196;
MatrixA(39,42) = -0.437918;
MatrixA(39,43) = 0.00711753;
MatrixA(39,44) = -0.143032;
MatrixA(39,45) = 0.142511;
MatrixA(39,46) = -0.476626;
MatrixA(39,47) = -0.00953446;
MatrixA(39,48) = -0.184277;
MatrixA(39,49) = 0.18682;
MatrixA(39,52) = -0.000195203;
MatrixA(40,1) = -22.4194;
MatrixA(40,2) = -70.1284;
MatrixA(40,3) = -0.468676;
MatrixA(40,6) = 9.02584e-06;
MatrixA(40,7) = 7.06354e-06;
MatrixA(40,8) = 17.0138;
MatrixA(40,9) = -270.429;
MatrixA(40,12) = 57.2107;
MatrixA(40,13) = 293.885;
MatrixA(40,16) = -0.640967;
MatrixA(40,17) = -2.04934;
MatrixA(40,20) = -0.635915;
MatrixA(40,21) = -2.02932;
MatrixA(40,24) = -0.808241;
MatrixA(40,26) = -0.807373;
MatrixA(40,28) = -0.80308;
MatrixA(40,30) = -0.803947;
MatrixA(40,32) = -0.0403601;
MatrixA(40,35) = 0.0403601;
MatrixA(40,36) = 1.10858;
MatrixA(40,37) = 7.33422e-05;
MatrixA(40,38) = 0.0356364;
MatrixA(40,39) = -0.000295246;
MatrixA(40,40) = -0.944152;
MatrixA(40,41) = -0.000187648;
MatrixA(40,42) = -0.00122489;
MatrixA(40,43) = -3.22315;
MatrixA(40,44) = -0.0648239;
MatrixA(40,45) = -0.0642514;
MatrixA(40,46) = -0.000866168;
MatrixA(40,47) = 4.19563;
MatrixA(40,48) = -0.151104;
MatrixA(40,49) = -0.151022;
MatrixA(40,52) = -0.0012847;
MatrixA(41,1) = 0.00448969;
MatrixA(41,2) = -0.0113162;
MatrixA(41,3) = 114.315;
MatrixA(41,6) = 0.0109544;
MatrixA(41,7) = 0.00536185;
MatrixA(41,8) = 145.135;
MatrixA(41,9) = -34.708;
MatrixA(41,12) = 505.444;
MatrixA(41,13) = -48.7299;
MatrixA(41,16) = -41.9074;
MatrixA(41,17) = 0.207645;
MatrixA(41,20) = -42.0194;
MatrixA(41,21) = -0.207698;
MatrixA(41,24) = -9.03543;
MatrixA(41,26) = -9.03041;
MatrixA(41,28) = -9.01598;
MatrixA(41,30) = -9.02094;
MatrixA(41,32) = 0.0595176;
MatrixA(41,35) = -0.0595176;
MatrixA(41,36) = 0.000527548;
MatrixA(41,37) = -0.0134961;
MatrixA(41,38) = 4.58447e-05;
MatrixA(41,39) = 0.0352169;
MatrixA(41,40) = -0.000377763;
MatrixA(41,41) = -0.000396504;
MatrixA(41,42) = 3.75707;
MatrixA(41,43) = 0.0150144;
MatrixA(41,44) = 0.00900298;
MatrixA(41,45) = -0.00440925;
MatrixA(41,46) = 4.27396;
MatrixA(41,47) = 0.0116431;
MatrixA(41,48) = -0.0120444;
MatrixA(41,49) = -0.000524325;
MatrixA(41,52) = 0.0018945;
MatrixA(42,1) = 0.105725;
MatrixA(42,2) = -0.0227074;
MatrixA(42,3) = -11480.6;
MatrixA(42,6) = 0.706191;
MatrixA(42,7) = 0.590856;
MatrixA(42,8) = -17500;
MatrixA(42,9) = 892.998;
MatrixA(42,12) = -420.154;
MatrixA(42,13) = 40.0718;
MatrixA(42,16) = -575.843;
MatrixA(42,17) = 17.5627;
MatrixA(42,20) = -586.002;
MatrixA(42,21) = -17.553;
MatrixA(42,24) = 6.97811;
MatrixA(42,26) = 6.97454;
MatrixA(42,28) = 8.19548;
MatrixA(42,30) = 8.20031;
MatrixA(42,32) = -0.643466;
MatrixA(42,35) = 0.643466;
MatrixA(42,36) = -0.00052189;
MatrixA(42,37) = 0.00116865;
MatrixA(42,38) = -1.89027e-05;
MatrixA(42,39) = 12.0904;
MatrixA(42,40) = 0.0263141;
MatrixA(42,41) = -0.139922;
MatrixA(42,42) = -93.4301;
MatrixA(42,43) = -0.0121928;
MatrixA(42,44) = 0.836535;
MatrixA(42,45) = -0.29742;
MatrixA(42,46) = -3.5317;
MatrixA(42,47) = -0.00994779;
MatrixA(42,48) = -0.337194;
MatrixA(42,49) = -0.117752;
MatrixA(42,52) = -0.0204822;
MatrixA(43,1) = -3793.43;
MatrixA(43,2) = -12.2554;
MatrixA(43,3) = 1.74327;
MatrixA(43,6) = 9.589e-05;
MatrixA(43,7) = 6.1413e-05;
MatrixA(43,8) = 455.202;
MatrixA(43,9) = -10946.8;
MatrixA(43,12) = -2.84754;
MatrixA(43,13) = -32.0773;
MatrixA(43,16) = 0.883598;
MatrixA(43,17) = 3.09648;
MatrixA(43,20) = 0.88275;
MatrixA(43,21) = 3.08931;
MatrixA(43,24) = -0.722387;
MatrixA(43,26) = -0.721613;
MatrixA(43,28) = -0.721621;
MatrixA(43,30) = -0.722398;
MatrixA(43,32) = -0.0524638;
MatrixA(43,35) = 0.0524638;
MatrixA(43,36) = 0.176527;
MatrixA(43,37) = 8.22596e-05;
MatrixA(43,38) = 0.005677;
MatrixA(43,39) = 0.00308955;
MatrixA(43,40) = -0.155591;
MatrixA(43,41) = -0.000392146;
MatrixA(43,42) = -0.024945;
MatrixA(43,43) = -86.2172;
MatrixA(43,44) = 0.101671;
MatrixA(43,45) = 0.101551;
MatrixA(43,46) = -0.00460795;
MatrixA(43,47) = -0.0690074;
MatrixA(43,48) = -0.133806;
MatrixA(43,49) = -0.134442;
MatrixA(43,52) = -0.00166997;
MatrixA(44,1) = 247.657;
MatrixA(44,2) = 65.3811;
MatrixA(44,3) = 182.147;
MatrixA(44,6) = -0.0134708;
MatrixA(44,7) = 0.167646;
MatrixA(44,8) = 165.276;
MatrixA(44,9) = 495.555;
MatrixA(44,12) = -57.6408;
MatrixA(44,13) = -293.875;
MatrixA(44,16) = -709.699;
MatrixA(44,17) = -2422.39;
MatrixA(44,20) = 9.28866;
MatrixA(44,21) = 31.6548;
MatrixA(44,24) = 0.821654;
MatrixA(44,26) = 0.820779;
MatrixA(44,28) = 0.820838;
MatrixA(44,30) = 0.821715;
MatrixA(44,32) = 10.1513;
MatrixA(44,35) = -10.1513;
MatrixA(44,36) = 195.472;
MatrixA(44,37) = 0.0126506;
MatrixA(44,38) = 6.28301;
MatrixA(44,39) = -176.088;
MatrixA(44,40) = -166.558;
MatrixA(44,41) = 5.67158;
MatrixA(44,42) = 5.66542;
MatrixA(44,43) = 9.54183;
MatrixA(44,44) = -83.8574;
MatrixA(44,45) = -2.54142;
MatrixA(44,46) = -0.000156917;
MatrixA(44,47) = -4.19564;
MatrixA(44,48) = 4.11037;
MatrixA(44,49) = 4.11109;
MatrixA(44,52) = 0.323127;
MatrixA(45,1) = 247.721;
MatrixA(45,2) = 65.3798;
MatrixA(45,3) = -224.146;
MatrixA(45,6) = 0.013913;
MatrixA(45,7) = -0.167697;
MatrixA(45,8) = -241.017;
MatrixA(45,9) = 495.619;
MatrixA(45,12) = -57.6408;
MatrixA(45,13) = -293.875;
MatrixA(45,16) = 9.2838;
MatrixA(45,17) = 31.6818;
MatrixA(45,20) = -710.052;
MatrixA(45,21) = -2420.26;
MatrixA(45,24) = 0.821654;
MatrixA(45,26) = 0.820779;
MatrixA(45,28) = 0.820838;
MatrixA(45,30) = 0.821715;
MatrixA(45,32) = 10.1513;
MatrixA(45,35) = -10.1513;
MatrixA(45,36) = 195.52;
MatrixA(45,37) = 0.0126537;
MatrixA(45,38) = 6.28455;
MatrixA(45,39) = 176.458;
MatrixA(45,40) = -165.845;
MatrixA(45,41) = -5.66117;
MatrixA(45,42) = -5.66732;
MatrixA(45,43) = 9.54336;
MatrixA(45,44) = -2.54169;
MatrixA(45,45) = -83.8759;
MatrixA(45,46) = -0.000156917;
MatrixA(45,47) = -4.19564;
MatrixA(45,48) = 4.11037;
MatrixA(45,49) = 4.11109;
MatrixA(45,52) = 0.323127;
MatrixA(46,1) = 0.246379;
MatrixA(46,2) = 0.993428;
MatrixA(46,3) = -27712.5;
MatrixA(46,6) = -0.0124895;
MatrixA(46,7) = -0.00539538;
MatrixA(46,8) = -170.477;
MatrixA(46,9) = 40.125;
MatrixA(46,12) = -33349.8;
MatrixA(46,13) = 926.901;
MatrixA(46,16) = 47.3596;
MatrixA(46,17) = -4.14357;
MatrixA(46,20) = 49.7755;
MatrixA(46,21) = 4.13577;
MatrixA(46,24) = -287.437;
MatrixA(46,26) = -287.283;
MatrixA(46,28) = -296.649;
MatrixA(46,30) = -296.812;
MatrixA(46,32) = -0.677374;
MatrixA(46,35) = 0.677374;
MatrixA(46,36) = 0.0114159;
MatrixA(46,37) = 0.0226954;
MatrixA(46,38) = 0.00031872;
MatrixA(46,39) = 10.6587;
MatrixA(46,40) = 0.012956;
MatrixA(46,41) = -0.20173;
MatrixA(46,42) = -4.38463;
MatrixA(46,43) = -0.0169931;
MatrixA(46,44) = -0.374736;
MatrixA(46,45) = -0.10738;
MatrixA(46,46) = -79.907;
MatrixA(46,47) = -0.0127456;
MatrixA(46,48) = 1.01019;
MatrixA(46,49) = -0.444173;
MatrixA(46,52) = -0.0215615;
MatrixA(47,1) = -6554.31;
MatrixA(47,2) = -22146.3;
MatrixA(47,3) = 11.2399;
MatrixA(47,6) = -3.15293e-06;
MatrixA(47,7) = -3.05493e-06;
MatrixA(47,8) = 0.997234;
MatrixA(47,9) = -15.2174;
MatrixA(47,12) = -942.575;
MatrixA(47,13) = -11709.7;
MatrixA(47,16) = 0.763489;
MatrixA(47,17) = 2.52148;
MatrixA(47,20) = 0.764008;
MatrixA(47,21) = 2.5198;
MatrixA(47,24) = 6.41558;
MatrixA(47,26) = 6.40879;
MatrixA(47,28) = 6.41013;
MatrixA(47,30) = 6.41694;
MatrixA(47,32) = 0.0817631;
MatrixA(47,35) = -0.0817631;
MatrixA(47,36) = -6.40689;
MatrixA(47,37) = -0.000383298;
MatrixA(47,38) = -0.205962;
MatrixA(47,39) = -0.0211121;
MatrixA(47,40) = 5.44795;
MatrixA(47,41) = -0.000292779;
MatrixA(47,42) = -0.00278483;
MatrixA(47,43) = -0.216158;
MatrixA(47,44) = 0.0787595;
MatrixA(47,45) = 0.078796;
MatrixA(47,46) = 0.0120262;
MatrixA(47,47) = -67.9684;
MatrixA(47,48) = 1.17219;
MatrixA(47,49) = 1.17779;
MatrixA(47,52) = 0.0026026;
MatrixA(48,1) = 870.178;
MatrixA(48,2) = 2945.81;
MatrixA(48,3) = 823.63;
MatrixA(48,6) = 2.11547e-06;
MatrixA(48,7) = 1.53869e-07;
MatrixA(48,8) = -17.1777;
MatrixA(48,9) = 270.437;
MatrixA(48,12) = 767.271;
MatrixA(48,13) = 550.539;
MatrixA(48,16) = 0.59731;
MatrixA(48,17) = 2.03995;
MatrixA(48,20) = 0.597767;
MatrixA(48,21) = 2.0387;
MatrixA(48,24) = -680.814;
MatrixA(48,26) = -680.089;
MatrixA(48,28) = 11.9632;
MatrixA(48,30) = 11.976;
MatrixA(48,32) = 13.5204;
MatrixA(48,35) = -13.5204;
MatrixA(48,36) = 314.782;
MatrixA(48,37) = 0.0214655;
MatrixA(48,38) = 10.1194;
MatrixA(48,39) = -309.871;
MatrixA(48,40) = -268.348;
MatrixA(48,41) = 9.97854;
MatrixA(48,42) = 0.000295901;
MatrixA(48,43) = 3.22316;
MatrixA(48,44) = 5.34358;
MatrixA(48,45) = 5.34361;
MatrixA(48,46) = 9.97125;
MatrixA(48,47) = 39.3971;
MatrixA(48,48) = -133.666;
MatrixA(48,49) = -2.51158;
MatrixA(48,52) = 0.430367;
MatrixA(49,1) = 866.43;
MatrixA(49,2) = 2932.81;
MatrixA(49,3) = -839.355;
MatrixA(49,6) = 2.11547e-06;
MatrixA(49,7) = 1.53869e-07;
MatrixA(49,8) = -17.1777;
MatrixA(49,9) = 270.437;
MatrixA(49,12) = -895.718;
MatrixA(49,13) = 546.805;
MatrixA(49,16) = 0.59731;
MatrixA(49,17) = 2.03995;
MatrixA(49,20) = 0.597767;
MatrixA(49,21) = 2.0387;
MatrixA(49,24) = 11.9778;
MatrixA(49,26) = 11.9651;
MatrixA(49,28) = -679.974;
MatrixA(49,30) = -680.702;
MatrixA(49,32) = 13.5204;
MatrixA(49,35) = -13.5204;
MatrixA(49,36) = 316.232;
MatrixA(49,37) = 0.0215644;
MatrixA(49,38) = 10.166;
MatrixA(49,39) = 311.759;
MatrixA(49,40) = -268.253;
MatrixA(49,41) = -10.0039;
MatrixA(49,42) = 0.000295901;
MatrixA(49,43) = 3.22316;
MatrixA(49,44) = 5.34358;
MatrixA(49,45) = 5.34361;
MatrixA(49,46) = -10.0112;
MatrixA(49,47) = 39.5973;
MatrixA(49,48) = -2.52148;
MatrixA(49,49) = -134.227;
MatrixA(49,52) = 0.430367;
MatrixA(50,1) = 0.000299767;
MatrixA(50,2) = 0.000299767;
MatrixA(50,3) = 0.000299767;
MatrixA(50,4) = 0.000299767;
MatrixA(50,5) = 0.000299767;
MatrixA(50,6) = 0.000299767;
MatrixA(50,7) = 0.000299767;
MatrixA(50,8) = 0.000299767;
MatrixA(50,9) = 0.000299767;
MatrixA(50,10) = 0.000299767;
MatrixA(50,11) = 0.000299767;
MatrixA(50,12) = 0.000299767;
MatrixA(50,13) = 0.000299767;
MatrixA(50,14) = 0.000299767;
MatrixA(50,15) = 0.000299767;
MatrixA(50,16) = 0.000299767;
MatrixA(50,17) = 0.000299767;
MatrixA(50,18) = 0.000299767;
MatrixA(50,19) = 0.000299767;
MatrixA(50,20) = 0.000299767;
MatrixA(50,21) = 0.000299767;
MatrixA(50,22) = 0.000299767;
MatrixA(50,23) = 0.000299767;
MatrixA(50,24) = 0.000299767;
MatrixA(50,25) = 0.000299767;
MatrixA(50,26) = 0.000299767;
MatrixA(50,27) = 0.000299767;
MatrixA(50,28) = 0.000299767;
MatrixA(50,29) = 0.000299767;
MatrixA(50,30) = 0.000299767;
MatrixA(50,31) = 0.000299767;
MatrixA(50,32) = 0.000299767;
MatrixA(50,33) = 0.000299767;
MatrixA(50,34) = 0.000299767;
MatrixA(50,35) = 0.000299767;
MatrixA(50,36) = -1171.38;
MatrixA(50,37) = 0.000299767;
MatrixA(50,38) = -37.689;
MatrixA(50,39) = 0.000299767;
MatrixA(50,40) = 0.000299767;
MatrixA(50,41) = 0.000299767;
MatrixA(50,42) = 0.000299767;
MatrixA(50,43) = 0.000299767;
MatrixA(50,44) = 0.000299767;
MatrixA(50,45) = 0.144127;
MatrixA(50,46) = 0.144127;
MatrixA(50,47) = 0.000299767;
MatrixA(50,48) = 0.000299767;
MatrixA(50,49) = 0.144127;
MatrixA(50,50) = -2.99815;
MatrixA(50,51) = 0.000299767;
MatrixA(50,52) = 2.07075;
MatrixA(51,32) = -1920.52;
MatrixA(51,35) = 1920.52;
MatrixA(51,44) = 62.6604;
MatrixA(51,45) = 62.6604;
MatrixA(51,48) = 62.6604;
MatrixA(51,49) = 62.6604;
MatrixA(51,50) = 52.0864;
MatrixA(51,52) = -88.7305;
MatrixA(52,32) = -3148.4;
MatrixA(52,35) = 3148.4;
MatrixA(52,44) = 102.722;
MatrixA(52,45) = 102.722;
MatrixA(52,48) = 102.722;
MatrixA(52,49) = 102.722;
MatrixA(52,50) = 85.3875;
MatrixA(52,52) = -145.46;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;
MatrixB(50,1) = 0.000299767;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = 0.0304896;
MatrixC(2,2) = 0.0852133;
MatrixC(2,3) = -2.97263;
MatrixC(2,6) = 0.00421726;
MatrixC(2,7) = -4.6245e-12;
MatrixC(2,8) = -1.85488;
MatrixC(2,9) = 0.0063057;
MatrixC(2,12) = -1.10057;
MatrixC(2,13) = 0.0240853;
MatrixC(2,16) = -34.1063;
MatrixC(2,17) = -8.28629e-05;
MatrixC(2,20) = -34.0983;
MatrixC(2,21) = -8.27909e-05;
MatrixC(2,24) = -12.0154;
MatrixC(2,26) = -12.0087;
MatrixC(2,28) = -12.0722;
MatrixC(2,30) = -12.0789;
MatrixC(2,32) = 5.96311e-16;
MatrixC(2,35) = -5.96311e-16;
MatrixC(2,36) = 1.11379e-05;
MatrixC(2,37) = -0.0200764;
MatrixC(2,38) = 4.33075e-05;
MatrixC(2,39) = 0.0016462;
MatrixC(2,40) = -1.29752e-05;
MatrixC(2,41) = -0.00146057;
MatrixC(2,42) = 0.000169691;
MatrixC(2,43) = 3.40682e-07;
MatrixC(2,44) = -2.26198e-06;
MatrixC(2,45) = -2.26374e-06;
MatrixC(2,46) = -0.000162577;
MatrixC(2,47) = 1.04403e-06;
MatrixC(2,48) = -1.59677e-06;
MatrixC(2,49) = -1.59792e-06;
MatrixC(2,52) = 1.0842e-16;

MatrixD = zeros(2, 1);
