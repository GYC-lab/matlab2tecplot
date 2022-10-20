function [df_dx] = mydiff(f,h,dim,l,m,n)
% Function to calculate partial derivative for uniform step size
% Input:
%  f - dependent variable
%  h - step size
%  n - total number of grids
% Output:
%  df_dx - partial derivative

df_dx=zeros(n,m,l);   % partial derivative

% calculate partial derivative with 3-order numerical scheme

switch dim
    case 1
        for k=1:l
            for j=1:m
                for i=1:n
                    if(i==1)
                        df_dx(i,j,k)=(-3*f(1,j,k)+4*f(2,j,k)-f(3,j,k))/2/h;
                    elseif(i==n)
                        df_dx(i,j,k)=(3*f(i,j,k)-4*f(i-1,j,k)+f(i-2,j,k))/2/h;
                    else
                        df_dx(i,j,k)=(f(i+1,j,k)-f(i-1,j,k))/2/h;
                    end
                end
            end
        end
    case 2
        for k=1:l
            for j=1:m
                for i=1:n
                    if(j==1)
                        df_dx(i,j,k)=(-3*f(i,1,k)+4*f(i,2,k)-f(i,3,k))/2/h;
                    elseif(j==m)
                        df_dx(i,j,k)=(3*f(i,j,k)-4*f(i,j-1,k)+f(i,j-2,k))/2/h;
                    else
                        df_dx(i,j,k)=(f(i,j+1,k)-f(i,j-1,k))/2/h;
                    end
                end
            end
        end
    case 3
        for k=1:l
            for j=1:m
                for i=1:n
                    if(k==1)
                        df_dx(i,j,k)=(-3*f(i,j,1)+4*f(i,j,2)-f(i,j,3))/2/h;
                    elseif(k==l)
                        df_dx(i,j,k)=(3*f(i,j,k)-4*f(i,j,k-1)+f(i,j,k-2))/2/h;
                    else
                        df_dx(i,j,k)=(f(i,j,k+1)-f(i,j,k-1))/2/h;
                    end
                end
            end
        end
    otherwise
         fprintf('no such dimension: %d', dim);
end
