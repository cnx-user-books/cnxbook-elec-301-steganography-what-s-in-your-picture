function V=stegcompress(B,key,data)
%this steganographic program hides the data using the LSBs of the dct
%coefficients. It uses a key to determine which coefficents to use and
%which bits to hide the data in. This reduces the probability that common
%seganalysis algorithms will know that the data is in the file.
%
%B should be a 4d tiled matrix
%B may be compressed by using the compress program first
[dnk dnk x dnk]=size(B);
[dnk keylen]=size(key);
[dnk datalen]=size(data);

row=1;
col=1;
coeffcounter=1;
keycounter=1;
datacounter=1;
for i=1:x
    for j=1:x
        for n=1:8
            for m=1:8
                if(datacounter>datalen)
                    break
                end
                %find a coefficient to alter using the key
                if (coeffcounter==key(keycounter)&(abs(B(n,m,i,j))>0))
                    sign=B(n,m,i,j)/abs(B(n,m,i,j));%preserve sign
                    temp=dec2bin(abs(B(n,m,i,j)));%convert to binary
                    siz=size(temp,2);
                    %change the bit determined by the key    
                    temp(siz-key(keycounter)+1)=data(datacounter);
                        

                    B(n,m,i,j)=sign*bin2dec(temp);%reassert the sign

                    datacounter=datacounter+1;
                    keycounter=keycounter+1;
                    if(keycounter>keylen)
                        keycounter=1;
                    end
                    coeffcounter=1;
                else
                    %zero is not a valid coefficient to alter
                    if (abs(B(n,m,i,j))>0)
                        
                        coeffcounter=coeffcounter+1;
                    end
                end 
            end
        end
    end
end

%vectorize, condense zeros and build a matrix for writing to a file
%see std_stegcompress for more details
for i=1:x
    for j=1:x
       
        A= dropzeros(jvector(B(:,:,i,j)));
        [dnk m]=size(A);
        temp_col=col+m;
        
        if(temp_col>60000)
            row=row+1;
            col=1;
        end

        temp(row,col:col+m-1)=A(1,:);
        col=col+m;
    
        
        
    end
end
V=temp;