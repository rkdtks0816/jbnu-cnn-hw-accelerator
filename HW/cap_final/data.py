import cv2
import numpy as np
#%matplotlib inline

label = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y']
data_t1 = []
for o in range(9):
  data1 = []
  for k in range(50):
      num = k+1
      file_name = 'C:\fff\2\'+label[o]+'/'+label[o]+'%d.jpg' %num
      img = cv2.imread(file_name, cv2.IMREAD_GRAYSCALE)
      test_img = cv2.resize(img, (28,28))
      #normalizing the dataset
      test_img=test_img.astype('float32')/255
      test_img=test_img.reshape(28,28,1)
      data1.append(test_img)
  data_t1.append(data1)

flog = open("data_a_i.log", "w")
for h in range(9):
  for t in range(40):
      for i in range(28):
          for j in range(28):
              print("%d "%abs((data_t1[h][t][i][j][0]*255).astype(int)), file = flog, end=' ') 
      print("%d" %h, file = flog)
flog.close()

data_t2 = []
for o in range(15):
  data2 = []
  for k in range(50):
      num = k+1
      file_name = 'C:\fff\2\'+label[o+9]+'/'+label[o+9]+'%d.jpg' %num
      img = cv2.imread(file_name, cv2.IMREAD_GRAYSCALE)
      test_img = cv2.resize(img, (28,28))
      #normalizing the dataset
      test_img=test_img.astype('float32')/255
      test_img=test_img.reshape(28,28,1)
      data2.append(test_img)
  data_t2.append(data2)

flog = open("data_k_y.log", "w")
for h in range(15):
  for t in range(40):
      for i in range(28):
          for j in range(28):
              print("%d "%abs((data_t2[h][t][i][j][0]*255).astype(int)), file = flog, end=' ') 
      print("%d" %(h+10), file = flog)
flog.close()