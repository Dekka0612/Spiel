[org 0x7c00]

_start:
    mov [diskNum], dl
    jmp init_print

init_print:
    mov ah, 0x0e
    mov bx, welcome
    jmp print

print:
    je exit
    mov al, [bx]
    cmp al, 0
    je init_load
    add bx, 1
    int 0x10
    jmp print

init_load:
    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [diskNum]
    mov bx, 0
    mov es, bx           ; Addresse = es * 16 + bx
    mov bx, 0x7e00
    jmp load

load:
    int 0x13
    cmp bx, 0x7e00 + 512
    jmp init_test
    add bx, 1
    jmp load

exit:
    jmp $

welcome:
    db 0x0a, 0x0d, "Olla Nigger", 0x0a, 0x0d, 0

diskNum:
    db 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa

init_test:
    mov ah, 0x0e
    mov bx, text
    jmp test

test:
    mov al, [bx]
    cmp al, 0
    je exit
    add bx, 1
    int 0x10
    jmp test

text:
    db 0x0a, 0x0d, "Geht :)", 0