%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
function B=invimageproc(N)
%input here should always be square
%this takes a matrix that is "tiled" made up of
%8x8 DCT coefficents matricies and forms it back into
%a picture magnitude matrix using the 2D DCT
[dnk dnk x dnk]=size(N);
x1=x*8;
untiled=zeros(x1,x1);
q=qmat();
for i=1:x
    for j=1:x
        untiled(8*i-7:i*8,8*j-7:j*8)=idct2(N(:,:,i,j));
    end
end
B=untiled;