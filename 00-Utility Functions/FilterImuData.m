function [DeltaThetaFilt_dph, DeltaVFilt_microG] = FilterImuData(DeltaTheta_dph, DeltaV_microG)
% This will filter the input signals.

FilterCoeffs = [0 0.01 0.99;0 0.01 0.99;0 0.01 0.99];
AccelFilter = FilterClass(FilterCoeffs);
DeltaVFilt_microG = zeros(size(DeltaV_microG));
AccelFilter.ResetFilter(DeltaV_microG(1,:)');
NumDeltaV = length(DeltaV_microG(:,1));
disp('Starting Delta V Filtering');
for ii = 2:NumDeltaV
    FiltVal = AccelFilter.Filter(DeltaV_microG(ii,:)');
    DeltaVFilt_microG(ii,:) = FiltVal';
end
% DeltaVFilt_microG = DeltaV_microG;
GyroFilter = FilterClass(FilterCoeffs);
DeltaThetaFilt_dph = zeros(size(DeltaTheta_dph));
GyroFilter.ResetFilter(DeltaTheta_dph(1,:)');
NumDeltaTheta = length(DeltaTheta_dph(:,1));
% ModSize = NumDeltaTheta/10;
disp('Starting Delta Theta Filtering');
for ii = 2:NumDeltaTheta
    FiltVal = GyroFilter.Filter(DeltaTheta_dph(ii,:)');
    DeltaThetaFilt_dph(ii,:) = FiltVal';
end
disp('Filtering Complete.');
end