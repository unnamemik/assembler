sravn macro
mov dx,bx
add dx,si
cmp dx,koorz
endm

soxr macro
mov ax,koory
mov koorz,ax
mov ax,koorx
mov koory,ax
mov koorx,dx
xor ax,ax
endm

masm
model small
.stack ?
.data
include mas.gng
dot db 1
no_dot db 'Linija prervana!','$'
no_data db 'Dannyx net!','$'
exit_prg db 'Rabota zavershena! Press any key...','$'
first_x dw ?
first_y dw ?
koorx dw ?
koory dw ?
koorz dw ?
matrix dw 16
speed dw 65000
.code
main:
	mov ax,@data
	mov ds,ax
	xor ax,ax
	mov dx,0378h
	out dx,al
	call find_dot
dot_loop:
	mov first_x,bx
	mov first_y,si
looking:	
	call centre
port:	
	cmp first_x,bx
	je next
	jmp output
next:
	cmp first_y,si
	je finish
output:
	mov cx,speed
output1:	
	mov dx,0378h
	out dx,al
	loop output1
	xor ax,ax
	mov dx,0378h
	out dx,al	
	jmp looking
finish: 
	mov dx,offset exit_prg
	mov ah,09h
	int 21h	

	mov ah,10h
	int 16h	

	xor ax,ax
	mov dx,0378h
	out dx,al

	mov ax,4c00h
	int 21h
centre proc 
dot1:
inc si
mov al, mas(bx)(si)
cmp al,dot
jne dot2
sravn
je dot2
cmp koory,dx
je dot2
cmp koorx,dx
je dot2
soxr
mov al,00000100b
jmp port

dot2:
add bx,16
mov al, mas(bx)(si)
cmp al,dot
jne dot3
sravn
je dot3
cmp koory,dx
je dot3
cmp koorx,dx
je dot3
soxr
mov al,00000110b
jmp port

dot3:
dec si				;110
mov al, mas(bx)(si)
cmp al,dot
jne dot4
sravn
je dot4
cmp koory,dx
je dot4
cmp koorx,dx
je dot4
soxr
mov al,00000010b
jmp port

dot4:
dec si				;132
mov al, mas(bx)(si)
cmp al,dot
jne dot5
sravn
je dot5
cmp koory,dx
je dot5
cmp koorx,dx
je dot5
soxr
mov al,00001010b
jmp port

dot5:
sub bx,16
mov al, mas(bx)(si)
cmp al,dot
jne dot6
sravn
je dot6
cmp koory,dx
je dot6
cmp koorx,dx
je dot6
soxr
mov al,00001000b
jmp port

dot6:
sub bx,16
mov al, mas(bx)(si)
cmp al,dot
jne dot7
sravn
je dot7
cmp koory,dx
je dot7
cmp koorx,dx
je dot7
soxr
mov al,00001001b
jmp port

dot7:
inc si
mov al, mas(bx)(si)
cmp al,dot
jne dot8
sravn
je dot8
cmp koory,dx
je dot8
cmp koorx,dx
je dot8
soxr
mov al,00000001b
jmp port

dot8:
inc si
mov al, mas(bx)(si)
cmp al,dot
jne dot9
sravn
je dot9
cmp koory,dx
je dot9
cmp koorx,dx
je dot9
soxr
mov al,00000101b
jmp port			;234

dot9:
mov dx,offset no_dot
mov ah,09h
int 21h
jmp finish
ret
centre endp

find_dot proc
	mov bx,0
	mov si,0
	mov cx,matrix

eter:
	push cx
	mov cx,matrix

iter:
	mov al,mas[bx][si]
	cmp al,dot
	je here
	inc si
	loop iter
	jcxz move_next
here:
	jmp dot_loop
move_next:
	pop cx
	xor si,si
	add bx,matrix
	loop eter
	mov dx,offset no_data
	mov ah,09h
	int 21h
	jmp finish
	ret
find_dot endp

end main