clang -c -o util.o util.c

swiftc -c -import-objc-header util.h main.swift

swiftc -o app main.o util.o
