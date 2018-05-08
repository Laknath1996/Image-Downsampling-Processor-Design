im =imread('cat.bmp');
im = rgb2gray(im);

A = []; k = 1;
for i=200:-1:1
for j=1:200
A(k)=im(i,j);
k = k+1;
end
end
fid = fopen('cat.txt', 'wt');
fprintf(fid, '%x\n', A);
disp('Text file write done');disp(' ');
fclose(fid);
