clc;clear;close all;
%==============================================================
%   Preprocess flow field data and export to a Tecplot file
%   yuchen Ge, Fall, 2022
%==============================================================

% required flow field data
%   x   - x coordinates   
%   y   - y coordinates
%   z   - z coordinates
%   u1  - x Velocity
%   u2  - y Velocity
%   u3  - z Velocity

% choose additional variables to be calculated with the serial number
%   (1)w1   - x vortcity
%   (2)w2   - y vortcity
%   (3)w3   - z vortcity
%   (4)v    - velocity magnitude
%   (5)w    - vortcity magnitude
%   (6)phi  - vortex-surface field
%   (7)Q    - Q criterion

% Step 1: prepare data
% load wind.mat % you can use the matlab demo data "wind.mat" for a test
% take Taylor-Green flow for example (see Yang & Pullin, 2010)
filename=['Taylor_Green_flow.plt']; % filename of Tecplot file
x_0_upper=2*pi;
x_0_lower=0;
y_0_upper=2*pi;
y_0_lower=0;
z_0_upper=2*pi;
z_0_lower=0;
num_x_grid=21;
num_y_grid=21;
num_z_grid=21;
dx=(x_0_upper-x_0_lower)/(num_x_grid-1);
dy=(y_0_upper-y_0_lower)/(num_y_grid-1);
dz=(z_0_upper-z_0_lower)/(num_z_grid-1);

x_0=linspace(x_0_lower,x_0_upper,num_x_grid);
y_0=linspace(y_0_lower,y_0_upper,num_y_grid);
z_0=linspace(z_0_lower,z_0_upper,num_z_grid);
[x,y,z]=meshgrid(x_0,y_0,z_0);
u1=sin(x).*cos(y).*cos(z);
u2=-cos(x).*sin(y).*cos(z);
u3=0*cos(x).*sin(y).*cos(z);

% calculate variables
% basic information
title='wind';       % title of Tecplot file
zone_title='wind';  % no title
IJK=size(x);        % size of each dimension
time=[];            % time of solution, set none for a steady problem

basic_variables={'x','y','z','u1','u2','u3'};         % variables(to be appended)
basic_Mat_Data=[x(:),y(:),z(:),u1(:),u2(:),u3(:)];  % data(to be appended)

% choose and calculate additional variables
serial_num_of_variable = [1:7];   % for example, choose 'velocity magnitude' by input 4
[additional_variables,additional_Mat_Data]=calculate_additional_variables(serial_num_of_variable,x,y,z,u1,u2,u3,dx,dy,dz);

variables= [basic_variables,additional_variables];
Mat_Data=[basic_Mat_Data,additional_Mat_Data];

% Step 2: create the Tecplot file
if exist(filename,'file')
    delete(filename)
end
f_id=fopen(filename,'a');
fclose(f_id);

% Step 3: create Header of the Tecplot file
plt_Head(filename,title,variables)

% Step 4: create zone of the Tecplot file
plt_Zone(filename,zone_title,IJK,time,Mat_Data)
