
all: clean c swift link

c:
	clang \
		-c \
		-o util.o \
		*.c

swift:
	swiftc \
		-c \
		-import-objc-header util.h \
		-module-name BytingDownOnYourData \
		*.swift

link:
	swiftc \
		-o app \
		*.o

clean:
	rm -f app
	rm -f *.o
