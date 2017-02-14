# Intrinsic parameters of left camera:
# Focal Length:          fc_left = [ 647.12178   651.37972 ]  [ 16.08115   16.08996 ]
# Principal point:       cc_left = [ 325.81281   235.84630 ]  [ 13.37134   16.14085 ]
# Skew:             alpha_c_left = [ 0.00000 ]  [ 0.00000  ]   => angle of pixel axes = 90.00000  0.00000 degrees
# Distortion:            kc_left = [ 0.09835   0.24303   -0.00742   0.00080  0.00000 ]  [ 0.06238   0.26006   0.01155   0.00988  0.00000 ]
###
###
# Intrinsic parameters of right camera:
###
# Focal Length:          fc_right = [ 613.94651   618.59549 ]  [ 12.08070   11.90797 ]
# Principal point:       cc_right = [ 339.77763   239.41874 ]  [ 9.13789   11.19213 ]
# Skew:             alpha_c_right = [ 0.00000 ]  [ 0.00000  ]   => angle of pixel axes = 90.00000 0.00000 degrees
# Distortion:            kc_right = [ 0.23488   -0.46363   -0.00081   -0.00302  0.00000 ] [ 0.04533   0.15011   0.00781   0.00715  0.00000 ]
###
###
# Extrinsic parameters (position of right camera wrt left camera):
###
# Rotation vector:             om = [ -0.01532   -0.01535  -0.02971 ]
# Translation vector:           T = [ 408.47345   -19.06325  -103.47753 ]
###
###
###
###
#It creates a disparity map of the video we have
# the disparity map is the 
###
#import the necessary libraries
import numpy as np
import cv2
from matplotlib import pyplot as plt
import imutils
import math
from scipy.stats import norm
from numpy import linalg as LA
from multiprocessing import Process
import time
from itertools import izip
#declare global variables
global cX_l, cX_r, cY_l, cY_r
#save the camera parameters

fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()

#Focal Length
#fc_left.astype('float')
fc_left = np.matrix((657.5494, 658.5350), dtype = 'float64')
print fc_left[0, 1]
#Principal Point
cc_left = np.matrix((302.6094, 199.5658), dtype = 'float64')
#skew
alpha_c_left = np.array(0.000)
#distortion Parameters
kc_left = np.matrix((0.2944, -0.55615, -0.01866, 0.01300, 0.0000), dtype = 'float64')
print kc_left

fc_right = np.matrix((626.7081, 631.3745), dtype = 'float64')
cc_right = np.matrix((309.3849, 216.5329),dtype = 'float64')
alpha_c_right = np.array(0.000)
kc_right = np.matrix((0.02157, -0.0617, -0.01068, 0.00486, 0.0000), dtype = 'float64')

print kc_right
#Extrinsic Parameters
rot_vec = np.matrix((0.03528, -0.06943, 0.04552), dtype = 'float64')
print rot_vec
trans_vec = np.matrix((409.23676, 7.52045, -43.40462), dtype = 'float64')
print trans_vec 
#read the frame by frame of the left camera
cap_l = cv2.VideoCapture("left.avi")
#cap_l = cv2.VideoCapture(0)
#read the frame by frame of the right camera
cap_r = cv2.VideoCapture("right.avi")
#cap_l = cv2.VideoCapture(1)

# height, width, channels = cap_l.shape

ret_test, frame_test = cap_l.read()
width, height, channels = frame_test.shape
print height, width, channels
# 3X3 Camera Matrix 1 after Stereo Calibration 
# the intrinsic camera parameters
camera_Matrixleft = np.matrix(([fc_left[0, 0], 0, cc_left[0, 0]], [0, fc_left[0, 1], cc_left[0, 1]], [0, 0, 1]), dtype = 'float64')
print camera_Matrixleft
# 3X3 Camera Matrix 2 after Stereo Calibration
# intrinsic right camera parameters
camera_Matrixright = np.matrix(([fc_right[0, 0], 0, cc_right[0, 0]], [0, fc_right[0, 1], cc_right[0, 1]], [0, 0, 1]), dtype = 'float64')
print camera_Matrixright
#lets rectify the images

R1 = np.zeros(shape = (3, 3), dtype = 'float64')
print R1
R2 = np.zeros(shape = (3, 3), dtype = 'float64')
print R2
P1 = np.zeros(shape = (3, 4), dtype = 'float64')
print P1
P2 = np.zeros(shape = (3, 4), dtype = 'float64')
print P2


P1 = camera_Matrixleft * np.matrix(([1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0]), dtype = 'float64')
print P1
P2 = camera_Matrixright * np.matrix(([1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0]), dtype = 'float64') * np.matrix(([0.03528, 0, 0, 409.23676], [0, -0.069430, 0, 7.5204], [0, 0, 0.04552, -43.40462], [0, 0, 0, 1]), dtype = 'float64')
print P2
#Rectify the images
#cv2.stereoRectify(camera_Matrixleft, kc_left, camera_Matrixright, kc_right, (width, height), rot_vec, trans_vec, R1, R2, P1, P2, Q = None, flags = 0, alpha = -1, newImageSize = (0, 0))
#undistort the images
#map1x , map1y = cv2.initUndistortRectifyMap(camera_Matrixleft, kc_left, R1, P1, (width, height))
#map2x , map2y = cv2.initUndistortRectifyMap(camera_Matrixright, kc_right, R2, P2, (width, height))

#remap the images
image_U_left = np.zeros((height, width, 3), np.uint8)
image_U_right = np.zeros((height, width, 3), np.uint8)

#Lets read image frame by frame
while True:
	ret_l, frame_l = cap_l.read()
	ret_r, frame_r = cap_r.read()

	#converts to the grayscale, 8UCV1
	frame_l = cv2.cvtColor(frame_l, cv2.COLOR_BGR2GRAY)
	frame_r = cv2.cvtColor(frame_r, cv2.COLOR_BGR2GRAY)

	#cv2.imshow('Right', gray_r)
	#cv2.imshow('Left', gray_l)

	#Remap using Rectification and Undistort
	
	#image_U_left = cv2.remap(frame_l, map1x, map1y, cv2.INTER_LINEAR, image_U_left, cv2.BORDER_CONSTANT, 0)
	#image_U_right = cv2.remap(frame_r, map2x, map2y, cv2.INTER_LINEAR)

	stereo = cv2.StereoBM_create(numDisparities = 16, blockSize = 15)
	#calculates the stereo pair of the images 
	#finds the disparity map of the images
	#disparity = stereo.compute(image_U_left, image_U_right)

	#print disparity

	#perform object detection and identification
	fgmask_l = fgbg.apply(frame_l)

	fgmask_r = fgbg.apply(frame_r)

	cv2.imshow('Left Mask', fgmask_l)
	cv2.imshow('Right Mask', fgmask_r)

	cv2.waitKey(0)

	im_l, contours_l, hierarchy_l = cv2.findContours(frame_l, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
	im_r, contours_r, hierarchy_r = cv2.findContours(frame_r, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

	print ("The left contours are {}".format(contours_l))
	print ("The right contours are {}".format(contours_r))
	
	for c in contours_l:
		M_l = cv2.moments(c)
		cX_l = M_l["m10"] / M_l["m00"]
		cY_l = M_l["m01"] / M_l["m00"]
		print "X_l" + str(cX_l)+ "Y_l" + str(cY_l)
	for c in contours_r:
		M_r = cv2.moments(c)
		cX_r = M_r["m10"] / M_r["m00"]
		cY_r = M_r["m01"] / M_r["m00"]
		print "X_r" + str(cX_r)+ "Y_r" + str(cY_r)

	#now find the co-ordinates of the point in 3D space
	pts_l = np.matrix(([cX_l], [cY_l]), dtype = 'float64')
	print ("The points in left image are{}".format(pts_l))
	pts_r = np.matrix(([cX_r], [cY_r]), dtype = 'float64')
	print ("The points in right image are{}".format(pts_r))
	pts_final = np.zeros(shape = (4, 1))


	cv2.triangulatePoints(P1, P2, pts_l, pts_r, pts_final)
	pts_final /= pts_final[3]
	print ("The Final points{}".format(pts_final))
	#find the norm of the vector to find the distance of the detected object.
	distance = LA.norm(pts_final)
	distance /= 10000
	print distance

	
    # fgmask_r = fgbg.apply(frame_r)
	# im_r, contours_r, hierarchy_r = cv2.findContours(frame_r, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)


	
	#it shows the disparity map of the images
	#plt.imshow(disparity, 'gray')
	#prints the output
	#plt.show()

cap.release()
cv2.destroyAllWindows()
