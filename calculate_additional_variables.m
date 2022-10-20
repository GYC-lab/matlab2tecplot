function [additional_variables,additional_Mat_Data] = calculate_additional_variables(serial_num_of_variable,x,y,z,u1,u2,u3,dx,dy,dz)
%   (1)w1       - x vorticity
%   (2)w2       - y vorticity
%   (3)w3       - z vorticity
%   (4)v        - velocity magnitude
%   (5)w        - vortcity magnitude
%   (6)phi      - vortex-surface field
%   (7)Q        - Q criterion

% info of variables
[l,m,n] = size(x);  % size of arrays

% create arraies of variables & mat_data
num_of_variable =numel(serial_num_of_variable);
size_of_variable=size(x(:),1); 
additional_variables       = cell(1,num_of_variable);
additional_Mat_Data        = zeros(size_of_variable,num_of_variable);

% dictionary
dict={'w1','w2','w3','v','w','phi','Q'};

% calculate
for i=1:num_of_variable
    switch serial_num_of_variable(i)
        case 1
            additional_variables(i)=dict(1);
            [w1, w2, w3]=curl(x, y,z, u1,u2, u3);
            additional_Mat_Data(:,i) = w1(:);
        case 2
            additional_variables(i)=dict(2);
            additional_Mat_Data(:,i) = w2(:);
        case 3
            additional_variables(i)=dict(3);
            additional_Mat_Data(:,i) = w3(:);
        case 4
            additional_variables(i)=dict(4);
            v=sqrt(u1.^2+u2.^2+u3.^2);      % veolcity magnitude
            additional_Mat_Data(:,i) = v(:);
        case 5
            additional_variables(i)=dict(5);
            w=sqrt(w1.^2+w2.^2+w3.^2);      % vorticity magnitude
            additional_Mat_Data(:,i) = w(:);
        case 6
            additional_variables(i)=dict(6);
            phi=cos(x).*cos(y).*cos(z);     % vortex-surface field
            additional_Mat_Data(:,i) = phi(:);
        case 7
            additional_variables(i)=dict(7);
            u_x=mydiff(u1,dx,1,l,m,n);
            u_y=mydiff(u1,dy,2,l,m,n);
            u_z=mydiff(u1,dz,3,l,m,n);
            v_x=mydiff(u2,dx,1,l,m,n);
            v_y=mydiff(u2,dy,2,l,m,n);
            v_z=mydiff(u2,dz,3,l,m,n);
            w_x=mydiff(u3,dx,1,l,m,n);
            w_y=mydiff(u3,dy,2,l,m,n);
            w_z=mydiff(u3,dz,3,l,m,n);
            Q = -0.5*(u_x.^2+v_y.*2+w_z.^2+2*u_y.*v_x+2*v_z.*w_y+2*w_x.*u_z);  % Q for incompressible case
            additional_Mat_Data(:,i) = Q(:);
        otherwise
            fprintf('no such serial number: %d', serial_num_of_variable(i));
    end
end

% % assemble
% for i=1:num_of_variable
%     additional_variables = [additional_variables, ];
%     additional_Mat_Data  = [additional_Mat_Data, ];
% end

