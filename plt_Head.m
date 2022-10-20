function plt_Head(filename,title,variables)
% Function to write Header of Tecplot
% Input:
%  filename  - character string of file name of exported data
%  title     - title of Tecplot file
%  variables - names of variables to export

f_id=fopen(filename,'a');

% write title of Tecplot file
if ~isempty(title)
    s=['TITLE = "',title,'"'];
    fprintf(f_id,'%s \r\n',s);
end

% write variables
v=numel(variables);
s='VARIABLES = ';
for k=1:v
    if k~=1
        s=[s,','];
    end
    s=[s,' "',variables{k},'"'];
end
fprintf(f_id,'%s \r\n',s);
fclose(f_id);



