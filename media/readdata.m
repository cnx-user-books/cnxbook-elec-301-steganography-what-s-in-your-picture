function [bindat, binmat] = readdata(filename);
% Function: function [bindat, binstream] = readdata(filename);
% Purpose: Read in the data
% filename must be a string
% binmat is the resulting matrix of binary. binstream is used for user's
% verification of bindat
% bindat is the resulting stream of binary data

% Initialize bindata
bindata = [];

% Open the file
fid = fopen(filename, 'r');

% Check to make sure that the file exists
if (fid == -1) 
    error('read_file: cannot open file for reading');
end

% Scan the contents of the file. Scan in the contents as characters.
charstream = fscanf(fid, '%c');

% Convert the stream to uint8
intstream = uint8(charstream);

% Convert uint8 to binary
binmat = dec2bin(intstream);

% Convert binary matrix to binary stream
[row,col] = size(binmat);
for i=1:row
    for j=1:col
        bindata = [bindata binmat(row*(j-1) + i)]; 
    end
end

bindat= bindata;

% Close the file
fclose(fid);