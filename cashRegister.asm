**********************************************
***                                          *
*** 68HC11 Assembly compiler                 *
*** Daedra.ml                                *
***                                          *
**********************************************

***********************
*** CAJA REGISTRADORA *
***********************

PACTL  EQU   $1026
PACNT  EQU   $1027
ADCTL  EQU   $1030
ADR1   EQU   $1031
ADR2   EQU   $1032
ADR3   EQU   $1033
ADR4   EQU   $1034
OPTION EQU   $1039

PORTA  EQU   $1000
PORTD  EQU   $1008
PORTE  EQU   $100A
PORTG  EQU   $1002

DDRA   EQU   $1001
DDRD   EQU   $1009
DDRG   EQU   $1003

TMSK2  EQU   $1024
TFLG2  EQU   $1025

SCDR   EQU   $102F
SCCR2  EQU   $102D
SCSR   EQU   $102E
SCCR1  EQU   $102C
BAUD   EQU   $102B
HPRIO  EQU   $103C
SPCR   EQU   $1028
CSCTL  EQU   $105D
OPT2   EQU   $1038

DIR_BASE EQU  $0022

******************************
*** DECLARACION DE VARIABLES *
******************************

ORDEN  EQU   $0000	* Almacena lo que recibe el puerto serial.
VAR    EQU   $0001

menosA EQU   $0004	* Descuento unitario en A
A      EQU   $0007	* Cantidad de articulos acumulados de A
A1     EQU   $000B   * De A1 a A5 son para representar el subtotal en BCD (decenas, centenas, etc)
A2     EQU   $000C
A3     EQU   $000D
A4     EQU   $000E
A5     EQU   $000F

menosB EQU   $0014
B      EQU   $0017
B1     EQU   $001B
B2     EQU   $001C
B3     EQU   $001D
B4     EQU   $001E
B5     EQU   $001F

menosC EQU   $0024
C      EQU   $0027
C1     EQU   $002B
C2     EQU   $002C
C3     EQU   $002D
C4     EQU   $002E
C5     EQU   $002F

menosD EQU   $0034
D      EQU   $0037
D1     EQU   $003B
D2     EQU   $003C
D3     EQU   $003D
D4     EQU   $003E
D5     EQU   $003F

menosE EQU   $0044
E      EQU   $0047
E1     EQU   $004B
E2     EQU   $004C
E3     EQU   $004D
E4     EQU   $004E
E5     EQU   $004F

sA     EQU   $0009	* Subtotales de cada articulo
sB     EQU   $0019
sC     EQU   $0029
sD     EQU   $0039
sE     EQU   $0049

totAr  EQU   $0068	* TotAr es el total de articulos

res1   EQU   $006B	* Son usadas para representar el total en BCD (decenas, centenas, etc)
res2   EQU   $006C
res3   EQU   $006D
res4   EQU   $006E
res5   EQU   $006F

BORRA  EQU   $0010	* "Booleano" para detectar si se borrara algo
TEMP   EQU   $0020	* almacena lo que se va a aumentar
TOTAL  EQU   $0050

DIR_IMP EQU  $007B

************************
*** VARIABLES DE ERROR *
************************

ERR1   EQU   $0070
ERR2   EQU   $0071
ERR3   EQU   $0072
ERR4   EQU   $0073
ERR5   EQU   $0074
BCD1   EQU   $0060
BCD2   EQU   $0061
BCD3   EQU   $0062

***************************
***  CUERPO  DEL PROGRAMA *
***************************

       ORG   $4000

***********************+***
*** COMIENZO FCC MILLARES *
***************************

mil10 	FCC   "DIEZ MIL."
mil09 	FCC   "NUEVE MIL."
mil08 	FCC   "OCHO MIL."
mil07 	FCC   "SIETE MIL."
mil06 	FCC   "SEIS MIL."
mil05 	FCC   "CINCO MIL."
mil04 	FCC   "CUATRO MIL."
mil03 	FCC   "TRES MIL."
mil02 	FCC   "DOS MIL."
mil01	 	FCC   "MIL."

***********************+***
*** COMIENZO FCC CENTENAS *
***************************

cien09 	FCC   "NOVECIENTOS."
cien08 	FCC   "OCHOCIENTOS."
cien07 	FCC   "SETECIENTOS."
cien06 	FCC   "SEISCIENTOS."
cien05 	FCC   "QUINIENTOS."
cien04 	FCC   "CUATROCIENTOS."
cien03 	FCC   "TRESCIENTOS."
cien02 	FCC   "Doscientos."
cient0	FCC   "CIENTO."
cien01	FCC   "CIEN."

***********************+**
*** COMIENZO FCC DECENAS *
**************************

diez09	FCC   "NOVENTA."
diez08	FCC   "Ochenta."
diez07	FCC   "SETENTA."
diez06	FCC   "SESENTA."
diez05 	FCC   "CINCUENTA."
diez04 	FCC   "CUARENTA."
diez03	FCC   "TREINTA."
diez02	FCC   "VEINTE."
diez25 	FCC   "VEINTICINCO."
diez01   FCC   "DIEZ."
diez15	FCC   "QUINCE."

***********************+***
*** COMIENZO FCC UNIDADES *
***************************

unoY5	 	FCC   "Y Cinco."
uno05	 	FCC   "CINCO."
coin	 	FCC   "PESOS MEXICANOS ."

INICIO
       LDS   #$00EE
       JSR   SERIAL

LIMPIA
	CLR  A
	CLR  A1
	CLR  A2
	CLR  A3
	CLR  A4
	CLR  A5
	CLR  B
	CLR  B1
	CLR  B2
	CLR  B3
	CLR  B4
	CLR  B5
	CLR  C
	CLR  C1
	CLR  C2
	CLR  C3
	CLR  C4
	CLR  C5
	CLR  D
	CLR  D1
	CLR  D2
	CLR  D3
	CLR  D4
	CLR  D5
	CLR  E
	CLR  E1
	CLR  E2
	CLR  E3
	CLR  E4
	CLR  E5
	CLR  res1
	CLR  res2
	CLR  res3
	CLR  res4
	CLR  res5
	CLR  menosA
	CLR  menosB
	CLR  menosC
	CLR  menosD
	CLR  menosE
	CLR  sA
	CLR  sB
	CLR  sC
	CLR  sD
	CLR  sE
	CLR  BORRA
	CLR  TOTAL
	CLR  $0003
	CLR  $0013
	CLR  $0023
	CLR  $0033
	CLR  $0043
	CLR  $0053
	CLR  $0005
	CLR  $0015
	CLR  $0025
	CLR  $0035
	CLR  $0045
	CLR  $0055
	CLR  $0006
	CLR  $0016
	CLR  $0026
	CLR  $0036
	CLR  $0046
	CLR  $0056
	CLR  $0008
	CLR  $0018
	CLR  $0028
	CLR  $0038
	CLR  $0048
	CLR  $0058
	CLR  $000A
	CLR  $001A
	CLR  $002A
	CLR  $003A
	CLR  $004A
	CLR  $005A
	CLR  $0067
	CLR  $3110
	CLR  $3111
	CLR  $3112
	CLR  $3113
	CLR  $3114
	CLR  $3115
	CLR  $3116
	CLR  $3117
	CLR  $3118
	CLR  $3119
	CLR  $311A
	CLR  $311B
	CLR  $311C
	CLR  $311D
	CLR  $311E
	CLR  $311F
	CLR  $3120
	CLR  $3121
	CLR  $3122
	CLR  $3123
	CLR  $3124
	CLR  $3125
	CLR  $3126
	CLR  $3127
	CLR  $3128
	CLR  $3129
	CLR  $312A
	CLR  $312B
	CLR  $312C
	CLR  $312D
	CLR  $312E
	CLR  $312F
	CLR  $3130
	CLR  $3131
	CLR  $3132
	CLR  $3133
	CLR  $3134
	CLR  $3135
	CLR  $3136
	CLR  $3137
	CLR  $3138
	CLR  $3139
	CLR  $313A
	CLR  $313B
	CLR  $313C
	CLR  $313D
	CLR  $313E
	CLR  $313F

*******************************************
*** CICLO SE INTERRUMPE POR PUERTO SERIAL *
*******************************************

********************************************
*** Hace la suma de subtotales y convierte *
*** a BCD                                  *
********************************************

ENCICLATE
	LDD  #0
	ADDD sA
	ADDD sB
	ADDD sC
	ADDD sD
	ADDD sE
	STD  TOTAL
	JSR  BINBCD_TOTAL
	LDAA  #'?
	STAA  ORDEN

CICLO
	LDAA  ORDEN
	CMPA  #'?
	BEQ   CICLO

****************************************
*** Verifica si se va a borrar un dato *
*** (BORRA == 1)                       *
****************************************

	LDAA  BORRA
	CMPA  #1
	BEQ   QUITAR_ARTICULO
	LDAA  ORDEN
	CMPA  #'#
	BEQ   BORRA_1
	CMPA  #'+
	BEQ   AGREGAR_ARTICULO
	STAA  TEMP
	CMPA  #'=
	BEQ   PUENTE_TICKET
	JMP   ENCICLATE

BORRA_1
	INC  BORRA
	JMP  ENCICLATE

***************************************
*** TODOS LOS PUENTES SON USADOS PARA *
*** LLEGAR A LOCALIDADES A LAS QUE NO *
*** LLEGA BEQ                         *
***************************************

PUENTE_TICKET
	JMP   TICKET

***********************************************
*** Compara con las 10 vocales (mayusculas    *
*** y minusculas) para agregar el respectivo  *
*** articulo, si no es igual salta a la       *
*** subrutina que imprime el error            *
***********************************************

AGREGAR_ARTICULO
	LDD   TOTAL
	CPD   #$2710
	BHS   ENCICLATE
	LDAA  TEMP
	CMPA  #'A
	BEQ   PUENTE_AGREGAR_A
	CMPA  #'B
	BEQ   PUENTE_AGREGAR_B
	CMPA  #'C
	BEQ   PUENTE_AGREGAR_C
	CMPA  #'D
	BEQ   PUENTE_AGREGAR_D
	CMPA  #'E
	BEQ   PUENTE_AGREGAR_E
	CMPA  #'a
	BEQ   PUENTE_AGREGAR_A
	CMPA  #'b
	BEQ   PUENTE_AGREGAR_B
	CMPA  #'c
	BEQ   PUENTE_AGREGAR_C
	CMPA  #'d
	BEQ   PUENTE_AGREGAR_D
	CMPA  #'e
	BEQ   PUENTE_AGREGAR_E
	JSR   ERROR
	JMP   ENCICLATE

**********************************************
*** Vuelve el booleano FALSO y revisa que    *
*** articulo se debe reducir, si no existe   *
*** ese articulo imprime el mensaje de ERROR *
**********************************************

QUITAR_ARTICULO
	DEC   BORRA
	LDAA  ORDEN
	CMPA  #'A
	BEQ   PUENTE_QUITAR_A
	CMPA  #'B
	BEQ   PUENTE_QUITAR_B
	CMPA  #'C
	BEQ   PUENTE_QUITAR_C
	CMPA  #'D
	BEQ   PUENTE_QUITAR_D
	CMPA  #'E
	BEQ   PUENTE_QUITAR_E
	CMPA  #'a
	BEQ   PUENTE_QUITAR_A
	CMPA  #'b
	BEQ   PUENTE_QUITAR_B
	CMPA  #'c
	BEQ   PUENTE_QUITAR_C
	CMPA  #'d
	BEQ   PUENTE_QUITAR_D
	CMPA  #'e
	BEQ   PUENTE_QUITAR_E
	JSR   ERROR
	JMP   ENCICLATE

***************************************************
*** Puentes necesarios para llegar a la operacion *
*** necesaria, quitan el mensaje de error ya que  *
*** si existe ese articulo                        *
***************************************************

PUENTE_AGREGAR_A
	JSR   LIMPIA_ERROR
	JMP   AGREGAR_A
PUENTE_AGREGAR_B
	JSR   LIMPIA_ERROR
	JMP   AGREGAR_B
PUENTE_AGREGAR_C
	JSR   LIMPIA_ERROR
	JMP   AGREGAR_C
PUENTE_AGREGAR_D
	JSR   LIMPIA_ERROR
	JMP   AGREGAR_D
PUENTE_AGREGAR_E
	JSR   LIMPIA_ERROR
	JMP   AGREGAR_E
PUENTE_QUITAR_A
	JSR   LIMPIA_ERROR
	JMP   QUITAR_A
PUENTE_QUITAR_B
	JSR   LIMPIA_ERROR
	JMP   QUITAR_B
PUENTE_QUITAR_C
	JSR   LIMPIA_ERROR
	JMP   QUITAR_C
PUENTE_QUITAR_D
	JSR   LIMPIA_ERROR
	JMP   QUITAR_D
PUENTE_QUITAR_E
	JSR   LIMPIA_ERROR
	JMP   QUITAR_E

**********************
*** OPERACIONES DE A *
**********************

*****************************************************
*** Para quitar A primero debe verificar que no es  *
*** vacia (compara con cero, si si es vacia regresa *
*** al ciclado mediante un puente)                  *
*****************************************************

QUITAR_A
	LDAA  A
	CMPA  #0
	BEQ   PUENTE_ENCICLATE

*******************************************************
*** Decrementa el contador A y salta al calculo de    *
*** subtotales dependiendo de la cantidad de articulo *
*******************************************************

	DEC   A
	JMP   CALC_A
AGREGAR_A
	INC   A
CALC_A
	LDAB  A
	CMPB  #1
	BEQ   PUENTE_SA_1
	CMPB  #2
	BEQ   PUENTE_SA_2
	CMPB  #3
	BEQ   PUENTE_SA_3
	CMPB  #4
	BEQ   PUENTE_SA_4
	JMP   SA_5

*********************************************************
*** Salta a la operacion que asigna el subtotal (SA_1 = *
*** subtotal cuando A es uno)                           *
*********************************************************

PUENTE_SA_1
	JMP   SA_1
PUENTE_SA_2
	JMP   SA_2
PUENTE_SA_3
	JMP   SA_3
PUENTE_SA_4
	JMP   SA_4

**********************
*** OPERACIONES DE B *
**********************

QUITAR_B
	LDAA  B
	CMPA  #0
	BEQ   PUENTE_ENCICLATE
	DEC   B
	JMP   CALC_B
AGREGAR_B
	INC   B
CALC_B
	LDAB  B
	CMPB  #1
	BEQ   PUENTE_SB_1
	CMPB  #2
	BEQ   PUENTE_SB_2
	CMPB  #3
	BEQ   PUENTE_SB_3
	CMPB  #4
	BEQ   PUENTE_SB_4
	JMP   SB_5
PUENTE_SB_1
	JMP   SB_1
PUENTE_SB_2
	JMP   SB_2
PUENTE_SB_3
	JMP   SB_3
PUENTE_SB_4
	JMP   SB_4
PUENTE_ENCICLATE
	JMP   ENCICLATE

**********************
*** OPERACIONES DE C *
**********************

QUITAR_C
	LDAA  C
	CMPA  #0
	BEQ   PUENTE_ENCICLATE
	DEC   C
	JMP   CALC_C
AGREGAR_C
	INC   C
CALC_C
	LDAB  C
	CMPB  #1
	BEQ   PUENTE_SC_1
	CMPB  #2
	BEQ   PUENTE_SC_2
	CMPB  #3
	BEQ   PUENTE_SC_3
	CMPB  #4
	BEQ   PUENTE_SC_4
	JMP   SC_5
PUENTE_SC_1
	JMP   SC_1
PUENTE_SC_2
	JMP   SC_2
PUENTE_SC_3
	JMP   SC_3
PUENTE_SC_4
	JMP   SC_4

**********************
*** OPERACIONES DE D *
**********************

QUITAR_D
	LDAA  D
	CMPA  #0
	BEQ   PUENTE_ENCICLATE
	DEC   D
	JMP   CALC_D
AGREGAR_D
	INC   D
CALC_D
	LDAB  D
	CMPB  #1
	BEQ   PUENTE_SD_1
	CMPB  #2
	BEQ   PUENTE_SD_2
	CMPB  #3
	BEQ   PUENTE_SD_3
	CMPB  #4
	BEQ   PUENTE_SD_4
	JMP   SD_5
PUENTE_SD_1
	JMP   SD_1
PUENTE_SD_2
	JMP   SD_2
PUENTE_SD_3
	JMP   SD_3
PUENTE_SD_4
	JMP   SD_4

**********************
*** OPERACIONES DE E *
**********************

QUITAR_E
	LDAA  E
	CMPA  #0
	BEQ   PUENTE_ENCICLATE
	DEC   E
	JMP   CALC_E
AGREGAR_E
	INC   E
CALC_E
	LDAB  E
	CMPB  #1
	BEQ   PUENTE_SE_1
	CMPB  #2
	BEQ   PUENTE_SE_2
	CMPB  #3
	BEQ   PUENTE_SE_3
	CMPB  #4
	BEQ   PUENTE_SE_4
	JMP   SE_5
PUENTE_SE_1
	JMP   SE_1
PUENTE_SE_2
	JMP   SE_2
PUENTE_SE_3
	JMP   SE_3
PUENTE_SE_4
	JMP   SE_4

***********************************
*** ASIGNACION DE PRECIOS         *
*** DEPENDIENDO DE LOS CONTADORES *
***********************************

***************************************************************
*	LA EXPLICACION ES VALIDA PARA TODOS LOS CASOS:             *
				*se asigna en la variable del decremento unitario *
				*  el que corresponde dependiendo del caso        *
				*(si son 50 pesos se pone en hexa para no hacerle *
				*  la operacion del BCD)                          *
				*Se asigna en hexadecimal el subtotal de ese      *
				*   articulo y se le aplica el BCD                *
				*se vuelve a ciclar                               *
***************************************************************

SA_1
	LDD   #$0
	STD   menosA
	LDD   #$32
	STD   sA
	JSR   BINBCD_A
	JMP   ENCICLATE
SA_2
	LDD   #$A
	STD   menosA
	LDD   #$50
	STD   sA
	JSR   BINBCD_A
	JMP   ENCICLATE
SA_3
	LDD   #$F
	STD   menosA
	LDD   #$69
	STD   sA
	JSR   BINBCD_A
	JMP   ENCICLATE
SA_4
	LDD   #$14
	STD   menosA
	LDD   #$78
	STD   sA
	JSR   BINBCD_A
	JMP   ENCICLATE
SA_5
	LDD   #$19
	STD   menosA
	LDAA  #$19
	LDAB  A
	MUL
	STD   sA
	JSR   BINBCD_A
	JMP   ENCICLATE

SB_1
	LDD   #$0
	STD   menosB
	LDD   #$64
	STD   sB
	JSR   BINBCD_B
	JMP   ENCICLATE
SB_2
	LDD   #$14
	STD   menosB
	LDD   #$A0
	STD   sB
	JSR   BINBCD_B
	JMP   ENCICLATE
SB_3
	LDD   #$1E
	STD   menosB
	LDD   #$D2
	STD   sB
	JSR   BINBCD_B
	JMP   ENCICLATE
SB_4
	LDD   #$28
	STD   menosB
	LDD   #$F0
	STD   sB
	JSR   BINBCD_B
	JMP   ENCICLATE
SB_5
	LDD   #$32
	STD   menosB
	LDAA  #$32
	LDAB  B
	MUL
	STD   sB
	JSR   BINBCD_B
	JMP   ENCICLATE

SC_1
	LDD   #$0
	STD   menosC
	LDD   #$C8
	STD   sC
	JSR   BINBCD_C
	JMP   ENCICLATE
SC_2
	LDD   #$28
	STD   menosC
	LDD   #$140
	STD   sC
	JSR   BINBCD_C
	JMP   ENCICLATE
SC_3
	LDD   #$3C
	STD   menosC
	LDD   #$1A4
	STD   sC
	JSR   BINBCD_C
	JMP   ENCICLATE
SC_4
	LDD   #$50
	STD   menosC
	LDD   #$1E0
	STD   sC
	JSR   BINBCD_C
	JMP   ENCICLATE
SC_5
	LDD   #$64
	STD   menosC
	LDAA  #$64
	LDAB  C
	MUL
	STD   sC
	JSR   BINBCD_C
	JMP   ENCICLATE


SD_1
	LDD   #$0
	STD   menosD
	LDD   #$12C
	STD   sD
	JSR   BINBCD_D
	JMP   ENCICLATE
SD_2
	LDD   #$3C
	STD   menosD
	LDD   #$1E0
	STD   sD
	JSR   BINBCD_D
	JMP   ENCICLATE
SD_3
	LDD   #$5A
	STD   menosD
	LDD   #$276
	STD   sD
	JSR   BINBCD_D
	JMP   ENCICLATE
SD_4
	LDD   #$78
	STD   menosD
	LDD   #$2D0
	STD   sD
	JSR   BINBCD_D
	JMP   ENCICLATE
SD_5
	LDD   #$96
	STD   menosD
	LDAA  #$96
	LDAB  D
	MUL
	STD   sD
	JSR   BINBCD_D
	JMP   ENCICLATE

SE_1
	LDD   #$0
	STD   menosE
	LDD   #$190
	STD   sE
	JSR   BINBCD_E
	JMP   ENCICLATE
SE_2
	LDD   #$50
	STD   menosE
	LDD   #$280
	STD   sE
	JSR   BINBCD_E
	JMP   ENCICLATE
SE_3
	LDD   #$78
	STD   menosE
	LDD   #$348
	STD   sE
	JSR   BINBCD_E
	JMP   ENCICLATE
SE_4
	LDD   #$A0
	STD   menosE
	LDD   #$3C0
	STD   sE
	JSR   BINBCD_E
	JMP   ENCICLATE
SE_5
	LDD   #$C8
	STD   menosE
	LDAA  #$C8
	LDAB  E
	MUL
	STD   sE
	JSR   BINBCD_E
	JMP   ENCICLATE


*******************************************
*** AQUI TERMINA EL CALCULO DE SUBTOTALES *
*******************************************

*************************************************
*** SUBRUTINAS QUE IMPRIMEN EL MENSAJE DE ERROR *
*************************************************

ERROR
	LDAA  #'E
	STAA  ERR1
	LDAA  #'R
	STAA  ERR2
	LDAA  #'R
	STAA  ERR3
	LDAA  #'O
	STAA  ERR4
	LDAA  #'R
	STAA  ERR5
	RTS

LIMPIA_ERROR
	LDAA  #0
	STAA  ERR1
	LDAA  #0
	STAA  ERR2
	LDAA  #0
	STAA  ERR3
	LDAA  #0
	STAA  ERR4
	LDAA  #0
	STAA  ERR5
	RTS





**************************************************
*cONVERTIR A BCD
**************************************************

****HAY UN CONVERSOR A BCD PARA CADA UNO DE LOS SUBTOTALES, PARA EL TOTAL DE ARTICULOS Y PARA EL TOTAL
BINBCD_A
	LDX   #$2710
	IDIV
	XGDX
	STAB  A1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  A2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  A3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  A4
	XGDX
	STAB  A5
	RTS

BINBCD_B
	LDX   #$2710
	IDIV
	XGDX
	STAB  B1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  B2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  B3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  B4
	XGDX
	STAB  B5
	RTS
BINBCD_C
	LDX   #$2710
	IDIV
	XGDX
	STAB  C1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  C2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  C3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  C4
	XGDX
	STAB  C5
	RTS
BINBCD_D
	LDX   #$2710
	IDIV
	XGDX
	STAB  D1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  D2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  D3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  D4
	XGDX
	STAB  D5
	RTS
BINBCD_E
	LDX   #$2710
	IDIV
	XGDX
	STAB  E1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  E2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  E3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  E4
	XGDX
	STAB  E5
	RTS

BINBCD_TOTAL
	LDX   #$2710
	IDIV
	XGDX
	STAB  res1
	XGDX
	LDX   #$3E8
	IDIV
	XGDX
	STAB  res2
	XGDX
	LDX   #$64
	IDIV
	XGDX
	STAB  res3
	XGDX
	LDX   #$A
	IDIV
	XGDX
	STAB  res4
	XGDX
	STAB  res5
	RTS

BINBCD
	LDX   #$64
	IDIV
	XGDX
	STAB  BCD1
	XGDX
BCD
	LDX   #$A
	IDIV
	XGDX
	STAB  BCD2
	XGDX
	STAB  BCD3
	RTS


************
*** TICKET *
************

TICKET

***************
*** IMPRIME A *
***************

	LDAA #'A
	STAA $3020
	LDAA #'
	STAA $3021
	LDAA #'=
	STAA $3022
	LDAA #'
	STAA $3023

	LDD  $0006
	JSR  BINBCD
	LDAA BCD2
	ADDA #$30
	STAA $3024
	LDAA BCD3
	ADDA #$30
	STAA $3025

	LDAA #'
	STAA $3026
	LDAA #'(
	STAA $3027
	LDAA #$30
	STAA $3028
	LDAA #$35
	STAA $3029
	LDAA #$30
	STAA $302A
	LDAA #'-
	STAA $302B

	LDD  menosA
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $302C
	LDAA BCD2
	ADDA #$30
	STAA $302D
	LDAA BCD3
	ADDA #$30
	STAA $302E
	LDAA #')
	STAA $302F


	LDAA #'$
	STAA $3030
	LDAA A1
	ADDA #$30
	STAA $3031
	LDAA A2
	ADDA #$30
	STAA $3032
	LDAA A3
	ADDA #$30
	STAA $3033
	LDAA A4
	ADDA #$30
	STAA $3034
	LDAA A5
	ADDA #$30
	STAA $3035

***************
*** IMPRIME B *
***************

	LDAA #'B
	STAA $3040
	LDAA #'
	STAA $3041
	LDAA #'=
	STAA $3042
	LDAA #'
	STAA $3043

	LDD  $0016
	JSR  BINBCD
	LDAA BCD2
	ADDA #$30
	STAA $3044
	LDAA BCD3
	ADDA #$30
	STAA $3045

	LDAA #'
	STAA $3046
	LDAA #'(
	STAA $3047
	LDAA #$31
	STAA $3048
	LDAA #$30
	STAA $3049
	LDAA #$30
	STAA $304A
	LDAA #'>
	STAA $304B

	LDD  menosB
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $304C
	LDAA BCD2
	ADDA #$30
	STAA $304D
	LDAA BCD3
	ADDA #$30
	STAA $304E
	LDAA #')
	STAA $304F

	LDAA #'$
	STAA $3050
	LDAA B1
	ADDA #$30
	STAA $3051
	LDAA B2
	ADDA #$30
	STAA $3052
	LDAA B3
	ADDA #$30
	STAA $3053
	LDAA B4
	ADDA #$30
	STAA $3054
	LDAA B5
	ADDA #$30
	STAA $3055

*******************
*ACOMODAR INFORMACION DE 'C' EN EL TICKET'
*******************

	LDAA #'C
	STAA $3060
	LDAA #'
	STAA $3061
	LDAA #'=
	STAA $3062
	LDAA #'
	STAA $3063

	LDD  $0016
	JSR  BINBCD
	LDAA BCD2
	ADDA #$30
	STAA $3064
	LDAA BCD3
	ADDA #$30
	STAA $3065

	LDAA #'
	STAA $3066
	LDAA #'(
	STAA $3067
	LDAA #$31
	STAA $3068
	LDAA #$30
	STAA $3069
	LDAA #$30
	STAA $306A
	LDAA #'>
	STAA $306B

	LDD  menosB
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $306C
	LDAA BCD2
	ADDA #$30
	STAA $306D
	LDAA BCD3
	ADDA #$30
	STAA $306E
	LDAA #')
	STAA $306F

	LDAA #'$
	STAA $3070
	LDAA C1
	ADDA #$30
	STAA $3071
	LDAA C2
	ADDA #$30
	STAA $3072
	LDAA C3
	ADDA #$30
	STAA $3073
	LDAA C4
	ADDA #$30
	STAA $3074
	LDAA C5
	ADDA #$30
	STAA $3075


*******************
*ACOMODAR INFORMACION DE 'D' EN EL TICKET'
*******************
	LDAA #'D
	STAA $3080
	LDAA #'
	STAA $3081
	LDAA #'=
	STAA $3082
	LDAA #'
	STAA $3083

	LDD  $0016
	JSR  BINBCD
	LDAA BCD2
	ADDA #$30
	STAA $3084
	LDAA BCD3
	ADDA #$30
	STAA $3085

	LDAA #'
	STAA $3086
	LDAA #'(
	STAA $3087
	LDAA #$31
	STAA $3088
	LDAA #$30
	STAA $3089
	LDAA #$30
	STAA $308A
	LDAA #'>
	STAA $308B

	LDD  menosB
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $308C
	LDAA BCD2
	ADDA #$30
	STAA $308D
	LDAA BCD3
	ADDA #$30
	STAA $308E
	LDAA #')
	STAA $308F

	LDAA #'$
	STAA $3090
	LDAA D1
	ADDA #$30
	STAA $3091
	LDAA D2
	ADDA #$30
	STAA $3092
	LDAA D3
	ADDA #$30
	STAA $3093
	LDAA D4
	ADDA #$30
	STAA $3094
	LDAA D5
	ADDA #$30
	STAA $3095


*******************
*ACOMODAR INFORMACION DE 'E' EN EL TICKET'
*******************

	LDAA #'E
	STAA $30A0
	LDAA #'
	STAA $30A1
	LDAA #'=
	STAA $30A2
	LDAA #'
	STAA $30A3

	LDD  $0016
	JSR  BINBCD
	LDAA BCD2
	ADDA #$30
	STAA $30A4
	LDAA BCD3
	ADDA #$30
	STAA $30A5

	LDAA #'
	STAA $30A6
	LDAA #'(
	STAA $30A7
	LDAA #$31
	STAA $30A8
	LDAA #$30
	STAA $30A9
	LDAA #$30
	STAA $30AA
	LDAA #'>
	STAA $30AB

	LDD  menosB
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $304C
	LDAA BCD2
	ADDA #$30
	STAA $30AD
	LDAA BCD3
	ADDA #$30
	STAA $30AE
	LDAA #')
	STAA $30AF

	LDAA #'$
	STAA $30B0
	LDAA E1
	ADDA #$30
	STAA $30B1
	LDAA E2
	ADDA #$30
	STAA $30B2
	LDAA E3
	ADDA #$30
	STAA $30B3
	LDAA E4
	ADDA #$30
	STAA $30B4
	LDAA E5
	ADDA #$30
	STAA $30B5

**ACOMODAR EL TOTAL
	LDAA #0
	LDAB #0
	ADDB A
	ADDB B
	ADDB C
	ADDB D
	ADDB E
	STAB totAr

	LDD  $0067
	JSR  BINBCD

	LDAA BCD1
	ADDA #$30
	STAA $30E0
	LDAA BCD2
	ADDA #$30
	STAA $30E1
	LDAA BCD3
	ADDA #$30
	STAA $30E2

	LDAA #'$
	STAA $30F0
	LDAA res1
	ADDA #$30
	STAA $30F1
	LDAA res2
	ADDA #$30
	STAA $30F2
	LDAA res3
	ADDA #$30
	STAA $30F3
	LDAA res4
	ADDA #$30
	STAA $30F4
	LDAA res5
	ADDA #$30
	STAA $30F5


	JSR  CARGAR_DIR
	LDX  #coin
	LDD  #$3150
	STD  DIR_IMP
	JSR  IMPRIMIR



	LDAA  #'/
	STAA  ORDEN
CICLO_FINAL
	LDAA  ORDEN
	CMPA  #'/
	BEQ   CICLO_FINAL
	JMP   LIMPIA
****ciclo despues del cual ya no se puede hacer NADA




CARGAR_DIR

	LDAA res5
	CMPA #5
	BEQ  CHECAR_5
	LDAA res4
	CMPA #1
	BEQ  PUENTE_PR_10
	CMPA #2
	BEQ  PUENTE_PR_20

CHECAR_DEC

	LDAA res4
	CMPA #3
	BEQ  PUENTE_PR_30
	CMPA #4
	BEQ  PUENTE_PR_40
	CMPA #5
	BEQ  PUENTE_PR_50
	CMPA #6
	BEQ  PUENTE_PR_60
	CMPA #7
	BEQ  PUENTE_PR_70
	CMPA #8
	BEQ  PUENTE_PR_80
	CMPA #9
	BEQ  PUENTE_PR_90
	JMP  CHECAR_100
PUENTE_PR_10
	JMP  PR_10
PUENTE_PR_20
	JMP  PR_20
PUENTE_PR_30
	JMP  PR_30
PUENTE_PR_40
	JMP  PR_40
PUENTE_PR_50
	JMP  PR_50
PUENTE_PR_60
	JMP  PR_60
PUENTE_PR_70
	JMP  PR_70
PUENTE_PR_80
	JMP  PR_80
PUENTE_PR_90
	JMP  PR_90


CHECAR_5

	LDAA res4
	CMPA #0
	BEQ  PUENTE_PR_5
	CMPA #1
	BEQ  PUENTE_PR_15
	CMPA #2
	BEQ  PUENTE_PR_25
	JMP  PUENTE_PR_Y5
PUENTE_PR_5
	JMP  PR_5
PUENTE_PR_15
	JMP  PR_15
PUENTE_PR_25
	JMP  PR_25
PUENTE_PR_Y5
	JMP  PR_Y5

CHECAR_100

	LDAA res3
	CMPA #1
	BEQ  PUENTE_PR_100

CHECAR_CENT

	LDAA res3
	CMPA #1
	BEQ  PUENTE_PR_100TO
	CMPA #2
	BEQ  PUENTE_PR_200
	CMPA #3
	BEQ  PUENTE_PR_300
	CMPA #4
	BEQ  PUENTE_PR_400
	CMPA #5
	BEQ  PUENTE_PR_500
	CMPA #6
	BEQ  PUENTE_PR_600
	CMPA #7
	BEQ  PUENTE_PR_700
	CMPA #2
	BEQ  PUENTE_PR_800
	CMPA #9
	BEQ  PUENTE_PR_900
	JMP  CHECAR_MIL
PUENTE_PR_100
	JMP  PR_100
PUENTE_PR_100TO
	JMP  PR_100TO
PUENTE_PR_200
	JMP  PR_200
PUENTE_PR_300
	JMP  PR_300
PUENTE_PR_400
	JMP  PR_400
PUENTE_PR_500
	JMP  PR_500
PUENTE_PR_600
	JMP  PR_600
PUENTE_PR_700
	JMP  PR_700
PUENTE_PR_800
	JMP  PR_800
PUENTE_PR_900
	JMP  PR_900

CHECAR_MIL
	LDAA res2
	CMPA #1
	BEQ  PUENTE_PR_1000
	CMPA #2
	BEQ  PUENTE_PR_2000
	CMPA #3
	BEQ  PUENTE_PR_3000
	CMPA #4
	BEQ  PUENTE_PR_4000
	CMPA #5
	BEQ  PUENTE_PR_5000
	CMPA #6
	BEQ  PUENTE_PR_6000
	CMPA #7
	BEQ  PUENTE_PR_7000
	CMPA #8
	BEQ  PUENTE_PR_8000
	CMPA #9
	BEQ  PUENTE_PR_9000

CHECAR_10MIL
	LDAA res1
	CMPA #1
	BEQ  PUENTE_PR_10000
	RTS

PUENTE_PR_1000
	JMP  PR_1000
PUENTE_PR_2000
	JMP  PR_2000
PUENTE_PR_3000
	JMP  PR_3000
PUENTE_PR_4000
	JMP  PR_4000
PUENTE_PR_5000
	JMP  PR_5000
PUENTE_PR_6000
	JMP  PR_6000
PUENTE_PR_7000
	JMP  PR_7000
PUENTE_PR_8000
	JMP  PR_8000
PUENTE_PR_9000
	JMP  PR_9000
PUENTE_PR_10000
	JMP  PR_10000

IMPRIMIR
	LDAA 0,X
	CMPA #'.
	BEQ  FIN_IMPR
	LDY  DIR_IMP
	STAA 0,Y
	INX
	LDD  DIR_IMP
	ADDD #1
	STD  DIR_IMP
	JMP  IMPRIMIR
FIN_IMPR
	RTS


PR_Y5
	LDX  #unoY5
	LDD  #$313A
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_DEC
PR_5
	LDX  #uno05
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_15
	LDX  #diez15
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_25
	LDX  #diez25
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_10
	LDX  #diez01
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_20
	LDX  #diez02
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_30
	LDX  #diez03
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_40
	LDX  #diez04
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_50
	LDX  #diez05
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_60
	LDX  #diez06
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_70
	LDX  #diez07
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_80
	LDX  #diez08
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_90
	LDX  #diez09
	LDD  #$3130
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_CENT
PR_100
	LDX  #cien01
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_100TO
	LDX  #cient0
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_200
	LDX  #cien02
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_300
	LDX  #cien03
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_400
	LDX  #cien04
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_500
	LDX  #cien05
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_600
	LDX  #cien06
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_700
	LDX  #cien07
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_800
	LDX  #cien08
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_900
	LDX  #cien09
	LDD  #$3120
	STD  DIR_IMP
	JSR  IMPRIMIR
	JMP  CHECAR_MIL
PR_1000
	LDX  #mil01
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS
PR_2000
	LDX  #mil02
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS
PR_3000
	LDX  #mil03
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS
PR_4000
	LDX  #mil04
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS

PR_5000
	LDX  #mil05
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS

PR_6000
	LDX  #mil06
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS

PR_7000
	LDX  #mil07
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS
PR_8000
	LDX  #mil08
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS

PR_9000
	LDX  #mil09
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS
PR_10000
	LDX  #mil10
	LDD  #$3110
	STD  DIR_IMP
	JSR  IMPRIMIR
	RTS

**************************************************
* SUBRUTINA  DE CONFIGURACION PUERTO SERIAL      *
**************************************************

SERIAL
       LDD   #$302C  * CONFIGURA PUERTO SERIAL
       STAA  BAUD    * BAUD  9600  para cristal de 8MHz
       STAB  SCCR2   * HABILITA  RX Y TX PERO INTERRUPCN SOLO RX
       LDAA  #$00
       STAA  SCCR1   * 8 BITS

       LDAA  #$FE    * CONFIG PUERTO D COMO SALIDAS (EXCEPTO PD0)
       STAA  DDRD    * SEA  ENABLE DEL DISPLAY  PD4  Y RS PD3

       LDAA  #$04
       STAA  HPRIO

       LDAA  #$00
       TAP
       RTS

***********************************
* ATENCION A INTERRUPCION SERIAL
***********************************

       ORG  $F100

       LDAA SCSR
       LDAA SCDR
       STAA ORDEN
       DEC  VAR

       RTI

***********************************
* VECTOR INTERRUPCION SERIAL
***********************************

       ORG   $FFD6
       FCB   $F1,$00

***********************************
*RESET
***********************************
       ORG    $FFFE
RESET  FCB    $80,$00

***********************************

   ORG   $2F00

mens00	FCC   '     For more    '

   ORG   $2F10

mens01	FCC   '   cool things   '

   ORG   $2F20

mens02	FCC   '    like this    '

	ORG	$2F30

mens03	FCC	'    check out    '
	ORG	$2F40

mens04	FCC	'   my website    '

   ORG   $2F50

mens05	FCC   '  and say hello  '

	ORG	$2F60

mens06	FCC	'                '

	ORG	$2F70

mens07	FCC	'    daedra.ml   '

   ORG   $2F80

mens08	FCC   '    daedra.ml   '

	ORG	$2F90

mens09	FCC	'    daedra.ml   '

	ORG	$2FA0

mens10	FCC	'                '

	ORG	$2FB0

mens11	FCC	'~~~~~~~~~~~~~~~~'

	ORG	$2FC0

mens12	FCC	'Bienvenido, prof'

	ORG	$2FD0

mens13	FCC	'                '

	ORG	$2FE0

mens15	FCC	'     Ticket     '

	ORG	$2FF0

mens16	FCC	'                '

	ORG   $3000

mens17	FCC   'P = Pi (Pu  Des)'

	ORG   $3010

mens18	FCC   '                '

	ORG   $30C0

mens19	FCC   '~~~~~~~~~~~~~~~~'

	ORG   $30D0

mens20	FCC   '     Total:     '

	ORG   $30E3

mens21	FCC   '  Piezas        '

	ORG   $0060

mens22   FCC   'ERROR + 10000   '

	END
