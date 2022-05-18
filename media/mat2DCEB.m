function B=mat2DCEB(N,t);
%This takes a picture matrix of magnitudes N and a threshold t the
%matrix is then broken up into 8x8 tiles then transformed using the DCT
% the results are rounded for a slight quantitization.
%this method does not give exact compression ratios, but the compression
%occurs more in the less significant frequencies rather than across the
%entire range of coefficents
%
%
%Please input a square matrix that has multiple of 8 dimensions
[x dnk]=size(N);
x1=x/8;


tiled=zeros(8,8,x1,x1);

q=qmat();

%break up the matrix into 8x8 tiles and quantize
for i=1:x1
    for j=1:x1
        tiled(:,:,i,j)=round(dct2(N(8*i-7:i*8,8*j-7:j*8)));
        %traverses the magnitude matrix in 8x8 blocks then 
        %takes the 2d dct and forms a "tiled" matrix
    end
end



%drop coefficients at or below the threshold value
x=size(tiled,3);
keeps= x^2*8^2;
drops=0;
for i=1:x
    for j=1:x
        for m=1:8
            for n=1:8
                if (abs(tiled(m,n,i,j))<=t)
                    tiled(m,n,i,j)=0;
                    drops=drops+1;
                end
            end
        end
    end
end
%outputs the # kept and dropped
%this is useful for determining max data length
keeps=keeps-drops;
sprintf('drops=%d',drops)
sprintf('keeps=%d',keeps)
B=tiled;