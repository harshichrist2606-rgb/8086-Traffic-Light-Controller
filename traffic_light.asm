;=========================================================
; 8086 TRAFFIC LIGHT CONTROLLER
; 8255 PPI INTERFACING
;
; Port A = 80H
; Port B = 82H
; Port C = 84H
; Control Register = 86H
;
; PA0 = RED
; PA1 = YELLOW
; PA2 = GREEN
;=========================================================

.MODEL SMALL
.STACK 100H

.DATA

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ;-----------------------------------------------------
    ; Initialize 8255
    ; Control Word = 80H
    ;
    ; Port A = Output
    ; Port B = Output
    ; Port C = Output
    ; Mode 0
    ;-----------------------------------------------------

    MOV AL, 80H
    OUT 86H, AL

TRAFFIC_LOOP:

    ;-----------------------------------------------------
    ; GREEN LIGHT
    ;-----------------------------------------------------

    MOV AL, 04H
    OUT 80H, AL

    CALL LONG_DELAY

    ;-----------------------------------------------------
    ; YELLOW LIGHT
    ;-----------------------------------------------------

    MOV AL, 02H
    OUT 80H, AL

    CALL SHORT_DELAY

    ;-----------------------------------------------------
    ; RED LIGHT
    ;-----------------------------------------------------

    MOV AL, 01H
    OUT 80H, AL

    CALL LONG_DELAY

    ;-----------------------------------------------------
    ; Repeat traffic sequence
    ;-----------------------------------------------------

    JMP TRAFFIC_LOOP


;=========================================================
; LONG DELAY
;=========================================================

LONG_DELAY PROC

    MOV CX, 0FFFFH

DELAY1:
    MOV DX, 0FFFFH

DELAY2:
    DEC DX
    JNZ DELAY2

    LOOP DELAY1

    RET

LONG_DELAY ENDP


;=========================================================
; SHORT DELAY
;=========================================================

SHORT_DELAY PROC

    MOV CX, 0FFFFH

DELAY3:
    NOP
    LOOP DELAY3

    RET

SHORT_DELAY ENDP


MAIN ENDP
END MAIN
