%%converts the image to a binary text

im =imresize(imread('lena.jpg'),[256 256]);
%%im = rgb2gray(im);

A = []; k = 1;
for i=256:-1:1
for j=1:256
A(k)=im(i,j);
k = k+1;
end
end


fid = fopen('lena.txt', 'wt');

t = cellstr(dec2bin(A, 8));
fprintf(fid, '%s\n', t{:}); 
disp('Text file write done');disp(' ');
fclose(fid);