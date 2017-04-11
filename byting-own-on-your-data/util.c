#include "util.h"

uint32_t getNumber() {
	return 42;
}

void printMemoryTest() {
	const char *myBuffer = "my buff\03er brings all the boys to the yard"
			"theyre like its better than yours";
	printMemory(myBuffer + 1, strlen(myBuffer) - 2);
}

void printMemory(uint8_t *address, unsigned int length) {
#define LINE_LENGTH 32
#define CHUNK_WIDTH 4

	for (int j = 0; j < length; j += LINE_LENGTH) {
		printf("%08X  ", (unsigned int) address);

		for (int k = 0; k < LINE_LENGTH; k++) {
			printf("%c", isprint(address[j + k]) ? address[j+k] : '.');
		}
		for (int k = 0; k < LINE_LENGTH; k++) {
			if (k % LINE_LENGTH == 0) { printf(" "); }
			printf("%02X ", address[j + k]);
		}
		printf("\n");
	}
}
