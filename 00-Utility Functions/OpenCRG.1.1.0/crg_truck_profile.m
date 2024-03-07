%% Demo file generation CRG_DEMO
% Building a set of demo files with differ specifications.
% Do not alter this CRG-file. If necessary add new demo files. Several test proceedings require these data-structures.
% The file comments are optimized for the matlab publishing makro.

%   Copyright 2005-2011 OpenCRG - Daimler AG - Jochen Rauh
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%
%   More Information on OpenCRG open file formats and tools can be found at
%
%       http://www.opencrg.org
%
%   $Id: crg_demo.m 289 2011-06-09 11:07:18Z jorauh $

%% Demo proceeding
% The demos are initialized as followed:
%
% Demo 1-9
%
% * generate minimal crg-structure
% * alter, add specifications (change increment, add slope ec.)
% * write CRG-file
% * show results


% % build minimum crg-struct
% uinc = 0.01;
% vinc = 0.01;
% 
% nv = 201;
% nu = 5*nv;
% 
% v = -(nv-1)/2*vinc:vinc:(nv-1)/2*vinc;
% 
% z = 0.01*ones(nv);
% z = repmat(z, nu/nv, 1);
% 
% %% Demo1: crg defined by z matrix and scalar u and v specs
% 
% data.u = (nu-1)*uinc;
% data.v = (nv-1)*vinc/2;
% data.z = z;
% data.ct{1} = 'CRG defined by z matrix';
% crg_write(crg_single(data), 'demo1.crg');
% 
% dat = crg_read('demo1.crg');
% if dispRes, crg_show(dat); end





% DEFAULT SETTINGS
% clear enviroment
clear all;
close all

addpath(genpath('C:\Users\stkrug\Documents\OpenCRG.1.1.0\OpenCRG.1.1.0'));

% display results
dispRes = 1;

% build minimum crg-struct
uinc = 0.1; %.100m resolution
vinc = 0.1; %.100m resolution

% n=48;

nv = 40; %width, m
nu = 1000; %length, m
nu_step = 5; % m

z_step_start = zeros((nv/vinc),(nu_step/uinc)); %width, step length

z_step_end = 0.05*ones((nv/vinc),nu_step/uinc);

z_step_total = [z_step_start,z_step_end];

z_map = repmat(z_step_total, 1,nu*uinc);

% z2 = [z_map;z1];

z = z_map;
% z2 = [z_step;z1];
% % z1 = repmat(z1,n/2,1);
% % z2 = [z0;z0;z0;z0;z0;z0;z0;z0];
% % z2 = repmat(z2,n/8,1);
% z3 = repmat(z2,4,1);
% z = z3;

% z = 0.01*peaks(nv);
% z = repmat(z, nu/nv, 1);

%% Demo1: crg defined by z matrix and scalar u and v specs

data.u = (nu-uinc);
data.v = (nv-vinc);
% data.u = length(z_map(1,:));
% data.v = length(z_map(:,1));
data.z = z';
data.ct{1} = 'CRG defined by z matrix';
crg_write(crg_single(data), '\\teslamotors.com\US\Engineering\Chassis\Dynamics_Integration\5. Vehicle Modeling\2. SimulationStudies\170717_Alpha_Truck_Rack_Loads\OpenCRGProfiles\step_v2.crg');

dat = crg_read('\\teslamotors.com\US\Engineering\Chassis\Dynamics_Integration\5. Vehicle Modeling\2. SimulationStudies\170717_Alpha_Truck_Rack_Loads\OpenCRGProfiles\step_v2.crg');
if dispRes, crg_show(dat); end

