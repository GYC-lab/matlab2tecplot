function plt_Zone(filename,zone_title,IJK,time,Mat_Data)
% Function to write Zone of Tecplot
% Input:
%  filename  - character string of file name of exported data
%  zone_title- title of Zone 
%  IJK       - size of each dimension
%  time      - title of the .plt file
%  Mat_Data  - names of variables to export

f_id=fopen(filename,'a');
N=size(Mat_Data,1);     % total number of lines

Dim=numel(IJK); % how many dimensions and get sizes of each dimension
if Dim==1
    s=['zone I=',num2str( IJK(1) )];
elseif Dim==2
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) )];
elseif Dim==3
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) ),',K=',num2str( IJK(3) )];
end

% zone title
if ~isempty(zone_title)
    s=[s,',t="',zone_title,'"'];
end
fprintf(f_id,'%s \r\n',s);

% zone format: point
s='DATAPACKING=point';
fprintf(f_id,'%s \r\n',s);

% specify time of solution, especially for unsteady problems
if ~isempty(time)
    s=['SOLUTIONTIME=',num2str(time)];
    fprintf(f_id,'%s \r\n',s);
end

% write data
for k=1:N
    fprintf(f_id,'%s \r\n',num2str(Mat_Data(k,:))); % write data line by line
end
fclose(f_id);
end
