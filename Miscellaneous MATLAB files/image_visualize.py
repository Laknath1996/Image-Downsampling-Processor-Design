import numpy as np
import cv2
import scipy.io as sio

mat = sio.loadmat('image.mat')
image = mat['A']
print(image)
image = np.reshape(image,(256,256))
image = np.array(image,dtype = np.uint8)

cv2.imshow('Image', image)
