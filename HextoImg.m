%Author : Ashwin de Silva
%Last Updated : 2018 Feb 31

%Hex to Image

system('python list_reshape.py');

f = fopen('final_output.txt','r');
A = fscanf(f,'%x');

M = zeros(200,200); %image size

M = reshape(A,200,200);                                                                                                                                                                                               
M = uint8(M);
M = mat2gray(M);
imshow(M);


