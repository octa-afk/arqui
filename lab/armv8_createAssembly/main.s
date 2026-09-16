	.text
	.org 0x0000

ADD X2, XZR, XZR
loopA:
	STUR X2, [X0, #0]
	ADD X0, X0, X8
	ADD X2, X2, X1
	SUB X5, X5, X1
	CBZ X5, endA
	CBZ XZR, loopA
endA:

ADD X6, XZR, XZR
loopB:
	LDUR X7, [X6, #0]
	ADD X6, X6, X8
	ADD X5, X5, X7
	SUB X2, X2, X1
	CBZ X2, saveB
	CBZ XZR, loopB
saveB:
	STUR X5, [X0, #0]

ADD X8, XZR, XZR
loopC:
	ADD X8, X8, X17
	SUB X16, X16, X1
	CBZ X16, saveC
	CBZ XZR, loopC
saveC:
	STUR X8, [SP, #0]
endC:
	CBZ XZR, endC
