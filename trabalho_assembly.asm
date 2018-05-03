;DUPLA: YAN FERREIRA E JOSÉ OLÍVIO
.386

.model flat,stdcall

option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
msgSaida1 db "Digite um numero N: ",0h
msgSaida2 db "Os N primeiros numeros primos sao: ",0ah,0h

consoleInHandle dword ?
consoleOutHandle dword ?
stringEntrada db 5 dup(?)
entradaConvertida db 5 dup(?)
readCount dword ?
writeCount dword ?
_valor dword ?
_x dword 2
_i dword ?

.code

start:

saida1:
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov consoleOutHandle, eax
invoke WriteConsole, consoleOutHandle, addr msgSaida1, sizeof msgSaida1, addr writeCount, NULL

entrada1:
invoke GetStdHandle, STD_INPUT_HANDLE
mov consoleInHandle, eax
invoke ReadConsole, consoleInHandle, addr stringEntrada, sizeof stringEntrada, addr readCount, 0

mov esi, offset stringEntrada
prox:
     mov al, [esi]
     inc esi
     cmp al, 48 ; Menor que ASCII 48
     jl  feito
     cmp al, 58 ; Menor que ASCII 58
     jl  prox
feito:
     dec esi
     xor al, al
     mov [esi], al

invoke atodw, addr stringEntrada
mov _valor, eax

codigo:

        
        invoke WriteConsole, consoleOutHandle, addr msgSaida2, sizeof msgSaida2, addr writeCount, NULL
        
        jmp whileloop1

whilecloop1:
        mov _i,2
forloop1:  ; for(i=2;i<x;i++)
        
        xor edx, edx
        mov eax, _x
        div  _i ; if(x%i==0) break;
        cmp edx, 0
        je ifaposfor

        inc _i      ; Increment
        mov ebx, _i
        cmp ebx, _x    ; Compare cx to the limit
        jl forloop1   ; Loop while less

ifaposfor: ; if(i==x), se o resto de divisao der igual e eles forem iguais, é pq achamos um primo.
        mov ecx, _i
        cmp ecx, _x 
        jne naoehigual
        
        dec _valor
        invoke dwtoa, _x, addr entradaConvertida
        invoke WriteConsole, consoleOutHandle, addr entradaConvertida, sizeof entradaConvertida, addr writeCount, NULL

naoehigual:

        inc _x

whileloop1: ; while(valor)
 
        mov ebx, _valor
        cmp ebx, 0
        jg whilecloop1


        invoke ExitProcess, 0

end start
