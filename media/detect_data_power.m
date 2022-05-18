
%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng

%This function detects which pictures in a series has data hidden in them. it
%assumes that the pictures are named pic1,pic2,etc. T is the number of
%pictures it is analysing. These pictures are created inside of our
%framework, thus they are all .mat files


function A=detect_data_power(t)

%Pictures with power in the one valued DCT less than this value have data
%hidden in them. 
%This threshold varies with the program(paint, Photoshop, etc)
%used to edit the pictures before they were put into our framework. This is
%because different programs use diffent algorithms for picture compression,
%so an "uncompressed" image in one is not the same as an "uncompressed"
%image in another.

threshold=4e9;

hidden_pics=[];

hidden_count=0;

for i=1:t
   
    %load the pictures, again they will be .mat files since they have all
    %be done in our framework. 
    [picname, err]=sprintf('pic%d.mat', i);
    load(picname);
    

    image=invimageproc(read(curr_pic));

    %get the power in the ones coefficents of the DCT
    ones=big_DCT_killer(curr_pic, 1);

    ones_image=invimageproc(ones);
    ones_fft=fft(reshape(ones_image,1,[]));
    power=sum(abs(ones_fft).^2);

    % check to see if its power is less than the threshold power, if it is 
    % then the picture has hidden data in it

        
    if(power>0 && power<threshold)
        [message,err]=sprintf('pic%d has data hidden in it!!', i);
        display(message);
        [dnk sizze]=size(picname);
        hidden_count=hidden_count+1;
        %hack to get around different name lengths
        if(sizze==8)
            picname(9)=' ';
            picname(10)=' ';
            hidden_pics(hidden_count,:)=picname;
        else
            if(sizze==9)
                picname(10)=' ';
                hidden_pics(hidden_count,:)=picname;
            end
        end

    end


end

A=hidden_pics;
