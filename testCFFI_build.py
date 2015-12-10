# file "testCFFI_build.py"

# Note: this particular example fails before version 1.0.2
# because it combines variadic function and ABI level.

from cffi import FFI

ffi = FFI()
ffi.set_source("_testCFFI", None)
ffi.cdef("""
    void printHello();
    void printMessage(char *myMessage);
    double sumVector(int size, double* vec);
         """)

if __name__ == "__main__":
    ffi.compile()
