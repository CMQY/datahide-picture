import os
import Image
import struct
import sys

if len(sys.argv)<4 :
 print "errror!"

im=Image.open(sys.argv[1])
fa=open(sys.argv[2],'wb')
fb=open(sys.argv[3],'wb')

pix=im.load()
x=im.size[0]
y=im.size[1]

fa.write(struct.pack('I',x))
fa.write(struct.pack('I',y/2))

fb.write(struct.pack('I',x))
fb.write(struct.pack('I',y/2))

for i in range(0,y,2):
 for j in range(x):
  fa.write(struct.pack('B',pix[j,i][0]))
  fa.write(struct.pack('B',pix[j,i][1]))
  fa.write(struct.pack('B',pix[j,i][2]))

for i in range(1,y,2):
 for j in range(x):
  fb.write(struct.pack('B',pix[j,i][0]))
  fb.write(struct.pack('B',pix[j,i][1]))
  fb.write(struct.pack('B',pix[j,i][2]))

fa.flush()
fb.flush()
fa.close()
fb.close()
