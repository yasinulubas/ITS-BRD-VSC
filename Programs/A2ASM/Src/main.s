;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke    
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2  
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC	DCW 0xaffe

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Anw01
    ldrb    R2,[R0]         ; Anw02
    ldrb    R3,[R0,#1]      ; Anw03
    lsl     R2, #8          ; Anw04 0b1110_1111 (239) --> 1110_1111_0000_0000 (61184)
    orr     R2, R3          ; Anw05
    strh    R2,[R0]         ; Anw06 
    
;* const in var
    ;mov     R5,#ConstByteA  ; Anw07
    ;strh    R5,[R0]         ; Anw08
    
;* Vertauschung für Affe
    ldr     R0,=VariableC
	ldrb	R8,[R0]
	ldrb	R9,[R0,#1]
	lsl		R8, #8
	orr		R8, R9
	strh	R8,[R0]

;* Change value from x1234 to x4321
    ldr     R1,=VariableB   ; Anw09
    mov     R6, #0x3412     ; Lädt 0x3412 direkt in R6
    strh    R6, [R1]        ; Speichert den Wert in RAM

    b .
    

;Vorheriger Code: 
    ;ldrh    R6,[R1]         ; Anw0A, 0b0001_0010_0011_0100
    ;mov     R7, #0x30ED     ; Anw0B, 0b0011_0000_1110_1101
    ;add     R6, R6, R7      ; Anw0C, 0b0100_0011_0010_0001
    ;strh    R6,[R1]         ; Anw0D
    ;b .                     ; Anw0E
    
    ALIGN
    END