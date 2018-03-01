%MATLAB Implementation of the Image Downsampling Algorithm

%Author : Ashwin de Silva
%Last Updated : 2018 Feb 28

clear all;
close all;

%Load the image

im = imread('Girl1.bmp');
im = rgb2gray(im);
img = im;

%Display the original image

figure;
title('Original Image');
imshow(im);

%Cast the image to a 1D array 

M = reshape(im',[1,512*512]);

%Image downsampling algorithm

counter = 514;
address = 1;
while (counter < 510*510)
    if mod(counter,1024) == 0
        counter = counter + 512 + 2;
        continue;
    end
    G = zeros(1,9);
    G(1) = M(counter - 512 - 1)*1;
    G(2) = M(counter - 512)*2; 
    G(3) = M(counter - 512 + 1)*1;
    G(4) = M(counter - 1)*2;
    G(5) = M(counter)*3;
    G(6) = M(counter + 1)*2;
    G(7) = M(counter + 512 - 1)*1;
    G(8) = M(counter + 512)*2;
    G(9) = M(counter + 512 + 1)*1;
    
    avg = sum(G)/1;
    M(address) = avg;
    address = address + 1;
    counter = counter + 2;
end

%Extract the image from M-array 

ds_im = M(1:255*255);
ds_im = reshape(ds_im,[255,255]);
ds_im = ds_im';

ds_im = uint8(ds_im);

figure;
imshow(ds_im);

%Operation using the MATLAB built-in function

imNew = imresize(img,0.5);
figure;
imshow(imNew);








