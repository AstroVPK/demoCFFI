#include <cstdio>
//#include "testCFFI.hpp"



extern "C" {

	extern void printHello() {
		printf("Hello!\n");
		}

	extern void printMessage(char *myMessage) {
		printf("%s\n",myMessage);
		}

	extern double sumVector(int size, double* vec) {
		double sum = 0.0;
		for (int i  = 0; i < size; ++i) {
			sum += vec[i];
			}
		return sum;
		}

	}