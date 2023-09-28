function [filepath] = dataFilePathFromIndex(index,vehicle,vehicle_ind,maneuver,maneuver_ind,VDC,VDC_ind,direction,direction_ind,Vx,Vx_ind,SWA,SWA_ind,path_ind)
v = strcmp(index(:,vehicle_ind),vehicle);
m = strcmp(index(:,maneuver_ind),maneuver);
vd = strcmp(index(:,VDC_ind),VDC);
d = strcmp(index(:,direction_ind),direction);
vx = cell2mat(index(2:end,Vx_ind)) == Vx; % Different for Vx because these are not character strings
vx = logical([0; vx]);
s = cell2mat(index(2:end,SWA_ind)) == SWA;
s = logical([0; s]);

matches = v&m&vd&d&vx&s;
row = find(matches);
if isempty(row)
    disp('No filepath found for:')
    vehicle
    maneuver
    VDC
    direction
    Vx
    SWA
    filepath = ''
elseif length(row) > 1
    row = min(row);
    warning('More than 1 match found. Using first occurrence')
    filepath = index{row,path_ind}
else
    filepath = index{row,path_ind}
end