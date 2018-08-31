# -*- coding: utf-8 -*-
"""
Created on Thu Nov  9 21:30:26 2017

@author: admin
"""

import cv2

import numpy as np
from matplotlib import pyplot as plt

img1 = cv2.imread('img1.png',0)          # queryImage
img2 = cv2.imread('img2.png',0) # trainImage

  # Initiate ORB detector
orb = cv2.ORB_create()

# find the keypoints and descriptors with ORB
kp1, des1 = orb.detectAndCompute(img1,None)
kp2, des2 = orb.detectAndCompute(img2,None)

  # create BFMatcher object
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

 # Match descriptors.
matches = bf.match(des1,des2)

 # Sort them in the order of their distance.
matches = sorted(matches, key = lambda x:x.distance)

 # Draw first 10 matches.
img3 = cv2.drawMatches(img1,kp1,img2,kp2,matches[:80] ,None, flags=2)

plt.imshow(img3),plt.show()

list_kp1 = [kp1[mat.queryIdx].pt for mat in matches] 
list_kp2 = [kp2[mat.trainIdx].pt for mat in matches]

