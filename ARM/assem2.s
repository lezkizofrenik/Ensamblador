	AREA	ReadData,CODE,READWRITE

SWI_Salir	EQU	&11
SWI_write0	EQU	&2
SWI_ReadC	EQU	&4

	ENTRY

ENTRADA	CMP	r11, #49					; Comprueba si r11 = 1
	BLEQ	CADENA					; Si es asi, salta a la etiqueta
	CMP	r11, #50					; Comprueba si r11 = 2
	BLEQ	NUMERO					

CADENA	MOV	r13, 0					; Inicializa r13 a 0 (contador)
	ADR	r0, cad1					; Obtenemos la direccion de la cadena1
	SWI	SWI_write0				; Interrupcion para mostrar la cadena1

do
	SWI	SWI_ReadC				; Lee un caracter
	CMP	r0, #10					; Comprueba si el caracter introducido es 'Enter'
	BLEQ	fin					; Si es asi, acaba el bucle
	ADD	r13, r13, 1				; Aumenta el contador
	STR	r0, [r12], #2				; Guarda en la dirección de memoria que se encuentra en r12, el dato introducido por teclado, incrementando en 2 bytes post-indexados cada vez que se realice el bucle
	BL	do					; Si no, salta a do 
fin
	STR	0, [r12]


NUMERO	ADR	r0, cad2					; Obtiene la direccion de la cadena2
	SWI	SWI_write0				; Interrupcion para mostrar la cadena2	
	
do
	SWI	SWI_ReadC				; Lee un caracter
	CMP	r0, #10					; Comprueba si el caracter introducido es 'Enter'
	BLEQ	fin					; Si es asi, acaba el bucle
	SUB	r0, 
	ADD	r13, r13, 1				; Aumenta el contador
	STR	r0, [r12], #2				; Guarda en la dirección de memoria que se encuentra en r12, el dato introducido por teclado, incrementando en 2 bytes post-indexados cada vez que se realice el bucle
	BL	do					; Si no, salta a do 
fin

	





cad1	=	"Introduzca una cadena por teclado y pulse 'Enter' cuando termine", &0a, &0d, 0
cad2	=	"Introduzca un número por teclado y pulse 'Enter' cuando termine", &0a, &0d, 0
