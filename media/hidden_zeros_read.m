%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
%This program takes in a tiled matrix and reads any data that has 
%been hidden by the zeros hiding method

 function out=hidden_zeros_read(B,t)
 
out=[];
% [dnk dnk x x]=size(B);
% %keeps= x^2*8^2;
% drops=0;
 lengthcounter=1;
% for i=1:x
%     for j=1:x
%         for m=1:8
%             for n=1:8
%                 if (B(m,n,i,j)<=t&&(B(m,n,i,j)>0))
%                     out(lengthcounter)=B(m,n,i,j);
%                     lengthcounter=lengthcounter+1;
%                 end
%             end
%         end
%     end
% end
[y x]=size(B);
jvect=[];
numcoeff=1;

temp8=zeros(8,8);
tempv8=zeros(1,64);
temp_allvect=[];

vects=1;

rows= [1 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];
colm= [1 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];
for j=1:y
    for i=1:x/3


        if B(j,i*3-2)>0
            tempv8(numcoeff)=-B(j,i*3-2);
            numcoeff=numcoeff+1;
        else
            if B(j,i*3-1)>0
                tempv8(numcoeff)=B(j,i*3-1);
                numcoeff=numcoeff+1;
            else
                if B(j,i*3)>0
                    numcoeff=numcoeff+B(j,i*3);

                else

                    break;



                end

            end
        end


        if numcoeff==65
            numcoeff=1;

            temp_allvect(:,vects)=tempv8;
            vects=vects+1;
            tempv8=zeros(1,64);
        end


    end
end


[dnk x]=size(temp_allvect);


for i=1:x
    %code to block using the traversing path

    
    for j=1:64
        temp_allvect(j,i);
        if ((abs(temp_allvect(j,i))<=t)&&abs((temp_allvect(j,i)))>0)
            out(lengthcounter)=abs(temp_allvect(j,i));
            lengthcounter=lengthcounter+1;
        end
        %A(rows(j), colm(j))=temp_allvect(j,i);
    end

  


end
end