set 0                   ; segment 1
ARR1:DB 0x2F            
DB 0xA8
DB 0x73
DB 0xE4
DB 0x5D
DB 0x5B
DB 0x8C
DB 0x17
DB 0x9E
DB 0x41


set 0x1                 ; segment 2
ARR2:DB 0x3B   
DB 0x52
DB 0x98
DB 0x67
DB 0x1F
DB 0xAE
DB 0x36
DB 0xC9
DB 0x70
DB 0xED

set 0x2
RESULT:DB [0,10]        ; store data

start:

mov AX, 0                ; move address of segment 1
mov DS, AX              ; to DS

mov AX, 0x1             ; move address of segment 2
mov ES, AX              ; to ES

mov AX, 0x2             ; mov address of result segment(3)
mov SS, AX              ; to SS

mov CX, 10              ; counter

; Initializing the first array
mov SI, OFFSET ARR1

; Initializing the second array
mov DI, OFFSET ARR2 

; Result array
mov BX, OFFSET RESULT   ; move offset of result to BX 

_loop:
mov AH, byte DS[SI]      ; move one byte from source to ah
cmp AH, byte ES[DI]     ; comparing ah element with the corresponding element from the second arra
jae _first_is_bigger         ; Jump if the first array element is greater or equal
mov AH, byte ES[DI]     ; Load the second array element if it is bigger
jmp _store_element
_first_is_bigger:
mov AH, byte DS[SI]     ; Load the first array element if it is bigger or equal

_store_element:
mov byte SS[BX], AH    ; Store the bigger element in the third array

inc SI                  
inc DI
inc BX         ;in 3rd segment indexes
dec CX                 
jnz _loop   
