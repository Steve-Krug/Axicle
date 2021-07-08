classdef GNCConstants
    properties (Constant = true)
        CycleTime_sec = 1/50;
        Epsilon = 1e-10;
        XAxis = 1;
        YAxis = 2;
        ZAxis = 3;
        RollAxis = 1;
        PitchAxis = 2;
        YawAxis = 3;
        NedNorthAxis = 1;
        NedEastAxis  = 2;
        NedDownAxis  = 3;
        NumAxes = 3;
        FeetToCm = 0.3048*100;
        FeetToMeter = 0.3048;
        FeetToKm = 0.3048/1000;
        MmToInch = 0.0393701;
        MeterToFeet = 1/0.3048;
        MeterToInch = 1/0.0254;
        KilometerToFeet = 1000/0.3048;
        LbmToKg = 0.4536;
        LbmToSlug = 0.031081;
        KgToLbm = 1/0.4536;
        InchToFeet = 1/12;
        FeetToInch = 12;
        FeetToNmi = 1/6076.10;
        FeetToMile = 1/5280;
        MileToFeet = 5280;
        HourToSecond = 3600;
        SecondToHour = 1/3600;
        SecToMin = 1/60;
        MinToSec = 60;
        GpmToIn3ps = 3.85;
        DegreeToRadian = 1/180*pi;
        RadianToDegree = 180/pi;
        XAxisVector = [1;0;0];
        YAxisVector = [0;1;0];
        ZAxisVector = [0;0;1];
        NumKFStateSpaceVars = 15;
        NumKFSigmaPoints = 31;
        ThreeSigma = 3;
        PpmToDec = 1/1e6;
        BtuToJoule = 1055.05585262;
        QuatIdentity = [1, 0, 0, 0];
        DegreeToMinute = 60;
        Gravity_fpsps = 32.174;
        FahrenheitToRankineDelta = 459.67;
        GToMPS2 = 9.81;
        InchToMeter = 0.0254;
        LbfToNewton = 1/4.448;
        NewtonToLbf = 4.448;
        Gravity_mps2 = 9.81;
        % EGM2008 Gravity Data, Tide-Free, Jn values equal to negative of denormalized C(n,0) values
        % http://earth-info.nga.mil/GandG/wgs84/gravitymod/egm2008/index.html
        % http://earth-info.nga.mil/GandG/wgs84/gravitymod/egm2008/EGM2008_to2190_TideFree.gz
        % Denormalized per "Normalization of Gravitational Acceleration Models" by
        % Eckman, Brown and Adamo, 24 Jan 2011, Pg 9, Eq. 3.1, Table 3.1
        % https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20110023121.pdf
        
        J2Parameter = 1.082626173852223e-03;    % J2 = -sqrt(5) * C(2,0)
        J3Parameter = -2.532410518567722e-06;   % J3 = -sqrt(7) * C(3,0) 
        J4Parameter = -1.619897599916973e-06;   % J4 = -2 * C(4,0)

        % Used to limit inputs to gravity vector calculation
        EpsilonGravity = GNCConstants.Epsilon^0.25
        
        % Source: DOD World Geodetic System 1984, 3rd edition, Amendement 1, 3 Jan 2000
        % http://earth-info.nga.mil/GandG/publications/tr8350.2/wgs84fin.pdf

        % Eq. 3-1, Earth equatorial radius (semi-major axis)
        EarthEquatorialRadius_ft = 6378137.0 * GNCConstants.MeterToFeet;

        % Eq. 3-2, Earth flattening
        EarthFlattening = 1/298.257223563;
        
        % Eq. 3-3, GM with Earth atmosphere included
        StandardGravitiationalParameter_ft3PerSec2 = 3986004.418e8 * GNCConstants.MeterToFeet^3  
        
        % Eq, 3-10, Angular velocity assuming precessing frame 
        AngVelEciToEcefExpInEci_rps = [0.0; 0.0; 7292115.8553e-11];                               

        % Source: Handbook for Transformation of Datums, Projections, Grids, and Common Coordinate Systems, 
        % US Army Corp of Engineers, May 2004, MIL-HDBK-600008
        % http://www.dtic.mil/dtic/tr/fulltext/u2/a478730.pdf
        
        % Eq. 4.3 (derived), Earth Polar radius (semi-minor axis)
        EarthPolarRadius_ft = GNCConstants.EarthEquatorialRadius_ft * (1.0 - GNCConstants.EarthFlattening); 
        
        % Eq. 4.9, Square of Earth primary eccentricity
        EarthEccSqr = 2 * GNCConstants.EarthFlattening - GNCConstants.EarthFlattening^2;
        
        % Eq. 4.9 Square of Earth secondary eccentricity
        EarthSecEccSqr = GNCConstants.EarthEccSqr / (1 - GNCConstants.EarthEccSqr);
        
        % These constant parameters are used by EcefToLla.m
        OneMinusFlattening = 1.0 - GNCConstants.EarthFlattening;
        SecEccSqrTimesPolarRadius = GNCConstants.EarthSecEccSqr * GNCConstants.EarthPolarRadius_ft;
        EccSqrTimesEquatorialRadius = GNCConstants.EarthEccSqr * GNCConstants.EarthEquatorialRadius_ft;
        
    end
end