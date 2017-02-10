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
#declare global variables
global cX_l, cX_r, cY_l, cY_r
#save the camera parameters

#Focal Length
#fc_left.astype('float')
fc_left = np.matrix((533.5233, 533.5270), dtype = 'float64')
print fc_left[0, 1]
#Principal Point
cc_left = np.matrix((341.6038, 235.19287), dtype = 'float64')
#skew
alpha_c_left = np.array(0.000)
#distortion Parameters
kc_left = np.matrix((-0.2884, 0.0971, 0.00109, -0.0003, 0.0000), dtype = 'float64')
print kc_left

fc_right = np.matrix((536.8138, 536.4765), dtype = 'float64')
cc_right = np.matrix((326.2865, 250.1012),dtype = 'float64')
alpha_c_right = np.array(0.000)
kc_right = np.matrix((-0.2894, 0.10690, -0.0006, 0.0001, 0.0000), dtype = 'float64')

print kc_right
#Extrinsic Parameters
rot_vec = np.matrix((0.00669, 0.0045, -0.0035), dtype = 'float64')
print rot_vec
trans_vec = np.matrix((-99.8019, 1.2443, 0.05041), dtype = 'float64')
print trans_vec 
#read the frame by frame of the left camera
cap_l = cv2.VideoCapture("/home/goelshivam12/my_video_left.avi")
#read the frame by frame of the right camera
cap_r = cv2.VideoCapture("/home/goelshivam12/my_video_right.avi")
#height, width, channels = cap_l.shape

ret_test, frame_test = cap_l.read()
width, height, channels = frame_test.shape
print height, width, channels
# 3X3 Camera Matrix 1 after Stereo Calibration 
camera_Matrixleft = np.matrix(([fc_left[0, 0], 0, cc_left[0, 0]], [0, fc_left[0, 1], cc_left[0, 1]], [0, 0, 1]), dtype = 'float64')
print camera_Matrixleft
# 3X3 Camera Matrix 2 after Stereo Calibration
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

#Rectify the images
cv2.stereoRectify(camera_Matrixleft, kc_left, camera_Matrixright, kc_right, (width, height), rot_vec, trans_vec, R1, R2, P1, P2, Q = None, flags = 0, alpha = -1, newImageSize = (0, 0))
#undistort the images
map1x , map1y = cv2.initUndistortRectifyMap(camera_Matrixleft, kc_left, R1, P1, (width, height))
map2x , map2y = cv2.initUndistortRectifyMap(camera_Matrixright, kc_right, R2, P2, (width, height))

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
	image_U_left = cv2.remap(frame_l, map1x, map1y, cv2.INTER_LINEAR, image_U_left, cv2.BORDER_CONSTANT, 0)
	image_U_right = cv2.remap(frame_r, map2x, map2y, cv2.INTER_LINEAR)

	stereo = cv2.StereoBM_create(numDisparities = 16, blockSize = 15)
	#calculates the stereo pair of the images 
	#finds the disparity map of the images
	disparity = stereo.compute(image_U_left, image_U_right)

	print disparity

	#perform object detection and identification
	fgmask_l = fgbg.apply(frame_l)
	fgmask_r = fgbg.apply(frame_r)

	im_l, contours_l, hierarchy_l = cv2.findContours(frame_l, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
	im_r, contours_r, hierarchy_r = cv2.findContours(frame_r, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
	
	for c in contours_l:
		M_l = cv2.moments(c)
		cX_l = M_l["m10"] / M_l["m00"]
		cY_l = M_l["m01"] / M_l["m00"]
	for c in contours_r:
		M_l = cv2.moments(c)
		cX_r = M_l["m10"] / M_l["m00"]
		cY_r = M_l["m01"] / M_l["m00"]
	#now find the co-ordinates of the point in 3D space
	pts_l = np.asmatrix([cX_l], [cY_l])
	pts_r = np.asmatrix([cX_r], [cY_r])
	pts_final = np.zeros(shape = (4, 1))


	cv2.triangulatePoints(P1, P2, pts_l, pts_r, pts_final)
	#find the norm of the vector to find the distance of the detected object.
	distance = LA.norm(pts_final)
	print distance






    # fgmask_r = fgbg.apply(frame_r)
	# im_r, contours_r, hierarchy_r = cv2.findContours(frame_r, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)


	
	#it shows the disparity map of the images
	plt.imshow(disparity, 'gray')
	#prints the output
	plt.show()

cap.release()
cv2.destroyAllWindows()
