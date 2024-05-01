from time import sleep
import picamera
import RPi.GPIO as GPIO
import cv2
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings (False)

GPIO.setup(18, GPIO.OUT) #GPIO 4 cenb

GPIO.setup(23, GPIO.IN) #GPIO 6 push

GPIO.setup(24, GPIO.OUT) #GPIO 8 clk

GPIO.setup(5, GPIO.OUT) #GPIO 10 db 0
GPIO.setup(6, GPIO.OUT) #GPIO 12 db 1
GPIO.setup(13, GPIO.OUT) #GPIO 14 db 2
GPIO.setup(19, GPIO.OUT) #GPIO 16 db 3
GPIO.setup(26, GPIO.OUT) #GPIO 18 db 4
GPIO.setup(16, GPIO.OUT) #GPIO 20 db 5
GPIO.setup(20, GPIO.OUT) #GPIO 22 db 6
GPIO.setup(21, GPIO.OUT) #GPIO 24 db 7

GPIO.output(18, 0)
GPIO.output(24, 0)
GPIO.output(5, 0)
GPIO.output(6, 0)
GPIO.output(13, 0)
GPIO.output(19, 0)
GPIO.output(26, 0)
GPIO.output(16, 0)
GPIO.output(20, 0)
GPIO.output(21, 0)


# with picamera.PiCamera() as camera:
#     camera.start_preview()
#     GPIO.wait_for_edge(23, GPIO.RISING)
#     camera.capture('/home/pi/cnn/photo.jpg')
#     camera.stop_preview()

GPIO.wait_for_edge(23, GPIO.RISING)

# img = cv2.imread("/home/pi/cnn/photo.jpg",cv2.IMREAD_GRAYSCALE)
# img = cv2.flip(img, 1)

# test_img = cv2.resize(img, (28,28))

test_df = pd.read_csv('/home/pi/cnn/sign_mnist_test.csv')

test_img=test_df.values[0:,1:]

test_img=test_img/255
test_img=test_img.reshape((7172,28,28,1))

#normalizing the dataset
# test_img=test_img.astype('float32')/255
# test_img=test_img.reshape(1,28,28,1)

data = []
for i in range(28):
    for j in range(28):
        data_2 = []
        data_10 = (test_img[0][i][j][0]*255).astype(int)
        for k in range(0, 8):
            data_2.append(data_10%2)
            data_10 = data_10//2  
        data.append(data_2)

GPIO.output(18, 1)

print(data[0])

if(data[0][0] == 0):
    GPIO.output(5, 0)
else:
    GPIO.output(5, 1)
if(data[0][1] == 0):
    GPIO.output(6, 0)
else:
    GPIO.output(6, 1)
if(data[0][2] == 0):
    GPIO.output(13, 0)
else:
    GPIO.output(13, 1)
if(data[0][3] == 0):
    GPIO.output(19, 0)
else:
    GPIO.output(19, 1)
if(data[0][4] == 0):
    GPIO.output(26, 0)
else:
    GPIO.output(26, 1)
if(data[0][5] == 0):
    GPIO.output(16, 0)
else:
    GPIO.output(16, 1)
if(data[0][6] == 0):
    GPIO.output(20, 0)
else:
    GPIO.output(20, 1)
if(data[0][7] == 0):
    GPIO.output(21, 0)
else:
    GPIO.output(21, 1)

GPIO.output(24, 1)
sleep(0.01)
GPIO.output(24, 0)
sleep(0.01)

for i in range(783):

    print(data[i+1])

    if(data[i+1][0] == 0):
        GPIO.output(5, 0)
    else:
        GPIO.output(5, 1)
    if(data[i+1][1] == 0):
        GPIO.output(6, 0)
    else:
        GPIO.output(6, 1)
    if(data[i+1][2] == 0):
        GPIO.output(13, 0)
    else:
        GPIO.output(13, 1)
    if(data[i+1][3] == 0):
        GPIO.output(19, 0)
    else:
        GPIO.output(19, 1)
    if(data[i+1][4] == 0):
        GPIO.output(26, 0)
    else:
        GPIO.output(26, 1)
    if(data[i+1][5] == 0):
        GPIO.output(16, 0)
    else:
        GPIO.output(16, 1)
    if(data[i+1][6] == 0):
        GPIO.output(20, 0)
    else:
        GPIO.output(20, 1)
    if(data[i+1][7] == 0):
        GPIO.output(21, 0)
    else:
        GPIO.output(21, 1)
    
    GPIO.output(24, 1)
    sleep(0.01)
    GPIO.output(24, 0)
    sleep(0.01)

GPIO.output(18, 0)
GPIO.output(24, 1)
sleep(0.01)
GPIO.output(24, 0)
sleep(0.01)

GPIO.cleanup()
