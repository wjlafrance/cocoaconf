func main() {
	let strct = MyStructFromC(littleNumber: 3, bigNumber: 5)
	print("hey there, it's swift!")
	print("struct from c: \(strct)")
	print("number from c: \(getNumber())")
}

main()

printMemoryTest()

var data: [UInt8] = [1,2,3,4,5,6,7]
printMemory(&data, 6)
