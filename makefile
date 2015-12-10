IDIR =

VERFLAGS = -gxx-name=g++-4.8 -std=c++11

CPPFLAGS = -O3 -ip -parallel -funroll-loops -fno-alias -fno-fnalias -fargument-noalias -fstrict-aliasing -ansi-alias -fno-stack-protector-all -Wall
#-g
#-opt-streaming-stores always

#MKL Flags.
#MKLFLAGS = -DMKL_ILP64 -qopenmp -I$(MKLROOT)/include
MKLFLAGS = -qopenmp -I$(MKLROOT)/include

#MKL link line.
#MKL_LIBS = -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_intel_ilp64.a $(MKLROOT)/lib/intel64/libmkl_core.a $(MKLROOT)/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm
MKL_LIBS = -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a $(MKLROOT)/lib/intel64/libmkl_core.a $(MKLROOT)/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm

NLOPTLIBS = -lnlopt
OMPFLAGS = -openmp -openmp-simd

REPORTFLAG = -qopt-report-phase=vec -qopt-report-file=stdout -openmp-report=0
#-guide
# -opt-report-phase=offload

#FPFLAGS = -fp-model strict -fp-model extended -fimf-arch-consistency=true -fimf-precision=high -no-fma 
# enable <name> floating point model variation
#     except[-]  - enable/disable floating point semantics
#     extended   - enables intermediates in 80-bit precision
#     fast       - allows value-unsafe optimizations
#     precise    - allows value-safe optimizations
#     source     - enables intermediates in source precision
#     strict     - enables -fp-model precise -fp-model except and disables floating point multiply add

_OBJECTS = testCFFI.o
#PRH.o
OBJECTS = $(patsubst %,$(ODIR)/%,$(_OBJECTS))

LIBS = libtestCFFI.so

all: $(LIBS)

$(LIBS): testCFFI.o
	$(CXX) -shared -o libtestCFFI.so testCFFI.o

testCFFI.o: ./testCFFI.cpp
	$(CXX) $(VERFLAGS) -xHost $(CPPFLAGS) $(FPFLAG) $(MKLFLAGS) $(OMPFLAGS) -I $(IDIR)  $(REPORTFLAG) -c -Wall -Werror -fpic testCFFI.cpp $(OMPFLAGS) $(MKL_LIBS) -o testCFFI.o