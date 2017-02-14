import cv2
import sys

tracker = cv2.Tracker_create("MIL")

video = cv2.VideoCapture("left.avi")

ret, frame = video.read()
if not ret:
	print "Cannot open file"
	sys.exit()
bbox = (287, 23, 86, 320)
#bbox = cv2.selectROI(frame, False)

ret = tracker.init(frame, bbox)

while True:
	ret, frame = video.read()
	# if not ret:
	# 	break
	ret, bbox = tracker.update(frame)

	if ret is True:
		p1 = (int(bbox[0]), int (bbox[1]))
		p2 = (int(bbox[0] + bbox[2]), int (bbox[1] + bbox[3]))
		cv2.rectangle(frame, p1, p2, (255, 0, 0))

	cv2.imshow("Tracking", frame)
	cv2.waitKey(0)

	k = cv2.waitKey(0) & 0xff
	if k == 27 or ord('q'):
		break


