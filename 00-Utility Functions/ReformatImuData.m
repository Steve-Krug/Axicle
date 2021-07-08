function ImuOut = ReformatImuData(Imu)
Fields = fieldnames(Imu(1));
NumImu = length(Imu);
if NumImu < 10
    % Data is organized as expected.  Merge the new way.
    for ii = 1:length(Fields)
        ImuOut.(Fields{ii}) = [];
    end
    for jj = 1:NumImu
        for ii = 1:length(Fields)
            ImuOut.(Fields{ii}) = [ImuOut.(Fields{ii}); Imu(jj).(Fields{ii})];
        end
    end
    ImuOut.DeltaTheta_rad = zeros(2*length(ImuOut.deltaThetaA),3);
    DeltaThetaA_rad = ImuOut.deltaThetaA;
    DeltaThetaB_rad = ImuOut.deltaThetaB;
    ImuOut.DeltaTheta_rad(1:2:end-1,:) = DeltaThetaA_rad;
    ImuOut.DeltaTheta_rad(2:2:end,:) = DeltaThetaB_rad;
    ImuOut.DeltaVel_fps = ImuOut.deltaVel;
else
    for ii = 1:length(Fields)
        ImuOut.(Fields{ii}) = reshape([Imu.(Fields{ii})],size(Imu(1).(Fields{ii}),2),length(Imu))';
    end
    ImuOut.DeltaTheta_rad = zeros(2*length(ImuOut.deltaThetaA),3);
    DeltaThetaA_rad = ImuOut.deltaThetaA;
    DeltaThetaB_rad = ImuOut.deltaThetaB;
    ImuOut.DeltaTheta_rad(1:2:end-1,:) = DeltaThetaA_rad;
    ImuOut.DeltaTheta_rad(2:2:end,:) = DeltaThetaB_rad;
end
ImuOut.DataValidDT = zeros(length(ImuOut.DataValid)*2,1);
ImuOut.DataValidDT(1:2:end-1) = ImuOut.DataValid;
ImuOut.DataValidDT(2:2:end) = ImuOut.DataValid;
[ImuOut.DeltaThetaFilt_rad, ImuOut.DeltaVelFilt_fps] = FilterImuData(ImuOut.DeltaTheta_rad(logical(ImuOut.DataValidDT),:), ImuOut.deltaVel(logical(ImuOut.DataValid),:));
end