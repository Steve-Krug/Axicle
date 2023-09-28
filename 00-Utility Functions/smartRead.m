function out = smartRead(fname, convFname, doScale, timeStart)
% Function to load Dymola .mat file in to MATLAB structure with signal
% names determned by .csv files
%Inputs
% fname
% Path to Dymola results file
% convFname
% Path to Dymola conversion file
% doScale
% Flag to scale the results based on conversion rules
% timeStart
% Time to start the output data
if nargin == 2
    doScale = 0;
    timeStart=0;
elseif nargin == 3
    timeStart=0;
end


% Determine if valid inputs
validFile = exist(fname, 'file');
validconvFile = exist(convFname, 'file');


if ~validFile
    err = 'Dymola results file can not be found';
    error(err);
elseif ~validconvFile
    err = 'Conversion file can not be found';
    error(err);
end

% Read in Dymola .mat file
[dymData, err] = dymload(fname);

% Load all signals according to .csv file

% Use csvread (which can only read numbers) to get the size of the csv
% Use the scale colummn because that is the only all numeric col
numSignals = size(csvread(convFname, 1, 2), 1);

% Load .csv file data
fid = fopen(convFname);
csv = struct;
C = textscan(fid, '%s %s %f', numSignals, 'Delimiter', ',', 'HeaderLines', 1);
csv.signal = C{1,1};
csv.mat_name = C{1,2};
csv.scale = C{1,3};

fclose(fid);
clear C;

% Structure to hold signals
out = struct;

% Time
out.Time = dymget(dymData, 'Time');
ind = find(out.Time>timeStart);
out.Time = out.Time(ind(1):end);
%numSignals = size(csv.scale, 1)

% Create a structure in out for each signal
for j=1:numSignals
    try
        if doScale
            temp = dymget(dymData, csv.signal{j})*csv.scale(j);
            out.(csv.mat_name{j}) = temp(ind(1):end);
        else
            temp = dymget(dymData, csv.signal{j});
            out.(csv.mat_name{j}) = temp(ind(1):end);
        end
    catch
        disp(['Signal ' csv.signal{j} ' was not found in results file']);
    end
end