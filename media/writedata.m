function res = writedata(bindat, filename);
%bindat is a stream of binary values
%filename is the file to write to

binmat = [];

% Reconstruct binary matrix
[dnk, sizebindat] = size(bindat);
for i=1:(sizebindat/8)
   bintemp(i,:) = bindat((i-1)*8+1:i*8);
end

binmat=bintemp;

% Get a decimal vector
decvec = transpose(bin2dec(binmat));

% Typecast the decimal vector to a char
% Res is the data that we want to write to the file
res=char(decvec);

% Open the file
% Check to make sure that the file exists
fid = fopen(filename, 'w');
if (fid == -1) 
    error('write_file: cannot open file for writing');
end

% Write data res to file fid
fwrite(fid,res);

% Close the file
fclose(fid);