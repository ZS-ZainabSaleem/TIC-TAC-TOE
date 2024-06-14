[org 0x100]
jmp start
playermsg:db 'Enter char btw a to p..'
playermsg2:db 'wrong input,Enter again'
lenplayermsg:dw 23
turnmsg: db'Player 1 turn'
turnmsg2: db'Player 2 turn'
lenturnmsg:dw 13
winnermsg: db '*Player 1 Won* '
winnermsg2:db '*Player 2 Won* '
lenwinnermsg:dw 14
resultArray: dw 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
playersign:db 'X'
player:db 1
drawmsg: db '!!!Draw!!!'
lendrawmsg: dw 10
Names:db 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p'
 clear:
	 mov ax,0xb800
	 mov es,ax 
	 mov di,0 
next: 
	 mov word [es:di],0x6020
	 add di,2 
	 cmp di,4000 
	 jne next
	 
	 mov di,164
	next5: 
	 mov word [es:di],0x6707
	 add di,4
	 cmp di,3840
	 jne next5
      ret
screenborder:
	 mov di,164
	 mov ah,0h
	 mov al,20h
	 mov cx,76
	 next2:
	 mov word [es:di],ax
	 add di,2
	 dec cx
	 jnz next2
	 
	 mov di,3684
	 mov cx,76
	 next3:
	 mov word [es:di],ax
	 add di,2
	 dec cx
	 jnz next3
	 
	 mov di,314
	 mov cx,23
	 next4:
	 mov word [es:di],ax
	 add di,160
	 dec cx
	 jnz next4
		
		ret
printmsg:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 0  
	 mov si, playermsg  
	 mov cx, [lenplayermsg] 
	 mov ah, 0x70  
	nextchar:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar
	 ret
printmsg2:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 0  
	 mov si, playermsg2  
	 mov cx, [lenplayermsg] 
	 mov ah, 0x04  
	nextchar2:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar2
	 ret
printturnmsg:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 134  
	 mov si, turnmsg  
	 mov cx, [lenturnmsg] 
	 mov ah, 0x70  
	nextchar3:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar3
	 ret
printturnmsg2:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 134  
	 mov si, turnmsg2  
	 mov cx, [lenturnmsg] 
	 mov ah, 0x70  
	nextchar4:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar4
	 ret
printwinnermsg:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 320  
	 mov si, winnermsg  
	 mov cx, [lenwinnermsg] 
	 mov ah, 0x70
	nextchar5:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar5
	 jmp done
printwinnermsg2:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 320  
	 mov si, winnermsg2 
	 mov cx, [lenwinnermsg] 
	 mov ah, 0x70 
	nextchar6:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar6
	 jmp done	
printdrawmsg:
	 mov ax, 0xb800 
	 mov es, ax  
	 mov di, 326  
	 mov si, drawmsg  
	 mov cx, [lendrawmsg] 
	 mov ah, 0x70 
	nextchar7:
   	 mov al, [si] 
	 mov [es:di], ax 
	 add di, 2  
	 add si, 1 
	 loop nextchar7
	 jmp done	 
box:
	 push bp
	 mov bp,sp
	 
	 mov ax,0xb800
	 mov es,ax 
	 mov al,80
	 mul byte[bp+6]
	 add ax,[bp+4]
	 shl ax,1
	 mov di,ax
	 mov si,0
	 mov cx,0
	nextloc: 
		 mov word[es:di],0x7020 
		 add di,2 
		 add cx,2
		 cmp cx,20
		 je equal
		 jmp nextloc
	equal:
		mov cx,0
		add di,140
		inc si
		cmp si,4
		je endl
		jmp nextloc
	endl:
		 pop bp
		 ret 4
read_keyboard:
	 mov ah,0
	 int 0x16
	 ret
printsign:
	 push bp
	 mov bp,sp
	 push ax
	 push es
	 push si
	 push di
	 mov ax,0xb800
	 mov es,ax 
	 mov si,playersign
	 mov al,80
	 mul byte[bp+6]
	 add ax,[bp+4]
	 shl ax,1
	 mov di,ax
	 cmp word[es:di], 0x7020
	 jne again
	 mov ah, 0x70  
   	 mov al, [si] 
	 mov [es:di], ax 
		 pop di
		 pop si
		 pop es
		 pop ax
	 	 pop bp
		 ret 4
again:
	call printmsg2
	call read_keyboard
	jmp input


;-----------------------comparingboxes-----------------------

checkrow1:	  
	 

	 mov ax,[resultArray]
	 mov bx, [resultArray+2]
	 cmp ax,bx
	 jne checkrow2
	 mov ax,[resultArray+4]
	 cmp ax,bx

	 jne checkrow2
	 mov bx,[resultArray+6]
	 cmp ax,bx
	 jne checkrow2
	 jmp checkwinner

checkrow2:
	 mov ax,[resultArray+8]
	 mov bx, [resultArray+10]
	 cmp ax,bx
	 jne checkrow3
	 ;call checkspace
	 mov ax,[resultArray+12]
	 cmp ax,bx

	 jne checkrow3
	 ;call checkspace
	 mov bx,[resultArray+14]
	 cmp ax,bx

	 jne checkrow3
	 jmp checkwinner

checkrow3:
	 mov ax,[resultArray+16]
	 mov bx, [resultArray+18]
	 cmp ax,bx
	 jne checkrow4
	 ;call checkspace
	 mov ax,[resultArray+20]
	 cmp ax,bx

	 jne checkrow4
	 ;call checkspace
	 mov bx,[resultArray+22]
	 cmp ax,bx

	 jne checkrow4
	 jmp checkwinner

checkrow4:
	 mov ax,[resultArray+24]
	 mov bx, [resultArray+26]
	 cmp ax,bx
	 jne checkcol1
	 ;call checkspace
	 mov ax,[resultArray+28]
	 cmp ax,bx

	 jne checkcol1
	 ;call checkspace
	 mov bx,[resultArray+30]
	 cmp ax,bx

	 jne checkcol1
	 jmp checkwinner

checkcol1:
	 mov ax,[resultArray]
	 mov bx, [resultArray+8]
	 cmp ax,bx
	 jne checkcol2
	 ;call checkspace
	 mov ax,[resultArray+16]
	 cmp ax,bx

	 jne checkcol2
	 ;call checkspace
	 mov bx,[resultArray+24]
	 cmp ax,bx

	 jne checkcol2
	 jmp checkwinner

checkcol2:
	 mov ax,[resultArray+2]
	 mov bx, [resultArray+10]
	 cmp ax,bx
	 jne checkcol3
	 ;call checkspace
	 mov ax,[resultArray+18]
	 cmp ax,bx

	 jne checkcol3
	 ;call checkspace
	 mov bx,[resultArray+26]
	 cmp ax,bx

	 jne checkcol3
	 jmp checkwinner


checkcol3:
	 mov ax,[resultArray+4]
	 mov bx, [resultArray+12]
	 cmp ax,bx
	 jne checkcol4
	 ;call checkspace
	 mov ax,[resultArray+20]
	 cmp ax,bx

	 jne checkcol4
	 ;call checkspace
	 mov bx,[resultArray+28]
	 cmp ax,bx

	 jne checkcol4
	 jmp checkwinner


checkcol4:
	 mov ax,[resultArray+6]
	 mov bx, [resultArray+14]
	 cmp ax,bx
	 jne checkdigonal1
	 ;call checkspace
	 mov ax,[resultArray+22]
	 cmp ax,bx

	 jne checkdigonal1
	 ;call checkspace
	 mov bx,[resultArray+30]
	 cmp ax,bx

	 jne checkdigonal1
	 jmp checkwinner

checkdigonal1:
	 mov ax,[resultArray+0]
	 mov bx, [resultArray+10]
	 cmp ax,bx
	 jne checkdigonal2
	 ;call checkspace
	 mov ax,[resultArray+20]
	 cmp ax,bx

	 jne checkdigonal2
	 ;call checkspace
	 mov bx,[resultArray+30]
	 cmp ax,bx

	 jne checkdigonal2
	 jmp checkwinner


checkdigonal2:
	 mov ax,[resultArray+6]
	 mov bx, [resultArray+12]
	 cmp ax,bx
	 jne draw
	 ;call checkspace
	 mov ax,[resultArray+18]
	 cmp ax,bx

	 jne draw
	 ;call checkspace
	 mov bx,[resultArray+24]
	 cmp ax,bx

	 jne draw
	 jmp checkwinner
finish:
	jmp changeplayer 

draw:
	cmp [resultArray+0],word 0
	je finish
	cmp [resultArray+2],word 1
	je finish
	cmp [resultArray+4],word 2
	je finish
	cmp [resultArray+6],word 3
	je finish
	cmp [resultArray+8],word 4
	je finish
	cmp [resultArray+10],word 5
	je finish
	cmp [resultArray+12],word 6
	je finish
	cmp [resultArray+14],word 7
	je finish
	cmp [resultArray+16],word 8
	je finish
	cmp [resultArray+18],word 9
	je finish
	cmp [resultArray+20],word 10
	je finish
	cmp [resultArray+22],word 11
	je finish
	cmp [resultArray+24],word 12
	je finish
	cmp [resultArray+26],word 13
	je finish
	cmp [resultArray+28],word 14
	je finish
	cmp [resultArray+30],word 15
	je finish
	jmp printdrawmsg 

	 
checkwinner:
	 cmp byte[playersign],'X'
	 je printwinnermsg
	 jmp printwinnermsg2
	 
				;------change player after each turn--------------
changeplayer:
	mov al,[player]
	cmp al, 1
	je player2
	call printturnmsg
	mov al,1
	mov byte[player],al
	mov byte[playersign],'X'
	call read_keyboard
	jmp input
	player2:
		call printturnmsg2
		mov al,2
		mov byte[player],al
		mov byte[playersign],'O'
		call read_keyboard
		jmp input
Nameboxes:
	 push bp
	 mov bp,sp
	 
	 mov ax,0xb800
	 mov es,ax 
	 mov si,[bP+8]
	 mov al,80
	 mul byte[bp+6]
	 add ax,[bp+4]
	 shl ax,1
	 mov di,ax
	 mov ah, 0x70  
   	 mov al, [si] 
	 mov [es:di], ax 
		 pop bp
		 ret 6

start:
	call clear
	call screenborder
;first row boxes
	mov ax,3
	push ax
	mov ax,15
	push ax
	call box
	mov ax,3
	push ax
	mov ax,26
	push ax
	call box
	mov ax,3
	push ax
	mov ax,37
	push ax
	call box
	mov ax,3
	push ax
	mov ax,48
	push ax
	call box
;second row boxes
	mov ax,8		;row[bp+6]
	push ax
	mov ax,15		;col[bp+4]
	push ax
	call box
	mov ax,8		
	push ax
	mov ax,26		
	push ax
	call box
	mov ax,8		
	push ax
	mov ax,37		
	push ax
	call box
	mov ax,8		
	push ax
	mov ax,48		
	push ax
	call box
;third row boxes
	mov ax,13		
	push ax
	mov ax,15		
	push ax
	call box
	mov ax,13		
	push ax
	mov ax,26		
	push ax
	call box
	mov ax,13		
	push ax
	mov ax,37		
	push ax
	call box
	mov ax,13		;row[bp+6]
	push ax
	mov ax,48		;col[bp+4]
	push ax
	call box
;forth row boxes
	mov ax,18		;row[bp+6]
	push ax
	mov ax,15		;col[bp+4]
	push ax
	call box
	mov ax,18		;row[bp+6]
	push ax
	mov ax,26		;col[bp+4]
	push ax
	call box
	mov ax,18		;row[bp+6]
	push ax
	mov ax,37		;col[bp+4]
	push ax
	call box
	mov ax,18		;row[bp+6]
	push ax
	mov ax,48		;col[bp+4]
	push ax
	call box
	
;print starting msg
	call printmsg
	
;Name boxes
;first row Names
	mov ax,Names+0
	push ax
	mov ax,3
	push ax
	mov ax,15
	push ax
	call Nameboxes
	mov ax,Names+1
	push ax
	mov ax,3
	push ax
	mov ax,26
	push ax
	call Nameboxes
	mov ax,Names+2
	push ax
	mov ax,3
	push ax
	mov ax,37
	push ax
	call Nameboxes
	mov ax,Names+3
	push ax
	mov ax,3
	push ax
	mov ax,48
	push ax
	call Nameboxes
;second row Names
	mov ax,Names+4
	push ax
	mov ax,8		
	push ax
	mov ax,15		
	push ax
	call Nameboxes
	mov ax,Names+5
	push ax
	mov ax,8		
	push ax
	mov ax,27		
	push ax
	call Nameboxes
	mov ax,Names+6
	push ax
	mov ax,8		
	push ax
	mov ax,38		
	push ax
	call Nameboxes
	mov ax,Names+7
	push ax
	mov ax,8		
	push ax
	mov ax,48		
	push ax
	call Nameboxes	
;third row Names
	mov ax,Names+8
	push ax
	mov ax,13		
	push ax
	mov ax,15		
	push ax
	call Nameboxes
	mov ax,Names+9
	push ax
	mov ax,13		
	push ax
	mov ax,26		
	push ax
	call Nameboxes
	mov ax,Names+10
	push ax
	mov ax,13		
	push ax
	mov ax,37		
	push ax
	call Nameboxes
	mov ax,Names+11
	push ax
	mov ax,13		
	push ax
	mov ax,49		
	push ax
	call Nameboxes
;forth row Names
	mov ax,Names+12
	push ax
	mov ax,18		
	push ax
	mov ax,15		
	push ax
	call Nameboxes
	mov ax,Names+13
	push ax
	mov ax,18		
	push ax
	mov ax,26		
	push ax
	call Nameboxes
	mov ax,Names+14
	push ax
	mov ax,18		
	push ax
	mov ax,37		
	push ax
	call Nameboxes
	mov ax,Names+15
	push ax
	mov ax,18		
	push ax
	mov ax,48		
	push ax
	call Nameboxes	
	
;take input
	 call printturnmsg
	 call read_keyboard
;if input is a
input:
	cmp al,0x61
	jne cmpb
	mov ax,5
	push ax
	mov ax,20
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray],ax
	jmp checkrow1
;if input is b
cmpb:
	cmp al,0x62
	jne cmpc
	mov ax,5
	push ax
	mov ax,31
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+2],ax
	jmp checkrow1
cmpc:
	cmp al,0x63
	jne cmpd
	mov ax,5
	push ax
	mov ax,42
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+4],ax
	jmp checkrow1
cmpd:
	cmp al,0x64
	jne cmpe
	mov ax,5
	push ax
	mov ax,53
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+6],ax
	jmp checkrow1
cmpe:
	cmp al,0x65
	jne cmpf
	mov ax,10
	push ax
	mov ax,20
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+8],ax
	jmp checkrow1
cmpf:
	cmp al,0x66
	jne cmpg
	mov ax,10
	push ax
	mov ax,31
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+10],ax
	jmp checkrow1
cmpg:
	cmp al,0x67
	jne cmph
	mov ax,10
	push ax
	mov ax,42
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+12],ax
	jmp checkrow1
cmph:
	cmp al,0x68
	jne cmpi
	mov ax,10
	push ax
	mov ax,53
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+14],ax
	jmp checkrow1
cmpi:
	cmp al,0x69
	jne cmpj
	mov ax,15
	push ax
	mov ax,20
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+16],ax
	jmp checkrow1
cmpj:
	cmp al,0x6A
	jne cmpk
	mov ax,15
	push ax
	mov ax,31
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+18],ax
	jmp checkrow1
cmpk:
	cmp al,0x6B
	jne cmpl
	mov ax,15
	push ax
	mov ax,42
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+20],ax
	jmp checkrow1
cmpl:
	cmp al,0x6C
	jne cmpm
	mov ax,15
	push ax
	mov ax,53
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+22],ax
	jmp checkrow1
cmpm:
	cmp al,0x6D
	jne cmpn
	mov ax,20
	push ax
	mov ax,20
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+24],ax
	jmp checkrow1
cmpn:
	cmp al,0x6E
	jne cmpo
	mov ax,20
	push ax
	mov ax,31
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+26],ax
	jmp checkrow1
cmpo:
	cmp al,0x6F
	jne cmpp
	mov ax,20
	push ax
	mov ax,42
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+28],ax
	jmp checkrow1
cmpp:
	cmp al,0x70
	jne again
	mov ax,20
	push ax
	mov ax,53
	push ax
	call printsign
	mov ax,[playersign]
	mov [resultArray+30],ax
	jmp checkrow1
	
done:	
	mov ax,0x4c00
	int 21h