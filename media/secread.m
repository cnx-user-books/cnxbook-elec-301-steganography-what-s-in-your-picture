
%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
function V=secread(B,key,len)
%this program takes a tiled matrix B that has hidden data in it using the
%bit-o-steg method and extracts the binary stream back out
%in addition to bit-o-steg you need a key and the length of the message

[dnk dnk x dnk]=size(B);
[dnk keylen]=size(key);
row=1;
col=1;
coeffcounter=1;
keycounter=1;
datacounter=1;
data=[];
char(data);
for i=1:x
    for j=1:x
        for n=1:8
            for m=1:8
            %this works just like the stegcompress, only reading instead of
            %writing
                if (coeffcounter==key(keycounter)&(abs(B(n,m,i,j))>0)&(datacounter<=len))
                    sign=B(n,m,i,j)/abs(B(n,m,i,j));
                    temp=dec2bin(abs(B(n,m,i,j)));
                    siz=size(temp,2);

                    data(datacounter)=temp(siz-key(keycounter)+1);
                    datacounter=datacounter+1;
                    keycounter=keycounter+1;
                    if(keycounter>keylen)
                        keycounter=1;
                    end
                    coeffcounter=1;
                else
                    if (abs(B(n,m,i,j))>0)
                        coeffcounter=coeffcounter+1;
                    end
                end 
            end
        end
    end
end
V=data;
V=char(V);