%301 Project, What's in Your Picture?
%Copyright 2005 Charlie Ice, Bryan Grandy, Danny Blanoc, Elliot Ng
%
%This program works for 400X400 pictures and generates the statistics for
%the power in the ones of a picture and the power of the ones of a picture
%that has data hidden in it. The program is easily modified to handle
%pictures of larger size. 
%
%All the pictures and files used in the program are names pic1, pic2, etc
%and file1, file2, etc.
%


%clear variables we will be using
clear hidden_power;
clear pics;
clear nothing_power;
clear sizze

%read in the pictures, here we are only going to look at two pictures
for i=1:2
    [filename, err]=sprintf('pic%d.jpg', i);
    pics(i,:,:)=imread(filename);
end

%Find average power in the one valued dct coefficients
%in all the pictures. There are several ways to do this, we chose to look
%at the power in the frequency domain. 

for i=1:2
    sizze=size(pics(i,:,:));
    ones=big_DCT_killer(reshape(pics(i,:,:),sizze(1,2),sizze(1,3),[])',1);
    ones_image=invimageproc(ones);
    ones_fft=fft(reshape(ones_image,1,[]));
    nothing_power(i)=sum(abs(ones_fft).^2);
end

save( 'pics_power', 'pics', 'nothing_power');
display('saved pics!!');


%now put the data files into the pictures and see what the new power
%distribution looks like

%read in the files, if the files have alread been read in this can be
%omitted.

%clear variable files
clear files;

for i=1:2
[filename, err]=sprintf('file%d', i);
eval([filename '=readdata(filename)']);
end


%assumes the file read program has been run
jcount=1;
icount=1;
for i=1:2
    sizze=size(pics(i,:,:));
    
        compressed=signed_mat2DCEB(reshape(pics(i,:,:),sizze(1,2),sizze(1,3),[]), 18);

    for j=1:2
        %file(i) is already a variable in MATLAB
        %parse name of next file ('file'i) then set data equal to what is
        %in that variable using the eval command
        [filename, err]=sprintf('file%d', j);
        eval(['data =' filename ';']);

        %compress picture, hide data, get picture back out
    
        hidden=signed_hide_zeros_stegcompress(compressed, data, 18);
        image=invimageproc(read(hidden));

        %keep only the DCT coefficients with magnitude 1 and find the power
        hidden_ones=big_DCT_killer(image,1);
        hidden_ones_image=invimageproc(hidden_ones);

        hidden_ones_fft=fft(reshape(hidden_ones_image,1,[]));
        hidden_power(count)=sum(abs(hidden_ones_fft).^2);

        jcount=jcount+1
    end
    icount=icount+1
end

save hidden_power hidden_power;
