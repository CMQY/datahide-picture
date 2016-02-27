import os
import Image
import struct
import sys

im=Image.open(sys.argv[1])
fp=open(sys.argv[2],'wb+')

x=im.size[0]
y=im.size[1]

fp.write(struct.pack('I',x))
fp.write(struct.pack('I',y))

pix=im.load()

for i in range(y):
 for j in range(x):
  fp.write(struct.pack('B',pix[j,i][0]))
  fp.write(struct.pack('B',pix[j,i][1]))
  fp.write(struct.pack('B',pix[j,i][2]))

fp.flush()
fp.close() 
