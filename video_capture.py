import cv2
import numpy as np
import time

camera_l = cv2.VideoCapture(1)
camera_r = cv2.VideoCapture(2)

fourcc = cv2.VideoWriter_fourcc(*'XVID')
out_l = cv2.VideoWriter('left.avi', fourcc, 30.0, (640, 480))
out_r = cv2.VideoWriter('right.avi', fourcc, 30.0, (640, 480))

time.sleep(3)

#i = 1
while True:
	ret_r, im_r = camera_r.read()
	ret_l, im_l = camera_l.read()

	#time.sleep(5)

	print ret_r, ret_l

	#print "Starting Capture..."

	if ret_l and ret_r == True:
		#frame_l = cv2.flip(im_l, 0)
		#frame_r = cv2.flip(im_r, 0)

		#time.sleep(1)

		out_l.write(im_l)
		out_r.write(im_r)


		if cv2.waitKey(1) & 0xFF == ord('q'):
			break
	else:
		break
camera_l.release()
camera_r.release()
out_l.release()
out_r.release()
cv2.destroyAllWindows
