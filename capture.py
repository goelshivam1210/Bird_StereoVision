# throw_frames = 5
# while True:
# 	camera_l = cv2.VideoCapture(1)
# 	camera_r = cv2.VideoCapture(2)

# 	def get_Image():
# 	ret_l, im_l = camera_l.read()
# 	ret_r, im_r = camera_r.read()
# 	#print im_r, im_l
# 	return im_l, im_r

# for i in xrange(throw_frames):
# 	temp_l, temp_r = get_Image()
# 	print "Capturing"
# 	#print i
#     #print("Capturing...")

# while True:
# 	camera_l, camera_r = get_Image()
# 	# print camera_r, camera_l
# 	# print i
# 	file_l = "/home/images/image_left/image1.png"
# 	file_r = "/home/image/image_right/image1.png"
# 	cv2.imwrite(file_r, camera_r)
# 	cv2.imwrite(file_l, camera_l)
# 	#cv2.imwrite("new.png", camera_l)
# 	camera_l = None
# 	camera_r = None 
#

import cv2
import numpy as np
import time

camera_l = cv2.VideoCapture(0)
camera_r = cv2.VideoCapture(1)

i = 1
while True:
	ret_r, im_r = camera_r.read()
	ret_l, im_l = camera_l.read()

	#cv2.imshow('image_Right',im_l)

	
	time.sleep(2)
	# cv2.imshow('imageLeft', im_l)
	# cv2.imshow('imageRight', im_r)
	#print im_r


	print "Starting Capturing..."
	

	time.sleep(2)

	file_l = "/home/goelshivam12/images/image_left/left" + str(i) + ".jpg"
	file_r = "/home/goelshivam12/images/image_right/right" + str(i) + ".jpg"

	i = i + 1


	cv2.imwrite(file_l, im_l)
	cv2.imwrite(file_r, im_r)
	print "image" + str(i-1) + "saved!" 
	k = cv2.waitKey(30) & (0xFF == ord('q'))
	if k == 27 :
		break
capture.release()
cv2.destroyAllWindows



