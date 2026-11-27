        nam   HELLOASM

* Color BASIC ROM vector table:
* $A002:$A003 => CHROUT (output character in A to current device)
* Source used during this lab pass:
* http://computerarcheology.com/CoCo/Hardware.html#rom-vectors
CHROUT  equ   $A002

        org   $2000

START   ldx   #MESSAGE
LOOP    lda   ,x+
        beq   DONE
        jsr   [CHROUT]
        bra   LOOP

DONE    ldx   #SCREENMSG
        ldy   #$0400
SCRLP   lda   ,x+
        beq   EXIT
        sta   ,y+
        bra   SCRLP

EXIT    lda   #$42
        sta   $7000
        rts

MESSAGE fcc   "HELLO WORLD FROM ASM"
        fcb   $0d,$00
SCREENMSG fcc "HELLO WORLD FROM ASM"
        fcb   $00

        end   START
