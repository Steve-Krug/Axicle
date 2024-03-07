function [outdata] = mdf_read(filename, varargin)
%MDF_READ   Read an MDF file into Matlab
%
%   Usage:
%       DATA = MDFREAD(FILENAME) returns all the channels in the mdf to the
%       base workspace in standard Tesla Format
%
%       DATA = MDFREAD(FILENAME,OPTIONS) returns data based on the options
%       selected in the OPTIONS struct
%
%   Description:
%       MDFREAD Reads MDF file and returns all the channels and signal names of
%       one data group in an MDF file.
%
%   Options Available on All Platforms:
%       -outputType:
%           - 'Standard' - return signals into workspace or caller function
%           in an array of [Time Data] with the name of each array being
%           the variable name
%           - 'TimeSeries' - return the signals as a struct of time series
%           objects.  I.e. data.ESP_wheelSpeed_FrL would be the time series
%           object for the ESP_wheelSpeedFrL channel in the mdf file
%           - 'Structure' - return the signals as a struct of two column
%           arrays where the name of the variables are the name of the
%           signals.
%
%
%    Example 1:
%
%             %  Retrieve data from 20150802_AWD_636.MDF and return it to
%             the workspace in standard format
%               mdfread('20150802_AWD_636.MDF');
%
%    Example 2:
%
%             %  Retrieve data from 20150802_AWD_636.MDF and return it to
%             workspace in a timeseries struct
%               options.outputType = 'TimeSeries';
%               mdf_read('20150802_AWD_636.MDF',options);
%
% Copyright 2015 Tesla Motor Company
if nargin == 0
   [FileName,PathName] = uigetfile('*.mdf','Select the MDF file');
   filename = [PathName FileName];
   options.outputType = 'structure';
   options.importTo = 'caller';
elseif nargin == 1
    options.outputType = 'standard';
    options.importTo = 'caller';
else
    options = varargin{1};
end
if isfield(options,'datanamesave')
    datanamesave = options.datanamesave;
else
    datanamesave = 'outdata';
end
if ~isfield(options,'importTo')
    options.importTo = 'caller';
end
if ~isfield(options,'outputType')
    options.outputType = 'standard';
end
if strcmpi(options.importTo,'workspace')
    ws='base';
    outdata = struct; %Returning empty array when just going back to workspace
else
    ws='caller';
end
if exist(filename,'file') == 2
    %Use the mex function to read in the data
    data = mdf_get_data(filename);
else
    error('Unable to find specified file');
end

if strcmpi(options.outputType,'standard')
    for i = 1:length(data)
        varName = mygenvarname(data(i).name);
        tempData = [data(i).time data(i).data];
        assignin(ws, varName, tempData); % Save it in chosen location
    end
elseif strcmpi(options.outputType,'timeseries')
    for i = 1:length(data)
        varName = mygenvarname(data(i).name);
        tempData.(varName) = timeseries(data(i).data, data(i).time, 'Name', varName);
    end
    assignin(ws, datanamesave, tempData); % Save it in chosen location
elseif strcmpi(options.outputType,'structure')
    for i = 1:length(data)
        
        % Make Sure Name Is Not Empty Field
        if isempty(data(i).name)
            break
        end;
        
        varName = mygenvarname(data(i).name);
        tempData.(varName) = [data(i).time data(i).data];
    end
    assignin(ws, datanamesave, tempData); % Save it in chosen location
    outdata = tempData;
end
end

function varName=mygenvarname(signalName)
% Returns a valid valiable name from the string in SIGNALNAME
%
% Example
%  a=mygenvarname('45\67')
%  a =
%  x45_bs_67
% Copyright 2006-2014 The MathWorks, Inc.

varName=signalName; % Its a valid variable names, we are done

% Not valid
if ~isvarname(varName)
    
    % Remove unsupported characaters
    varName = strrep(varName,'\','_bs_');  % Replace '\' with '_bs_'
    varName = strrep(varName,'/','_fs_');  % Replace '/' with '_fs_'
    
    varName = strrep(varName,'[','_ls_');  % Replace '[' with '_ls_'
    varName = strrep(varName,']','_rs_');  % Replace ']' with '_rs_'
    
    varName = strrep(varName,'(','_lp_');  % Replace '(' with '_lp_'
    varName = strrep(varName,')','_rp_');  % Replace ')' with '_rp_'
    
    varName = strrep(varName,'@','_am_');  % Replace '@' with '_am_'
    
    %varName = strrep(varName,' ','_sp_');  % Replace ' ' with '_sp_'
    varName = strrep(varName,' ','_');      % Replace ' ' with '_'
    if strcmp(varName(1),':')
        varName = strrep(varName,':','co');  % Replace ':' with 'co'
    else
        varName = strrep(varName,':','_co_');  % Replace ':' with '_co_'
    end;
    varName = strrep(varName,'-','_hy_');  % Replace '-' with '_hy_'
    varName = strrep(varName,'.','p');     % Replace '.' with 'p'
    varName = strrep(varName,'$','S_');    % Replace '$' with 'd_'
    %varName = strrep(varName,'.','_dot_'); % Replace '.' with '_dot_'
    
    if double(varName(1))>=48 & double(varName(1))<=57 % If starts with a number
        % if ~isvarname(varName)
        varName=['x'  varName];  % ...add an x to the start
    end
end
end