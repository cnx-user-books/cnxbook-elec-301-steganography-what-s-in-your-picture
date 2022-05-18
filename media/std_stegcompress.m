%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
function V=std_stegcompress(B)
%this function takes a "tiled" DCT matrix and converts it into
%one long string that wraps around. The string is a "compressed"
%version of the tiled matrix. It first traverses each block in
%a way that maximizes the number of consecutive zeros. Next it forms
%length 3 "words' that represent either a postive DCT coefficent, negative
%coefficent, or a group of consecutive zeros, this can be done using only
%11 bits and get 512 shades of gray or as little a here we use an easier to
%manage but more redundant version where we use three semi-redundant
%unsigned integers. 
%Example 1: the entry {-6} is representede by {6 0 0}
%Example 2: the entry {5} is represented by {0 5 0} 
%Example 3: the entries {0 0 0 0} are represented by {0 0 4}
x=size(B,3);


row=1;
col=1;

for i=1:x
    for j=1:x
      %this first vectorizes the 8x8 "tiles" in the B matrix, then groups
      %the zeros
        A= dropzeros(jvector(B(:,:,i,j)));
        m=size(A,2);
        temp_col=col+m;
        %here we have to build the output array into a matrix so that we
        %can maniupulate large files. Before we did this we could easily
        %hit the matlab array length limit of 65536
        if(temp_col>60000)
            row=row+1;
            col=1;
        end

        temp(row,col:col+m-1)=A(1,:);
        col=col+m;
    
        
        
    end
end
V=temp;