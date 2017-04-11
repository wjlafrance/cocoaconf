#include <stdint.h>
#include <stdio.h>

typedef struct {
	uint32_t littleNumber;
	uint64_t bigNumber;
} MyStructFromC;

uint32_t getNumber();

void printMemoryTest();
void printMemory(uint8_t *address, unsigned int length);
