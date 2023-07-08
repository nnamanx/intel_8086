set 0               ; segment 1
STR:DB "H"          ; storing "HELLO WORLD"
DB "E"
DB "L"
DB "L"
DB "O"
DB " "
DB "W"
DB "O"
DB "R"
DB "L"
DB "D"


set 0x1             ; segment 2
LETTER: DB "H"      ; storing the letter

set 0x2
RESULT:DB [0,1]     ; store space for final data. Will turn 1 if the letter exists 

start:

    mov AX, 0               ; move address of segment 1
    mov DS, AX              ; to DS

    mov AX, 0x1             ; move address of segment 2
    mov ES, AX              ; to ES

    mov AX, 0x2             ; mov address of result AKA segment 3
    mov SS, AX              ; to SS

    mov CX, 11              ; counter

    mov SI, OFFSET STR      ; initializing the first segment data

    mov DI, OFFSET LETTER   ; initializing the second segment data

    mov BX, OFFSET RESULT   ; moving offset of result to BX 

_search:
    mov AH, byte DS[SI]     ; moving one byte from source to AH
    cmp AH, byte ES[DI]     ; comparing ah element with the corresponding element from the second arra
    je _found               ; jump to found part if letters are equal
    inc SI                  ; AKA SI++ -> will go through the segment 1
    dec CX                  ; AKA counter--     
    jnz _search 

_found:
    mov byte SS[BX], 0x1    ; storing 1 in the third array because the letter exists in the segment 1
    jmp _exit               ; jumpt to _exit cause the letter has been found  

_exit:
    int 0x03                ; interrupt to terminate program.    