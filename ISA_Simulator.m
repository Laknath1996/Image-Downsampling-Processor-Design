%Intruction Set Architecture Simulator

%Author : Ashwin de Silva
%Last Updated : 2018 Mar 2

clear all;
close all;

%Define all the used resgisters

global L;
global T;
global C1;
global C2;
global C3;
global E;
global DRAM;
global AC;
global MAR;
global Z;
global IRAM;
global i;

L = 0;T = 0;C1 = 0;
C2 = 0;C3 = 0;E = 0;
AC = 0;MAR = 0;Z = 0;

%Define the Data Memory
%========================================

%Load the image

im = imread('Girl1.bmp');
im = rgb2gray(im);
img = im;

%Display the original image

figure;
title('Original Image');
imshow(im);

im = double(im);

%Cast the image to a 1D array 
% 
DRAM = reshape(im',[1,512*512]);
% DRAM = zeros(1,512*512+1);
% DRAM(2:end) = temp;
% DRAM(1) = 512;

%Define the Instruction Memory
%========================================

IRAM = {'CLAC'
'MVACMAR'		
'MVACC2'		
'LDL' 	
'MVACL'		
'INAC'			
'INAC'		
'MVACC1'		
'CLAC'			
'INAC'			
'MVACC3'		
'MVL'			
'DEAC'			
'MUL512'		
'DEAC'		
'DEAC'			
'MVACE'	
'CLAC'			
'MVACT'		
'MVC1'			
'SUBL' 			
'DEAC'			
'MVACMAR'		
'LDAC'			
'ADDT'			
'MVACT'		
'MVC1'			
'SUBL'			
'MVACMAR'		
'LDAC'			
'MUL2'			
'ADDT'			
'MVACT'		
'MVC1'		
'SUBL'			
'INAC'
'MVACMAR'
'LDAC'			
'ADDT'			
'MVACT'			
'MVC1'			
'DEAC'
'MVACMAR'
'LDAC'			
'MUL2'			
'ADDT'			
'MVACT'		
'MVC1'			
'MVACMAR'		
'LDAC'			
'MUL4'			
'ADDT'			
'MVACT'		
'MVC1'		
'INAC'			
'MVACMAR'		
'LDAC'			
'MUL2'			
'ADDT'			
'MVACT'		
'MVC1'			
'ADDL'			
'DEAC'			
'MVACMAR'		
'LDAC'				
'ADDT'			
'MVACT'		
'MVC1'			
'ADDL'			
'MVACMAR'		
'LDAC'			
'MUL2'			
'ADDT'			
'MVACT'			
'MVC1'			
'ADDL'			
'INAC'			
'MVACMAR'				
'LDAC'			
'ADDT'			
'MVACT'		
'MVC3'			
'MVACMAR'		
'MVT'			
'DIV'			
'STAC'			
'MVC3'			
'INAC'			
'MVACC3'		
'MVC2'			
'INAC'			
'INAC'			
'MVACC2'		
'MVC1'			
'INAC'			
'INAC'			
'MVACC1'		
'MVC1'			
'SUBE'			
'JMPZ'					
'MVC2'			
'SUBL'		
'JMNZ'	
'MVC1'			
'ADDL'			
'INAC'			
'INAC'			
'MVACC1'		
'CLAC'			
'MVACC2'		
'JUMP'
'NOP'};


%Execute the instructions
%========================================

i = 1;
while true
    if strcmp(IRAM(i),'NOP') == 1
        break;
    end
    
    assembler(IRAM(i));
    i = i + 1;
    disp(C1)
end

%Display the downsampled image
%============================================

%Extract the image from M-array 

ds_im = DRAM(2:255*255+1);
ds_im = reshape(ds_im,[255,255]);
ds_im = ds_im';

ds_im = uint8(ds_im);

figure;
imshow(ds_im);

%Operation using the MATLAB built-in function

imNew = imresize(img,0.5);
figure;
imshow(imNew);

    
    



