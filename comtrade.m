function  comtgen (source)


RecordName = sprintf('%s_%s',inputname(1),datestr(clock,'HHMMSS__ddmmmyy')); %Store the source variable name 
sampelsPS = 10000; %Here set the sempale time per Second
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

long = size(source); %Take a size of source file how many rows is it?
long = long(1,1); % Put the number of rows in varible long.

points = 1:long; %generate vector with numbers from 1 to rows
points = points'; %transpose "rotate" the vector
uSecondsOffset = (points - 1)*((1/sampelsPS)*1e6); %calculate uS offset of records

d = [points uSecondsOffset source]; % put in one matrix
csvwrite([RecordName '.dat'],d) %record to file with extension .dat


%start write the cfg file
%===================================================================

    fileID = fopen([RecordName '.cfg'],'w');
    
        fprintf(fileID,'Simulink Out -> %s\n',inputname(1));
        %fprintf(fileID,'Simulink Out\n'); 
        fprintf(fileID,'14,8A,6D\n');
        fprintf(fileID,'1,Ia,,, A, 1.0,0.0,0.0,-32767,32767,800.00000000,5.00000000,P\n');
        fprintf(fileID,'2,Ib,,, A, 1.0,0.0,0.0,-32767,32767,800.00000000,5.00000000,P\n');
        fprintf(fileID,'3,Ic,,, A, 1.0,0.0,0.0,-32767,32767,800.00000000,5.00000000,P\n');
        fprintf(fileID,'4,Io,,, A, 1.0,0.0,0.0,-32767,32767,800.00000000,5.00000000,P\n');
        fprintf(fileID,'5,Ua,,, V, 1.0,0.0,0.0,-32767,32767,21000.00000000,100.00000000,P\n');
        fprintf(fileID,'6,Ub,,, V, 1.0,0.0,0.0,-32767,32767,21000.00000000,100.00000000,P\n');
        fprintf(fileID,'7,Uc,,, V, 1.0,0.0,0.0,-32767,32767,21000.00000000,100.00000000,P\n');
        fprintf(fileID,'8,Uo,,, V, 1.0,0.0,0.0,-32767,32767,21000.00000000,100.00000000,P\n');
        fprintf(fileID,'1,Start A,,,0\n');
        fprintf(fileID,'2,Start B,,,0\n');
        fprintf(fileID,'3,Start C,,,0\n');
        fprintf(fileID,'4,Start N,,,0\n');
        fprintf(fileID,'5,Trip OCP,,,0\n');
        fprintf(fileID,'6,Trip EFP,,,0\n');
        fprintf(fileID,'50.000\n');
        fprintf(fileID,'1\n');
        fprintf(fileID,'%6.2f,%i\n',sampelsPS,long); %here is change da data points
        fprintf(fileID,'%s\n',datestr(clock,'dd/mm/yyyy,HH:MM:SS.FFF')); %Write the time in the moment of COMTRADE generation!
        fprintf(fileID,'%s\n',datestr(clock,'dd/mm/yyyy,HH:MM:SS.FFF')); 
        fprintf(fileID,'ASCII\n');
        fprintf(fileID,'1.0');
    
    fclose(fileID);



clear('long');
clear('points');
%sprint('%s%s'RecordName,datestr(clock,'dd/mm/yyyy,HH:MM:SS.FFF'))
disp('COMTRADE generated successfully!')
disp(sprintf('File Name :%s_%s',RecordName,datestr(clock,'HHMMSS__ddmmmyy')));
