	; Martínez Márquez, Teodoro
	; Romero Fernández, Borja
	; Ruiz de Celis, Carmen del Mar

	AREA	miPrograma,CODE,READWRITE

SWI_Salir	EQU	&11
SWI_write0	EQU	&2
SWI_ReadC	EQU	&4


MiCadena = "                         "

	ALIGN

	ENTRY

	MOV r11, #2
	ADR r12, MiCadena
	BL ReadData
	SWI SWI_Salir


ReadData

	mov 	r8, r14
	CMP	r11, #1					; Comprueba si r11 = 1
	BLEQ	CADENA					; Si es asi, salta a la etiqueta
	CMP	r11, #2					; Comprueba si r11 = 2
	BLEQ	NUMERO					; Salta a la subrutina NUMERO					

CADENA	MOV	r13, #0					; Inicializa r13 a 0 (contador)
	ADR	r0, cad1					; Obtenemos la direccion de la cadena1
	SWI	SWI_write0				; Interrupcion para mostrar la cadena1

docadena
	SWI	SWI_ReadC				; Lee un caracter
	CMP	r0, #10					; Comprueba si el caracter introducido es 'Enter'
	BLEQ	fincadena				; Si es asi, acaba el bucle
	ADD	r13, r13, #1				; Aumenta el contador
	STR	r0, [r12]				; Guarda en la dirección de memoria que se encuentra en r12, el dato introducido por teclado, incrementando en 2 bytes post-indexados cada vez que se realice el bucle
	ADD	r12, r12, #4				; Añade a la dirección que se encuentra en r12 4, llegando asi a la siguiente dirección en memoria
	CMP	r13, #20					; Compara si el contador r13 es igual a 20 (numero de caracteres máximo)
	BLEQ	fincadena				; Si el contador es 20 salta a fincadena
	BL	docadena					; Salta a docadena
fincadena
	MOV	r4, #0					; Inicializamos el registro r4 a 0
	STR	r4, [r12]				; Añadimos un 0 al final de la cadena introducida
	BL	SALIDA					; Salta al final del programa

NUMERO	MOV	r4, #10					; Inicializamos el registro r4 a 10
	MOV	r13, #0					; Iniciamos el registro r13 (resultado) a 0
	ADR	r0, cad2					; Obtiene la direccion de la cadena2
	SWI	SWI_write0				; Interrupcion para mostrar la cadena2	
	
donumero
	SWI	SWI_ReadC				; Lee un caracter
	CMP	r0, #10					; Comprueba si el caracter introducido es 'Enter'
	BLEQ	finnumero				; Si es asi, acaba el bucle
	SUB	r0, r0, #48				; Calcula el valor numérico del caracter introducido
	MUL	r13, r4, r13				; Multiplica el resutado por 10
	ADD	r13, r13, r0				; Suma el digito introducido por teclado y el resultado que tenemos hasta ahora
	BL	donumero					; Salta a donumero 
finnumero
	STR	r13, [r12]				; Guardamos el resultado, situado en r13, en la dirección de memoria que se encuentra en r12
	BL	SALIDA					; Salta a SALIDA
	

SALIDA	
	MOV 	pc, r8
	SWI	SWI_Salir				; Termina el programa
	


cad1	=	"Introduzca una cadena por teclado y pulse 'Enter' cuando termine", &0a, &0d, 0
cad2	=	"Introduzca un numero por teclado y pulse 'Enter' cuando termine", &0a, &0d, 0

	END
