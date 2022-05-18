%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
function B=image_hist(N,bins);
%Please input a square matrix that has multiple of 8 dimensions
%bins should range over at least -20:20
%this takes a histogram of the DCT coefficeient values
[x dnk]=size(N);
x1=x/8;

histogram=zeros(size(bins));

tiled=zeros(8,8,x1,x1);

%break up the matrix into 8x8 tiles and take histogram of DCT
for i=1:x1
    for j=1:x1
        DCT1=round(dct2(N(8*i-7:i*8,8*j-7:j*8)));
        temp=hist(reshape(DCT1, 1,[]), bins);
       
        histogram=histogram+temp;
    end
end

B=histogram;
