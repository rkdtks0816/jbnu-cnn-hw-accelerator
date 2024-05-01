from time import sleep
import picamera
import RPi.GPIO as gpio
import cv2
from tensorflow.keras import models
import numpy as np
import matplotlib.pyplot as plt

def delayMicrosec(n):
    sleep(n/1000000)
def delayMillisec(n):
    sleep(n/1000)


push = 11           #gpio 00
iready = 13         #gpio 02
rpi_din = [29, 31, 33, 35, 37, 36]

gpio.setmode(gpio.BOARD)
gpio.setwarnings (False)
gpio.setup(push, gpio.IN)
gpio.setup(iready, gpio.OUT)
gpio.setup(rpi_din, gpio.OUT)

with picamera.PiCamera() as camera:
    camera.start_preview()
    sleep(3)
    camera.capture('/home/pi/cnn/photo.jpg')
    camera.stop_preview()


test_img = cv2.imread("/home/pi/cnn/photo.jpg",cv2.IMREAD_GRAYSCALE)
#img = img[0:480, 240:560]
#img = cv2.flip(img, 1)

test_img = cv2.resize(test_img, (28,28))

#plt.figure(figsize=(4,4))
#plt.imshow(test_img)
#plt.show()
#normalizing the dataset
test_img=test_img.astype('float32')/255
test_img=test_img.reshape(1,28,28,1)

sign_mnist = models.load_model("/home/pi/cnn/sign_mnist.h5")

predicted_result_1 = sign_mnist.predict(test_img)
predicted_labels_1 = np.argmax(predicted_result_1, axis=1)
print(predicted_labels_1)

m = 0
fpga_in = [0, 0, 0, 0, 0, 0]
for m in range(6):
    fpga_in[m] = int(predicted_labels_1>>m & 0b1)
print(fpga_in)
gpio.output(rpi_din, fpga_in)

gpio.output(iready, 0)
#delayMicrosec(0.5)      
delayMillisec(0.5)        
gpio.output(iready, 1)
#delayMicrosec(0.5)
delayMillisec(0.5)

sleep(1)

gpio.cleanup()