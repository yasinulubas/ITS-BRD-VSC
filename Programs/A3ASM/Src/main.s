;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
                mov   r0,#0x12                      ; Anw-01 - Konstante 0x12 in r0
                mov   r1,#-128                      ; Anw-02 - Konstante -128 in r1
                ldr   r2,=0x12345678                ; Anw-03 - 32-Bit-Wert wird in r2 geladen, Bit-Wert + Befehl selber zu groß für Maschinenbefehl. 0x12345678 wird in Literal Pool gesepichert

; Zugriff auf Variable
                ldr   r0,=VariableA                 ; Anw-04 - Adresse von VariableA in r0 geladen
                ldrh  r1,[r0]                       ; Anw-05 - Erstes Halbwort aus VariableA in r1
                ldr   r2,[r0]                       ; Anw-06 - Wort aus VariableA in r2
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07 - Speichert Wert aus r2 an Adresse aus r0 mit Versatz von VariableC-VariableA 

; Zugriff auf Felder (Speicherzellen)
                ldr   r0,=MeinHalbwortFeld          ; Anw-08 - Adresse MeinHalbwortFeld in r0
                ldrh  r1,[r0]                       ; Anw-09 - Halbwort aus Adresse r0 in r1
                ldrh  r2,[r0,#2]                    ; Anw-10 - Halbwort aus Adresse r0 mit Offset 2 Bytes in r2
                mov   r3,#10                        ; Anw-11 - Konstante in r3 
                ldrh  r4,[r0,r3]                    ; Anw-12 - Halbwort in r4 aus Adresse r0 mit Offset von Konstante in r3

                ldrh  r5,[r0,#2]!                   ; Anw-13 - Lädt Halbwort in r5 aus Adresse r0 (Adresse r0 Writeback 2 Bytes)
                ldrh  r6,[r0,#2]!                   ; Anw-14 - Lädt Halbwort in r6 aus Adresse r0 (Adresse r0 Writeback 2 Bytes)
                strh  r6,[r0,#2]!                   ; Anw-15 - Speichert Halbwort aus r6 an Adresse in r0 (Writeback 2 Bytes)

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ldr  r0,=MeinWortFeld               ; Anw-16 - Speichert Adresse von MeinWortFeld in r0
                ldr  r1,[r0]                        ; Anw-17 - Lädt Wort aus r0 in r1
                ldr  r2,[r0,#4]                     ; Anw-18 - Lädt Wort aus r0 mit Offset 4 Bytes in r2
                adds r3,r1,r2                       ; Anw-19 - Addiert r1 und r2, speichert Ergebnis in r3 ("s" Statusregister werden aktualisiert)

                ldr  r4,[r0,#8]                     ; Anw-20 - Lädt Wort aus r0 mit Offset 4 Bytes in r4
                ldr  r5,[r0,#12]                    ; Anw-21 - Lädt Wort aus r0 mit Offset von 12 Bytes in r5
                subs r6,r4,r5                       ; Anw-22 - Subtrahiert r4 und r5 speichert Ergebnis in r6 ("s" Statusregister werden aktualisiert)

                ldr  r7,[r0,#16]                    ; Anw-23 - Lädt Wort aus r0 mit Offset von 16 Bytes in r7
                ldr  r8,[r0,#20]                    ; Anw-24 - Lädt Wort aus r0 mit Offset von 20 Bytes in r8
                subs r9,r7,r8                       ; Anw-25 - Subtrahiert r7 und r8 speichert Ergebnis in r9 ("s" Statusregister werden aktualisiert)

forever         b   forever                         ; Anw-26 - Unendlicher Loop
                ENDP
                END