import numpy as np
import random as random
import cffi as cffi

from _testCFFI import ffi

ffiObj = cffi.FFI()
C = ffi.dlopen("./libtestCFFI.so")

C.printHello()

C.printMessage("Works!")

numNums = 1000

a_cffi = ffiObj.new("double[%d]"%(numNums))
a_np = np.zeros(numNums)
for i in xrange(numNums):
	a_np[i] = random.gauss(0.0,1.0)
	a_cffi[i] = a_np[i]

mean_np = np.sum(a_np)/numNums
mean_cffi = C.sumVector(numNums, a_cffi)/numNums

print "Mean (np): %+17.16e"%(mean_np)
print "Mean (cffi): %+17.16e"%(mean_cffi)
print "Diff: %+17.16e"%(mean_np - mean_cffi)