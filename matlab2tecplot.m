clc;clear;close all;
%==============================================================
%   Preprocess flow field data and export to a Tecplot file
%   Yuchen Ge, Fall, 2022
%==============================================================

% required flow field data
%   x - x coordinates   
%   y - y coordinates
%   z - z coordinates
%   u - X Velocity
%   v - Y Velocity
%   w - Z Velocity

% Step 1: prepare data
load wind.mat
filename=['wind.plt'];
% calculate variables
V2=sqrt(u.^2+v.^2+w.^2);    % veolcity magnitude
% Q

% % 2D: export to .plt  
% title='';                       % no title
% variables={'X','Y','U','V'};
% zone_title='';                  % no title
% Mat_Data=[x(:),y(:),u(:),v(:)];
% IJK=size(x);
% time=[];

title='wind';% title of Tecplot file
variables={'X','Y','Z','U','V','W','V2'};
zone_title='wind';  % no title
Mat_Data=[x(:),y(:),z(:),u(:),v(:),w(:),V2(:)];
IJK=size(x);        % size of each dimension
time=[];            % time of solution, set none for a steady problem

% Step 2: create the Tecplot file
if exist(filename,'file')
    delete(filename)
end
f_id=fopen(filename,'a');
fclose(f_id);

% Step 3: create Header of the Tecplot file
plt_Head(filename,title,variables)

% Step 4: create Zone of the Tecplot file
plt_Zone(filename,zone_title,IJK,time,Mat_Data)
