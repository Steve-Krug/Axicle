%% RunTruckSim_v1.m
% 5/4/23
% S. Krug
% Notes:
%
%
%

% Check if last loaded libarary is still in memory. If so, unload it.
clc;
if libisloaded('vs_solver')
    unloadlibrary('vs_solver');
end

% Force working directory to script directory
[FilePath] = fileparts(mfilename("fullpath"));
cd(FilePath);
% Scan simfile for DLL pathname. Change the name if it's not what you use.
simfile = 'simple.sim'; %assing to vairable because it's used twice
SolverPath = vs_dll_path(simfile);
% Load solver DLL, access the API fuctions, and name it 'vs_solver'
[notfound, warnings] - ...
    loadlibrary(SolverPath, 'vs_apidef_m.h', 'alias', 'vs_solver');
disp('The VS solver DLL is loaded,; the simulation is now running...');

% Maike the run
calllib('vs_solver', 'vs_run', simfile);
disp('The simulation has finished.');
% Unload solver DLL
unloadlibrary('vs_solver')