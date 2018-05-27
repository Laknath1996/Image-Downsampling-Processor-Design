import numpy as np
import serial
import time
import scipy.io as sio
import cv2
 
print('Welcome to FPGA based Image Downsampler')

#read the image pixel data

##mat = sio.loadmat('image.mat')
##image = mat['A']

#read image from the source

image = cv2.imread('Girl1.bmp',0)
image = cv2.resize(image,(256,256))

#prepare the image for transmission

image.astype(int)
image = np.reshape(image,65536) #reshape the image matrix into an array
trans_array = np.zeros(65537)
trans_array[0] = 255 #save (length of one side of the image - 1) in the 0th position in the array

for x in range(1,len(trans_array)) :
    trans_array[x] = image[x-1]

trans_array = np.array(trans_array,dtype = int)

s = serial.Serial('COM3', 115200) #define the serial port

print('Sending data...')

L = 65536
t1 = time.time()

#send the data serially

for x in range(0, L):
    s.write(bytearray([trans_array[x]]))

t = time.time() - t1

print('Sending Complete')
print('Elapsed time ' + str(t) + ' s')
print('Receiving data...')

rx_count = 0
rx_img = []

t2 = time.time()

#receive data from the serial port

while(1):
    raw = s.read()
    rx_img.append(raw)
    rx_count = rx_count + 1
    if rx_count == 127*127+1:
        break

t = time.time() - t2
total_t = time.time() - t1 #calculate the time elapsed

print('Receiving Complete')
print('Elapsed time ' + str(t) + ' s')
print('Total time ' + str(total_t) + ' s')
print('result_image array : ')

#convert the bytearray data to int

for x in range(len(rx_img)) :
    rx_img[x] = int.from_bytes(rx_img[x], byteorder='big', signed=False)

print('Number of values received : ',len(rx_img))

#display the original image

print('displaying the original image')
image = np.reshape(image,(256,256))
image = np.array(image,dtype = np.uint8)

cv2.imshow('Original Image',image)


#display the downsampled image from the FPGA

print('displaying the downsampled image from the FPGA')
result = np.reshape(rx_img[1:127*127+1],(127,127))
result = np.array(result,dtype = np.uint8)

cv2.imshow('Downsampled Image',result)

#downsample the image using python script

print('displaying the simulated downsampled image')
#mat = sio.loadmat('image.mat')
#im = mat["A"]
im = cv2.imread('Girl1.bmp',0)
im = cv2.resize(image,(256,256))
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
    total += image[counter1 + 256]*2
    total += image[counter1 + 256 +1]

    avg = int(total / 16)

    image[counter3] = avg

    counter3 += 1
    counter2 += 2
    counter1 += 2

simulated_im = image[1:127*127+1]
simulated_im = np.reshape(simulated_im,(127,127))

#display the simulated image 

simulated_im = np.array(simulated_im,dtype = np.uint8)

cv2.imshow('Simulated Image',simulated_im)

#compute the downsampling using the opencv function

print('displaying the opencv downsampled image')
image = cv2.imread('Girl1.bmp',0)
image = cv2.resize(image,(256,256))
cv_ds_im = cv2.resize(image,(127,127))
cv2.imshow('opencv downsampled Image',cv_ds_im)

#Error Analysis - Absolute Error and SSD

print('Analyzing the Error..')

#### Absolute Error ####

result = np.reshape(result,127*127)
simulated_im = np.reshape(simulated_im, 127*127)
cv_ds_im  = np.reshape(cv_ds_im, 127*127)
diff = result - simulated_im
diff1 = result - cv_ds_im
abs_error = sum(np.absolute(diff))
abs_error1 = sum(np.absolute(diff1))

#### Sum of Square Differences ####

sq_diff = np.power(diff,2)
SSD = sum(sq_diff)
sq_diff1 = np.power(diff1,2)
SSD1 = sum(sq_diff1)

non_zero_count = np.count_nonzero(diff)
max_error = max(np.absolute(diff))
non_zero_count1 = np.count_nonzero(diff1)
max_error1 = max(np.absolute(diff1))

print('Absolute Error with simulated image : ',abs_error)
print('Sum of Square Difference with simulated image : ',SSD)
print('Non zero count with simulated image : ',non_zero_count)
print('Maximum Error with simulated image : ',max_error)


print('Absolute Error with opencv downsampled image : ',abs_error1)
print('Sum of Square Difference with opencv downsampled image : ',SSD1)
print('Non zero count with opencv downsampled image : ',non_zero_count1)
print('Maximum Error with opencv downsampled image : ',max_error1)

print('Error Analysis Complete')

print('Downsampling Process Complete')








