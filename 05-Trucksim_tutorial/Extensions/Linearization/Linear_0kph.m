% MATLAB linearized TruckSim 2023.0 model, calculated at t = 20.0015 s.
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

MatrixA(1,2) = -0.58066;
MatrixA(1,3) = -8.81942e-06;
MatrixA(1,36) = -0.0336139;
MatrixA(1,37) = 0.00016935;
MatrixA(1,38) = 0.999435;
MatrixA(1,39) = 0.000218461;
MatrixA(1,40) = -1.2607;
MatrixA(1,41) = 0.000143947;
MatrixA(2,3) = -1.15048e-07;
MatrixA(2,39) = -0.000169445;
MatrixA(2,40) = 1;
MatrixA(3,2) = 1.15686e-07;
MatrixA(3,3) = -3.38757e-08;
MatrixA(3,39) = 0.0336329;
MatrixA(3,40) = 5.69895e-06;
MatrixA(3,41) = 1;
MatrixA(6,7) = 1;
MatrixA(7,6) = -238051;
MatrixA(7,7) = -884.904;
MatrixA(8,42) = 1;
MatrixA(9,43) = 1;
MatrixA(10,44) = 1;
MatrixA(11,45) = 1;
MatrixA(12,46) = 1;
MatrixA(13,47) = 1;
MatrixA(14,48) = 1;
MatrixA(15,49) = 1;
MatrixA(16,1) = 3.31186e-07;
MatrixA(16,2) = -1.41058e-05;
MatrixA(16,3) = -1.94073e-06;
MatrixA(16,6) = -0.0474874;
MatrixA(16,7) = -0.000775479;
MatrixA(16,8) = 0.0279254;
MatrixA(16,9) = 2.99784e-07;
MatrixA(16,16) = -0.804706;
MatrixA(16,36) = -3.87124e-07;
MatrixA(16,37) = 1.3834;
MatrixA(16,38) = -0.000234423;
MatrixA(16,39) = 1.80232;
MatrixA(16,40) = 0.000305724;
MatrixA(16,41) = 1.11539;
MatrixA(16,42) = 0.454121;
MatrixA(16,43) = 2.44414e-05;
MatrixA(17,1) = -6.13762e-05;
MatrixA(17,2) = 0.00415017;
MatrixA(17,3) = -5.34029e-05;
MatrixA(17,6) = 1.38063e-05;
MatrixA(17,7) = -0.0115666;
MatrixA(17,8) = -3.51975e-05;
MatrixA(17,9) = -4.67578e-05;
MatrixA(17,17) = -8.06568;
MatrixA(17,36) = -13.927;
MatrixA(17,37) = -7.36667e-05;
MatrixA(17,38) = -0.468406;
MatrixA(17,39) = 12.1852;
MatrixA(17,40) = 11.8412;
MatrixA(17,41) = -0.409886;
MatrixA(17,42) = -0.409846;
MatrixA(17,43) = -0.468406;
MatrixA(17,44) = 5.72771;
MatrixA(20,1) = 3.32204e-07;
MatrixA(20,2) = -1.41221e-05;
MatrixA(20,3) = -2.2951e-06;
MatrixA(20,6) = -0.0475411;
MatrixA(20,7) = -0.000776452;
MatrixA(20,8) = 0.0261844;
MatrixA(20,9) = 3.00763e-07;
MatrixA(20,20) = -0.805638;
MatrixA(20,36) = -3.8757e-07;
MatrixA(20,37) = 1.385;
MatrixA(20,38) = -0.000234695;
MatrixA(20,39) = 1.80441;
MatrixA(20,40) = 0.000306079;
MatrixA(20,41) = 1.11668;
MatrixA(20,42) = 0.454647;
MatrixA(20,43) = 2.44697e-05;
MatrixA(21,1) = -6.1531e-05;
MatrixA(21,2) = 0.00415571;
MatrixA(21,3) = 5.00881e-05;
MatrixA(21,6) = 1.38168e-05;
MatrixA(21,7) = 0.0120511;
MatrixA(21,8) = 4.33556e-05;
MatrixA(21,9) = -4.68945e-05;
MatrixA(21,21) = -8.0752;
MatrixA(21,36) = -13.9435;
MatrixA(21,37) = -7.37541e-05;
MatrixA(21,38) = -0.468961;
MatrixA(21,39) = -12.2015;
MatrixA(21,40) = 11.8511;
MatrixA(21,41) = 0.428667;
MatrixA(21,42) = 0.428708;
MatrixA(21,43) = -0.468961;
MatrixA(21,45) = 5.7345;
MatrixA(24,1) = -3.24505e-07;
MatrixA(24,2) = 2.46589e-05;
MatrixA(24,3) = 1.20972e-06;
MatrixA(24,12) = 0.069749;
MatrixA(24,13) = -2.88339e-07;
MatrixA(24,24) = -1.89872;
MatrixA(24,36) = 1.8708e-06;
MatrixA(24,37) = 3.26416;
MatrixA(24,38) = -0.000553034;
MatrixA(24,39) = -6.81159;
MatrixA(24,40) = -0.00115578;
MatrixA(24,41) = 3.00391;
MatrixA(24,46) = 1.60656;
MatrixA(24,47) = -2.81317e-05;
MatrixA(25,1) = 0.00206291;
MatrixA(25,2) = 0.020323;
MatrixA(25,3) = 0.00163202;
MatrixA(25,12) = 0.00166927;
MatrixA(25,13) = 0.00203154;
MatrixA(25,25) = -17.6927;
MatrixA(25,36) = -29.0256;
MatrixA(25,37) = -0.000156927;
MatrixA(25,38) = -1.01658;
MatrixA(25,39) = 23.3636;
MatrixA(25,40) = 24.6781;
MatrixA(25,41) = -0.818205;
MatrixA(25,46) = -0.818151;
MatrixA(25,47) = -4.06336;
MatrixA(25,48) = 11.4108;
MatrixA(26,1) = -3.2522e-07;
MatrixA(26,2) = 2.46666e-05;
MatrixA(26,3) = 1.15033e-06;
MatrixA(26,12) = 0.0722458;
MatrixA(26,13) = -2.8904e-07;
MatrixA(26,26) = -1.89923;
MatrixA(26,36) = 1.8713e-06;
MatrixA(26,37) = 3.26505;
MatrixA(26,38) = -0.000553184;
MatrixA(26,39) = -6.81343;
MatrixA(26,40) = -0.0011561;
MatrixA(26,41) = 3.00472;
MatrixA(26,46) = 1.60699;
MatrixA(26,47) = -2.81393e-05;
MatrixA(27,1) = 0.00206713;
MatrixA(27,2) = 0.0203445;
MatrixA(27,3) = 0.00228079;
MatrixA(27,12) = 0.0023283;
MatrixA(27,13) = 0.00203573;
MatrixA(27,27) = -17.6962;
MatrixA(27,36) = -29.0314;
MatrixA(27,37) = -0.000156958;
MatrixA(27,38) = -1.01678;
MatrixA(27,39) = 31.7874;
MatrixA(27,40) = 24.6845;
MatrixA(27,41) = -1.11355;
MatrixA(27,46) = -1.11349;
MatrixA(27,47) = -4.06417;
MatrixA(27,48) = 11.4131;
MatrixA(28,1) = -3.20556e-07;
MatrixA(28,2) = 2.46159e-05;
MatrixA(28,3) = 1.47021e-06;
MatrixA(28,12) = 0.0585761;
MatrixA(28,13) = -2.84466e-07;
MatrixA(28,28) = -1.89587;
MatrixA(28,36) = 1.86804e-06;
MatrixA(28,37) = 3.25927;
MatrixA(28,38) = -0.000552205;
MatrixA(28,39) = -6.80137;
MatrixA(28,40) = -0.00115405;
MatrixA(28,41) = 2.9994;
MatrixA(28,46) = 1.60415;
MatrixA(28,47) = -2.80895e-05;
MatrixA(29,1) = 0.00205917;
MatrixA(29,2) = 0.0202871;
MatrixA(29,3) = -0.00143314;
MatrixA(29,12) = -0.00144465;
MatrixA(29,13) = 0.00202784;
MatrixA(29,29) = -17.6728;
MatrixA(29,36) = -28.9931;
MatrixA(29,37) = -0.000156751;
MatrixA(29,38) = -1.01544;
MatrixA(29,39) = -23.3414;
MatrixA(29,40) = 24.6426;
MatrixA(29,41) = 0.784907;
MatrixA(29,46) = 0.784959;
MatrixA(29,47) = -4.05884;
MatrixA(29,49) = 11.3981;
MatrixA(30,1) = -3.19848e-07;
MatrixA(30,2) = 2.46081e-05;
MatrixA(30,3) = 1.50735e-06;
MatrixA(30,12) = 0.0569438;
MatrixA(30,13) = -2.83772e-07;
MatrixA(30,30) = -1.89536;
MatrixA(30,36) = 1.86754e-06;
MatrixA(30,37) = 3.25839;
MatrixA(30,38) = -0.000552056;
MatrixA(30,39) = -6.79953;
MatrixA(30,40) = -0.00115374;
MatrixA(30,41) = 2.99859;
MatrixA(30,46) = 1.60371;
MatrixA(30,47) = -2.80819e-05;
MatrixA(31,1) = 0.00205497;
MatrixA(31,2) = 0.0202657;
MatrixA(31,3) = -0.00190421;
MatrixA(31,12) = -0.00192327;
MatrixA(31,13) = 0.00202366;
MatrixA(31,31) = -17.6692;
MatrixA(31,36) = -28.9873;
MatrixA(31,37) = -0.00015672;
MatrixA(31,38) = -1.01524;
MatrixA(31,39) = -31.743;
MatrixA(31,40) = 24.6362;
MatrixA(31,41) = 1.06748;
MatrixA(31,46) = 1.06753;
MatrixA(31,47) = -4.05803;
MatrixA(31,49) = 11.3958;
MatrixA(32,52) = 1;
MatrixA(33,44) = 2.05;
MatrixA(33,45) = 2.05;
MatrixA(34,48) = 2.05;
MatrixA(34,49) = 2.05;
MatrixA(35,44) = 1.025;
MatrixA(35,45) = 1.025;
MatrixA(35,48) = 1.025;
MatrixA(35,49) = 1.025;
MatrixA(36,1) = 85.3698;
MatrixA(36,2) = 248.019;
MatrixA(36,3) = 0.0603027;
MatrixA(36,6) = 2.11949e-07;
MatrixA(36,7) = 1.47125e-09;
MatrixA(36,8) = 0.254264;
MatrixA(36,9) = -8.82402;
MatrixA(36,12) = 6.71361;
MatrixA(36,13) = 133.595;
MatrixA(36,16) = -8.46327;
MatrixA(36,17) = 33.2811;
MatrixA(36,20) = -8.45217;
MatrixA(36,21) = 33.2327;
MatrixA(36,24) = 1.35997;
MatrixA(36,25) = 10.9918;
MatrixA(36,26) = 1.35977;
MatrixA(36,27) = 10.9878;
MatrixA(36,28) = 1.35515;
MatrixA(36,29) = 11.0141;
MatrixA(36,30) = 1.35535;
MatrixA(36,31) = 11.0181;
MatrixA(36,32) = -0.0214225;
MatrixA(36,35) = 0.0214225;
MatrixA(36,36) = -0.00019756;
MatrixA(36,37) = -3.18716e-07;
MatrixA(36,38) = -5.63186e-06;
MatrixA(36,39) = -7.50423e-05;
MatrixA(36,40) = -0.0195774;
MatrixA(36,41) = 5.36733e-06;
MatrixA(36,42) = -5.78088e-06;
MatrixA(36,43) = -0.233929;
MatrixA(36,44) = 0.000698913;
MatrixA(36,45) = 0.000698913;
MatrixA(36,46) = -1.26448e-05;
MatrixA(36,47) = 0.879621;
MatrixA(36,48) = 0.000698982;
MatrixA(36,49) = 0.000698982;
MatrixA(36,52) = -0.0006819;
MatrixA(37,1) = 0.000841262;
MatrixA(37,2) = -0.0152516;
MatrixA(37,3) = 101.855;
MatrixA(37,6) = 0.00408387;
MatrixA(37,7) = 0.000173128;
MatrixA(37,8) = -173.289;
MatrixA(37,9) = -0.902196;
MatrixA(37,12) = 221.532;
MatrixA(37,13) = 0.929029;
MatrixA(37,16) = -33.7256;
MatrixA(37,17) = -0.446202;
MatrixA(37,20) = -33.9046;
MatrixA(37,21) = 0.4455;
MatrixA(37,24) = -8.83133;
MatrixA(37,25) = -0.46432;
MatrixA(37,26) = -8.82821;
MatrixA(37,27) = -0.46415;
MatrixA(37,28) = -8.7351;
MatrixA(37,29) = 0.464881;
MatrixA(37,30) = -8.7382;
MatrixA(37,31) = 0.46505;
MatrixA(37,32) = -0.0278497;
MatrixA(37,35) = 0.0278497;
MatrixA(37,36) = -1.12063e-07;
MatrixA(37,37) = -0.00067671;
MatrixA(37,38) = 2.20177e-06;
MatrixA(37,39) = -0.579322;
MatrixA(37,40) = 2.77811e-07;
MatrixA(37,41) = 0.0191189;
MatrixA(37,42) = -1.07012;
MatrixA(37,43) = 0.00118876;
MatrixA(37,44) = 0.00487884;
MatrixA(37,45) = 0.00487884;
MatrixA(37,46) = 0.283476;
MatrixA(37,47) = 0.000811688;
MatrixA(37,48) = -0.00306155;
MatrixA(37,49) = -0.00306155;
MatrixA(37,52) = -0.000886484;
MatrixA(38,1) = -7.93419;
MatrixA(38,2) = -26.7869;
MatrixA(38,3) = -0.023523;
MatrixA(38,6) = -7.93946e-07;
MatrixA(38,7) = -3.25932e-08;
MatrixA(38,8) = -9.20539;
MatrixA(38,9) = 623.219;
MatrixA(38,12) = 40.6351;
MatrixA(38,13) = 359.38;
MatrixA(38,16) = -0.0892911;
MatrixA(38,17) = 0.376234;
MatrixA(38,20) = -0.0891565;
MatrixA(38,21) = 0.375615;
MatrixA(38,24) = -0.149244;
MatrixA(38,25) = -1.21762;
MatrixA(38,26) = -0.149222;
MatrixA(38,27) = -1.21718;
MatrixA(38,28) = -0.148721;
MatrixA(38,29) = -1.22022;
MatrixA(38,30) = -0.148743;
MatrixA(38,31) = -1.22066;
MatrixA(38,32) = 0.0015675;
MatrixA(38,35) = -0.0015675;
MatrixA(38,36) = 0.000135059;
MatrixA(38,37) = -1.99372e-06;
MatrixA(38,38) = 4.5725e-06;
MatrixA(38,39) = 2.01667e-05;
MatrixA(38,40) = 0.580341;
MatrixA(38,41) = -2.83766e-06;
MatrixA(38,42) = 0.000273616;
MatrixA(38,43) = 6.84084;
MatrixA(38,44) = -5.18325e-05;
MatrixA(38,45) = -5.18325e-05;
MatrixA(38,46) = -4.08323e-05;
MatrixA(38,47) = 5.44609;
MatrixA(38,48) = -5.04524e-05;
MatrixA(38,49) = -5.04524e-05;
MatrixA(38,52) = 4.98951e-05;
MatrixA(39,1) = 0.00951197;
MatrixA(39,2) = 0.021529;
MatrixA(39,3) = -228.674;
MatrixA(39,6) = 0.00224069;
MatrixA(39,7) = 9.86951e-05;
MatrixA(39,8) = -81.7477;
MatrixA(39,9) = -0.3139;
MatrixA(39,12) = -212.115;
MatrixA(39,13) = -1.49237;
MatrixA(39,16) = -14.4868;
MatrixA(39,17) = -10.6811;
MatrixA(39,20) = -19.891;
MatrixA(39,21) = 10.6654;
MatrixA(39,24) = 7.15631;
MatrixA(39,25) = -3.89648;
MatrixA(39,26) = 7.15368;
MatrixA(39,27) = -3.89506;
MatrixA(39,28) = 8.1349;
MatrixA(39,29) = 3.90495;
MatrixA(39,30) = 8.13767;
MatrixA(39,31) = 3.90637;
MatrixA(39,32) = -0.0373449;
MatrixA(39,35) = 0.0373449;
MatrixA(39,36) = 9.97163e-10;
MatrixA(39,37) = -6.17423e-05;
MatrixA(39,38) = 1.04961e-08;
MatrixA(39,39) = 0.00319405;
MatrixA(39,40) = -1.31138e-06;
MatrixA(39,41) = -0.00437615;
MatrixA(39,42) = -0.395293;
MatrixA(39,43) = 0.000622372;
MatrixA(39,44) = 0.000713281;
MatrixA(39,45) = 0.000713281;
MatrixA(39,46) = -0.466345;
MatrixA(39,47) = -0.000692721;
MatrixA(39,48) = 0.0017236;
MatrixA(39,49) = 0.0017236;
MatrixA(39,52) = -0.00118872;
MatrixA(40,1) = -22.9029;
MatrixA(40,2) = -69.6714;
MatrixA(40,3) = -0.0638139;
MatrixA(40,6) = 3.93544e-06;
MatrixA(40,7) = 1.78876e-08;
MatrixA(40,8) = 4.36497;
MatrixA(40,9) = -296.522;
MatrixA(40,12) = 30.5599;
MatrixA(40,13) = 255.142;
MatrixA(40,16) = 1.24731;
MatrixA(40,17) = -4.91745;
MatrixA(40,20) = 1.24467;
MatrixA(40,21) = -4.90633;
MatrixA(40,24) = -0.391805;
MatrixA(40,25) = -3.17632;
MatrixA(40,26) = -0.391747;
MatrixA(40,27) = -3.17516;
MatrixA(40,28) = -0.390259;
MatrixA(40,29) = -3.18156;
MatrixA(40,30) = -0.390316;
MatrixA(40,31) = -3.18272;
MatrixA(40,32) = -0.237028;
MatrixA(40,35) = 0.237028;
MatrixA(40,36) = -6.86333e-05;
MatrixA(40,37) = -2.94476e-07;
MatrixA(40,38) = -2.30642e-06;
MatrixA(40,39) = 2.94329e-05;
MatrixA(40,40) = 4.19794e-05;
MatrixA(40,41) = 9.34658e-06;
MatrixA(40,42) = -0.000102901;
MatrixA(40,43) = -3.23422;
MatrixA(40,44) = 0.00773344;
MatrixA(40,45) = 0.00773344;
MatrixA(40,46) = -6.40467e-05;
MatrixA(40,47) = 4.09977;
MatrixA(40,48) = 0.0077335;
MatrixA(40,49) = 0.0077335;
MatrixA(40,52) = -0.00754485;
MatrixA(41,1) = 0.00111406;
MatrixA(41,2) = -0.016141;
MatrixA(41,3) = 118.692;
MatrixA(41,6) = 0.00450136;
MatrixA(41,7) = 0.000190464;
MatrixA(41,8) = 162.772;
MatrixA(41,9) = 3.65485;
MatrixA(41,12) = 556.254;
MatrixA(41,13) = 13.5786;
MatrixA(41,16) = -37.5676;
MatrixA(41,17) = 0.532304;
MatrixA(41,20) = -37.2442;
MatrixA(41,21) = -0.531582;
MatrixA(41,24) = -9.48702;
MatrixA(41,25) = -0.1314;
MatrixA(41,26) = -9.48367;
MatrixA(41,27) = -0.131352;
MatrixA(41,28) = -9.47448;
MatrixA(41,29) = 0.131336;
MatrixA(41,30) = -9.47783;
MatrixA(41,31) = 0.131384;
MatrixA(41,32) = 0.349826;
MatrixA(41,35) = -0.349826;
MatrixA(41,36) = 3.79124e-09;
MatrixA(41,37) = -0.000470533;
MatrixA(41,38) = 7.98617e-08;
MatrixA(41,39) = 0.00114616;
MatrixA(41,40) = 3.06732e-07;
MatrixA(41,41) = -1.07847e-05;
MatrixA(41,42) = 3.74501;
MatrixA(41,43) = 0.0013123;
MatrixA(41,44) = -0.00707807;
MatrixA(41,45) = -0.00707807;
MatrixA(41,46) = 4.28959;
MatrixA(41,47) = 0.000878307;
MatrixA(41,48) = -0.0157493;
MatrixA(41,49) = -0.0157493;
MatrixA(41,52) = 0.0111353;
MatrixA(42,1) = 0.0760476;
MatrixA(42,2) = -0.00207802;
MatrixA(42,3) = -11461.4;
MatrixA(42,6) = 0.569244;
MatrixA(42,7) = 0.0205969;
MatrixA(42,8) = -17962.9;
MatrixA(42,9) = -87.8874;
MatrixA(42,12) = -461.161;
MatrixA(42,13) = -11.1372;
MatrixA(42,16) = -525.051;
MatrixA(42,17) = 44.5341;
MatrixA(42,20) = -501.691;
MatrixA(42,21) = -44.4698;
MatrixA(42,24) = 7.64803;
MatrixA(42,25) = -2.339;
MatrixA(42,26) = 7.64526;
MatrixA(42,27) = -2.33815;
MatrixA(42,28) = 8.24244;
MatrixA(42,29) = 2.34368;
MatrixA(42,30) = 8.2453;
MatrixA(42,31) = 2.34454;
MatrixA(42,32) = -3.77242;
MatrixA(42,35) = 3.77242;
MatrixA(42,36) = -1.23512e-08;
MatrixA(42,37) = 3.40758e-05;
MatrixA(42,38) = -6.20063e-09;
MatrixA(42,39) = 0.350592;
MatrixA(42,40) = 6.53839e-05;
MatrixA(42,41) = -0.00268056;
MatrixA(42,42) = -93.1505;
MatrixA(42,43) = -0.0010645;
MatrixA(42,44) = 0.37136;
MatrixA(42,45) = 0.37136;
MatrixA(42,46) = -3.51908;
MatrixA(42,47) = -0.000740709;
MatrixA(42,48) = -0.125197;
MatrixA(42,49) = -0.125197;
MatrixA(42,52) = -0.12008;
MatrixA(43,1) = -3792.6;
MatrixA(43,2) = -11.5438;
MatrixA(43,3) = 0.157681;
MatrixA(43,6) = 9.15284e-06;
MatrixA(43,7) = 1.93896e-07;
MatrixA(43,8) = 114.472;
MatrixA(43,9) = -11622.9;
MatrixA(43,12) = -1.25743;
MatrixA(43,13) = -30.2476;
MatrixA(43,16) = -2.08807;
MatrixA(43,17) = 8.17698;
MatrixA(43,20) = -2.08506;
MatrixA(43,21) = 8.16404;
MatrixA(43,24) = -0.355335;
MatrixA(43,25) = -2.87882;
MatrixA(43,26) = -0.355282;
MatrixA(43,27) = -2.87777;
MatrixA(43,28) = -0.354112;
MatrixA(43,29) = -2.88502;
MatrixA(43,30) = -0.354164;
MatrixA(43,31) = -2.88607;
MatrixA(43,32) = -0.307389;
MatrixA(43,35) = 0.307389;
MatrixA(43,36) = -0.000224603;
MatrixA(43,37) = -2.89183e-07;
MatrixA(43,38) = -7.54782e-06;
MatrixA(43,39) = 1.75243e-05;
MatrixA(43,40) = -0.000320382;
MatrixA(43,41) = -0.000353426;
MatrixA(43,42) = -0.0021539;
MatrixA(43,43) = -86.2009;
MatrixA(43,44) = 0.0100312;
MatrixA(43,45) = 0.0100312;
MatrixA(43,46) = -0.000400844;
MatrixA(43,47) = -0.157392;
MatrixA(43,48) = 0.010027;
MatrixA(43,49) = 0.010027;
MatrixA(43,52) = -0.00978448;
MatrixA(44,1) = -122.928;
MatrixA(44,2) = 71.7858;
MatrixA(44,3) = -125.399;
MatrixA(44,6) = 0.00838513;
MatrixA(44,7) = -4.33536e-05;
MatrixA(44,8) = -129.751;
MatrixA(44,9) = 150.774;
MatrixA(44,12) = -30.5996;
MatrixA(44,13) = -255.143;
MatrixA(44,16) = 1489.4;
MatrixA(44,17) = -5857.17;
MatrixA(44,20) = -18.8625;
MatrixA(44,21) = 74.1694;
MatrixA(44,24) = 0.393145;
MatrixA(44,25) = 3.1756;
MatrixA(44,26) = 0.393087;
MatrixA(44,27) = 3.17444;
MatrixA(44,28) = 0.391782;
MatrixA(44,29) = 3.18229;
MatrixA(44,30) = 0.391839;
MatrixA(44,31) = 3.18345;
MatrixA(44,32) = 59.6553;
MatrixA(44,35) = -59.6553;
MatrixA(44,36) = -0.0508911;
MatrixA(44,37) = 1.3812e-08;
MatrixA(44,38) = -0.00171162;
MatrixA(44,39) = 0.0456254;
MatrixA(44,40) = 0.0432858;
MatrixA(44,41) = -0.00154582;
MatrixA(44,42) = -0.00141709;
MatrixA(44,43) = 3.23251;
MatrixA(44,44) = -7.296;
MatrixA(44,45) = -5.18284;
MatrixA(44,46) = -2.39602e-05;
MatrixA(44,47) = -4.09977;
MatrixA(44,48) = 2.34671;
MatrixA(44,49) = 2.34671;
MatrixA(44,52) = 1.89889;
MatrixA(45,1) = -123.147;
MatrixA(45,2) = 71.7891;
MatrixA(45,3) = 136.625;
MatrixA(45,6) = -0.00831015;
MatrixA(45,7) = 4.32658e-05;
MatrixA(45,8) = 132.273;
MatrixA(45,9) = 150.555;
MatrixA(45,12) = -30.5996;
MatrixA(45,13) = -255.143;
MatrixA(45,16) = -18.8874;
MatrixA(45,17) = 74.2779;
MatrixA(45,20) = 1487.43;
MatrixA(45,21) = -5848.6;
MatrixA(45,24) = 0.393145;
MatrixA(45,25) = 3.1756;
MatrixA(45,26) = 0.393087;
MatrixA(45,27) = 3.17444;
MatrixA(45,28) = 0.391782;
MatrixA(45,29) = 3.18229;
MatrixA(45,30) = 0.391839;
MatrixA(45,31) = 3.18345;
MatrixA(45,32) = 59.6553;
MatrixA(45,35) = -59.6553;
MatrixA(45,36) = -0.0508124;
MatrixA(45,37) = 1.42305e-08;
MatrixA(45,38) = -0.00170897;
MatrixA(45,39) = -0.0456194;
MatrixA(45,40) = 0.0432034;
MatrixA(45,41) = 0.00152301;
MatrixA(45,42) = 0.00165174;
MatrixA(45,43) = 3.23251;
MatrixA(45,44) = -5.18284;
MatrixA(45,45) = -7.296;
MatrixA(45,46) = -2.39602e-05;
MatrixA(45,47) = -4.09977;
MatrixA(45,48) = 2.34671;
MatrixA(45,49) = 2.34671;
MatrixA(45,52) = 1.89889;
MatrixA(46,1) = -0.134;
MatrixA(46,2) = -0.424026;
MatrixA(46,3) = -27660.1;
MatrixA(46,6) = -0.00507619;
MatrixA(46,7) = -0.000211338;
MatrixA(46,8) = -192.748;
MatrixA(46,9) = -4.23582;
MatrixA(46,12) = -34104.6;
MatrixA(46,13) = -251.738;
MatrixA(46,16) = 46.1046;
MatrixA(46,17) = -10.3151;
MatrixA(46,20) = 40.8009;
MatrixA(46,21) = 10.2992;
MatrixA(46,24) = -308.108;
MatrixA(46,25) = 16.0359;
MatrixA(46,26) = -308;
MatrixA(46,27) = 16.03;
MatrixA(46,28) = -312.722;
MatrixA(46,29) = -16.0701;
MatrixA(46,30) = -312.83;
MatrixA(46,31) = -16.0759;
MatrixA(46,32) = -3.97242;
MatrixA(46,35) = 3.97242;
MatrixA(46,36) = -9.28381e-09;
MatrixA(46,37) = 0.00080016;
MatrixA(46,38) = -1.359e-07;
MatrixA(46,39) = 0.268712;
MatrixA(46,40) = 4.31136e-05;
MatrixA(46,41) = -0.00385837;
MatrixA(46,42) = -4.34536;
MatrixA(46,43) = -0.0014939;
MatrixA(46,44) = -0.133123;
MatrixA(46,45) = -0.133123;
MatrixA(46,46) = -79.6395;
MatrixA(46,47) = -0.00108253;
MatrixA(46,48) = 0.392337;
MatrixA(46,49) = 0.392337;
MatrixA(46,52) = -0.126446;
MatrixA(47,1) = -6556.63;
MatrixA(47,2) = -22155.2;
MatrixA(47,3) = 0.894092;
MatrixA(47,6) = -7.34413e-06;
MatrixA(47,7) = -8.58503e-09;
MatrixA(47,8) = 0.233756;
MatrixA(47,9) = -15.1448;
MatrixA(47,12) = -503.082;
MatrixA(47,13) = -11068.6;
MatrixA(47,16) = -1.59354;
MatrixA(47,17) = 6.273;
MatrixA(47,20) = -1.59113;
MatrixA(47,21) = 6.26262;
MatrixA(47,24) = 3.00842;
MatrixA(47,25) = 24.2602;
MatrixA(47,26) = 3.00797;
MatrixA(47,27) = 24.2514;
MatrixA(47,28) = 2.99785;
MatrixA(47,29) = 24.31;
MatrixA(47,30) = 2.99829;
MatrixA(47,31) = 24.3189;
MatrixA(47,32) = 0.480982;
MatrixA(47,35) = -0.480982;
MatrixA(47,36) = 2.40842e-05;
MatrixA(47,37) = 6.54678e-07;
MatrixA(47,38) = 8.09327e-07;
MatrixA(47,39) = -0.000280172;
MatrixA(47,40) = -0.000817347;
MatrixA(47,41) = -0.00054187;
MatrixA(47,42) = -0.000211388;
MatrixA(47,43) = -0.194308;
MatrixA(47,44) = -0.0156892;
MatrixA(47,45) = -0.0156892;
MatrixA(47,46) = 0.000908918;
MatrixA(47,47) = -67.246;
MatrixA(47,48) = -0.0156966;
MatrixA(47,49) = -0.0156966;
MatrixA(47,52) = 0.0153101;
MatrixA(48,1) = 493.945;
MatrixA(48,2) = 1666;
MatrixA(48,3) = 448.153;
MatrixA(48,6) = -3.57525e-06;
MatrixA(48,7) = -2.02238e-09;
MatrixA(48,8) = -4.37811;
MatrixA(48,9) = 296.522;
MatrixA(48,12) = 417.863;
MatrixA(48,13) = 214.025;
MatrixA(48,16) = -1.24964;
MatrixA(48,17) = 4.91573;
MatrixA(48,20) = -1.24786;
MatrixA(48,21) = 4.90804;
MatrixA(48,24) = -329.128;
MatrixA(48,25) = -2660.2;
MatrixA(48,26) = -329.079;
MatrixA(48,27) = -2659.23;
MatrixA(48,28) = 5.59318;
MatrixA(48,29) = 45.4601;
MatrixA(48,30) = 5.594;
MatrixA(48,31) = 45.4766;
MatrixA(48,32) = 79.4745;
MatrixA(48,35) = -79.4745;
MatrixA(48,36) = -0.0451594;
MatrixA(48,37) = 4.00286e-08;
MatrixA(48,38) = -0.00151884;
MatrixA(48,39) = 0.0443221;
MatrixA(48,40) = 0.0384131;
MatrixA(48,41) = -0.00150184;
MatrixA(48,42) = 3.93578e-05;
MatrixA(48,43) = 3.23422;
MatrixA(48,44) = 3.13204;
MatrixA(48,45) = 3.13204;
MatrixA(48,46) = -0.00150275;
MatrixA(48,47) = -4.10584;
MatrixA(48,48) = -9.73839;
MatrixA(48,49) = -6.89768;
MatrixA(48,52) = 2.52975;
MatrixA(49,1) = 492.786;
MatrixA(49,2) = 1662.01;
MatrixA(49,3) = -479.98;
MatrixA(49,6) = -3.57525e-06;
MatrixA(49,7) = -2.02241e-09;
MatrixA(49,8) = -4.37811;
MatrixA(49,9) = 296.522;
MatrixA(49,12) = -510.271;
MatrixA(49,13) = 212.87;
MatrixA(49,16) = -1.24964;
MatrixA(49,17) = 4.91573;
MatrixA(49,20) = -1.24786;
MatrixA(49,21) = 4.90804;
MatrixA(49,24) = 5.61312;
MatrixA(49,25) = 45.3681;
MatrixA(49,26) = 5.61229;
MatrixA(49,27) = 45.3515;
MatrixA(49,28) = -327.958;
MatrixA(49,29) = -2665.59;
MatrixA(49,30) = -328.006;
MatrixA(49,31) = -2666.56;
MatrixA(49,32) = 79.4745;
MatrixA(49,35) = -79.4745;
MatrixA(49,36) = -0.0452723;
MatrixA(49,37) = 3.94145e-08;
MatrixA(49,38) = -0.00152264;
MatrixA(49,39) = -0.0444883;
MatrixA(49,40) = 0.0384941;
MatrixA(49,41) = 0.00148511;
MatrixA(49,42) = 3.93578e-05;
MatrixA(49,43) = 3.23422;
MatrixA(49,44) = 3.13204;
MatrixA(49,45) = 3.13204;
MatrixA(49,46) = 0.00148421;
MatrixA(49,47) = -4.10586;
MatrixA(49,48) = -6.89768;
MatrixA(49,49) = -9.73839;
MatrixA(49,52) = 2.52975;
MatrixA(50,50) = -2.80602;
MatrixA(50,52) = 0.273128;
MatrixA(51,32) = -9013.77;
MatrixA(51,35) = 9013.77;
MatrixA(51,44) = 294.09;
MatrixA(51,45) = 294.09;
MatrixA(51,48) = 294.09;
MatrixA(51,49) = 294.09;
MatrixA(51,50) = 65.8084;
MatrixA(51,52) = -361.522;
MatrixA(52,32) = -2907.67;
MatrixA(52,35) = 2907.67;
MatrixA(52,44) = 94.8678;
MatrixA(52,45) = 94.8678;
MatrixA(52,48) = 94.8678;
MatrixA(52,49) = 94.8678;
MatrixA(52,50) = 21.2285;
MatrixA(52,52) = -116.62;

MatrixB = zeros(52, 1);

MatrixB(7,1) = 203177;

MatrixC = zeros(2, 52);

MatrixC(1,39) = 1;
MatrixC(2,1) = -0.000176069;
MatrixC(2,2) = 0.000309316;
MatrixC(2,3) = -2.95382;
MatrixC(2,6) = -0.000710155;
MatrixC(2,7) = 7.69058e-15;
MatrixC(2,8) = -1.8509;
MatrixC(2,9) = -0.000356799;
MatrixC(2,12) = -1.10283;
MatrixC(2,13) = 0.000180241;
MatrixC(2,16) = -30.3732;
MatrixC(2,17) = -1.35913e-05;
MatrixC(2,20) = -30.3303;
MatrixC(2,21) = -1.35558e-05;
MatrixC(2,24) = -12.7463;
MatrixC(2,25) = -3.35742e-06;
MatrixC(2,26) = -12.7418;
MatrixC(2,27) = -3.35612e-06;
MatrixC(2,28) = -12.773;
MatrixC(2,29) = -3.36466e-06;
MatrixC(2,30) = -12.7775;
MatrixC(2,31) = -3.36596e-06;
MatrixC(2,32) = -1.42482e-15;
MatrixC(2,35) = 1.43329e-15;
MatrixC(2,36) = -1.85393e-08;
MatrixC(2,37) = -0.000699538;
MatrixC(2,38) = 1.17917e-07;
MatrixC(2,39) = 5.74034e-05;
MatrixC(2,40) = 1.10237e-08;
MatrixC(2,41) = -5.09601e-05;
MatrixC(2,42) = 6.01629e-06;
MatrixC(2,43) = -9.88267e-10;
MatrixC(2,44) = 1.5056e-16;
MatrixC(2,45) = 1.51513e-16;
MatrixC(2,46) = -5.83687e-06;
MatrixC(2,47) = 3.08498e-10;
MatrixC(2,48) = -5.91335e-17;
MatrixC(2,49) = -5.80747e-17;
MatrixC(2,52) = -4.48398e-17;

MatrixD = zeros(2, 1);
