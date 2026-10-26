Anw01:
    R0: Verweist auf die Adresse in der die VariableA gespeichert ist --> 0x2000000c
        Gespeichert in Little Endian: LSB: EF, MSB: BE (ist ein Halbwort = 16 bit / 2 Byte --> deswegen auch DCW)

    Speicher: ef be 34 12 

Anw02:
    R2: ldrb (Load Register Byte), lädt den Wert aus dem RAM [R0] in Register R2 --> 0xef (genau 1 Byte), restlichen 24 Bits in R2 werden mit Nullen aufgefüllt

    [R0] bedeutet: nicht der Wert in R0, sondern der Wert in der Adresse im RAM

    Speicher: keine Veränderung

Anw03:
    R3: das Gleiche wie in Anw02, nur mit einem Offset von 1
        Adresse aus [R0] + 1 --> 0x2000000d --> (0xbe)

    Speicher: keine Veränderung

Anw04:
    R2: LSL = Logical Shift Left, Wert in Register R2 wird um 8 Bits nach links verschoben -->0xef00

    Oder auch einfach  * 2^n, n = Anzahl der Positionen in Bit
    1110_1111 (239) --> 1110_1111_0000_0000 (61184)

    Speicher: Keine Veränderung

Anw05:
    R2: orr = Logisches ODER (Wahrheitstabelle), in R2 wird das Ergebnis von R2 ORR R3 gespeichert

    R2: 0xef00  1110_1111_0000_0000
    R3: 0x00be  0000_0000_1011_1110 
    -------------------------------
    R2: 0xefbe  1110_1111_1011_1110

    Speicher: Keine Veränderung

Anw06:
    Speichert die Zahl in R2 in den RAM dessen Adresse in [R0] liegt
    Undzwar im Little Endian Format --> aus 0xefbe (tatsächlicher Wert) wird im Speicher beef 

    Speicher: be ef

Anw07:
    R5: kopiert die Konstante, also einen direkten Wert, in R5. Kein Zugriff auf den RAM. --> 0xaffe

    Speicher: Keine Veränderung

Anw08:
    Halbwort aus Register R5 wird vorderster Stelle im RAM gespeichert (Adresse auf die R0 verweist)

    Speicher: fe af (Little Endian)

Anw09:
    R1: Selbe wie in Anw01. R1 enthält Speicheradresse von VariableB --> 0x2000000e

    Speicher: Keine Veränderung

Anw0A:
    R6: in Register wird mit ldrh das Halbwort geladen, welches an der Adresse im Speicher steht auf die R1 verweist --> 0x1234

Anw0B:
    R7: Kopiert den Wert 0x30ED direkt in den Register

    Speicher: Keine Veränderung

Anw0C:
    R6: Addiere den Wert aus R6 mit R7 und speicher in in Register R6

        0b0001_0010_0011_0100 --> 0x30ed
       +0b0011_0000_1110_1101 --> 0x1234
       ---------------------
        0b0100_0011_0010_0001 --> 0x4321

    Speicher: Keine Veränderung

Anw0D: 
    Speicher das Halbwort aus R6 in [R1]

    Speicher: 0x2000000e: 21 43