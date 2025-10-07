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
    jmp init_draw
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

init_draw:
    mov ah, 0x00
    mov al, 0x12 ;Bildschirmmodus: 640 x 480 ~ 4 Farben
    int 0x10
    mov ah, 0x0c
    mov al, 0x3  ;farben: https://en.wikipedia.org/wiki/BIOS_color_attributes
    mov bh, 1 ; page num
    mov cx, 0 ;x cord
    mov dx, 0 ;y cord
    jmp draw

draw:
    cmp cx, 320
    je reset_x
    int 0x10
    add cx, 1
    jmp draw

reset_x:
    mov cx, 0
    cmp dx, 240
    je exit
    add dx, 1
    jmp draw
