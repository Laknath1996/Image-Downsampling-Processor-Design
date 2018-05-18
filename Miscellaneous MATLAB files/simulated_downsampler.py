import numpy as np
import scipy.io as sio
import cv2

#downsample the image using python script

mat = sio.loadmat('image.mat')
im = mat["A"]
im.astype(int)
im = np.reshape(im,65536)
image = np.zeros(65536)
image[0] = 255
for i in range(1,len(im)) :
    image[i] = im[i-1]

counter1 = 258
counter2 = 2
counter3 = 1

while(counter1 < 65024) :
    if (counter2 - 256 == 0) :
        counter1 = counter1 + 256 + 2;
        counter2 = 2;

    total = 0

    total += image[counter1 - 256 -1]
    total += image[counter1 - 256]*2
    total += image[counter1 - 256 +1]
    total += image[counter1 -1]*2
    total += image[counter1]*4
    total += image[counter1 +1]*2
    total += image[counter1 + 256 -1]
    total += image[counter1 + 256 -1]*2
    total += image[counter1 + 256 -1]

    avg = total / 16

    image[counter3] = avg

    counter3 += 1
    counter2 += 2
    counter1 += 2

downsampled_im = image[1:127*127+1]
downsampled_im = np.reshape(downsampled_im,(127,127))
#downsampled_im = downsampled_im.T

#display the simulated image 

downsampled_im = np.array(downsampled_im,dtype = np.uint8)

cv2.imshow('Simulated Image',downsampled_im)
