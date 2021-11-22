	AREA	Calc,CODE,READWRITE
	
SWI_EscrCar	EQU	&0		; codigo de impresion de caracter (0) asignado a SWI_EscrCar
SWI_Salir	EQU	&11		; codigo de impresion de salida del programa(11)
SWI_write0	EQU 	&2
SWI_ReadC	EQU 	&4
DATO		DCD	0

	ENTRY					; Punto de entrada del código
	
ENTRADA  ADR 	r0, cad1				; Obtenemos la direccion de la cadena1
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena
		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y INTRODUCIR EL DATO EN R0
	MOV	r1, r0				; Movemos el valor introducido en r0 a r1



	ADR 	r0, cad2				; Obtenemos la direccion de la cadena2
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena
		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y INTRODUCIR EL DATO EN R0
	MOV	r2, r0				; Movemos el valor introducido en r0 a r1



	ADR 	r0, cad3				; Obtenemos la direccion de la cadena3
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena


	
	SWI 	SWI_ReadC			; Interrupcion de Soft. para leer un caracter de teclado
         CMP 	r0, #49				; Se ha pulsado la tecla 1 ??
	BLEQ 	SUMA				; 	ejecuta la rutina SUMA
	CMP	r0, #50
	BLEQ	REST
	CMP 	r0, #51				; Se ha pulsado la tecla 2 ??
	BLEQ 	PROD				; 	ejecuta la rutina PROD
	CMP	r0, #52
	BLEQ	DIVI
	
	ADR	r1, DATO
	STR	r3, [r1]

	ADR 	r0, cad4				; Obtenemos la direccion de la cadena3
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena

	ADRL	r0, cad5
	SWI	SWI_write0

	SWI	SWI_ReadC
	CMP	r0, #49
	BLEQ 	ENTRADA
	
	ADRL	r0, cad6
	SWI	SWI_write0

		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y CONSULTAR EL RESULTADO EN R3
	SWI SWI_Salir ; Sale del programa


SUMA	ADD	r3, r1, r2
	MOV 	pc, r14

REST	SUB	r3, r1, r2
	MOV	pc, r14

PROD	MUL	r3, r1, r2
	MOV	pc, r14

DIVI	
	MOV	r3, #0
inicio
	CMP	r1, r2
	BLT	fin
	SUB	r1, r1, r2
	ADD	r3, r3, #1
	BAL	inicio
fin
	MOV	pc, r14
	
cad1	=	"Introduce operando 1 en registro r0 y pulsa F5", &0a, &0d, 0
cad2	=	"Introduce operando 2 en registro r0 y pulsa F5", &0a, &0d, 0
cad3	=	"Elige operacion PULSANDO EN TECLADO el numero correspondiente:", &0a, &0d, "1. Sumar", &0a, &0d, "2. Restar", &0a, &0d, "3. Multiplicar", &0a, &0d, "4. Dividir", &0a, &0d, 0
cad4	=	&0a, &0d, "Resultado en r3", &0a, &0d, 0
cad5	=	"¿Desea continuar? Pulse 0 si desea salir o pulse 1 si desea continuar", &0a, &0d, 0
cad6	=	"Programa terminado.", &0a, &0d, 0

	END

        