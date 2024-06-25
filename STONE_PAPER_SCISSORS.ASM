%include "mikedev.inc"  ; Assuming an include file for OS functions

; Load Program
ORG 32768

start:
  call os_hide_cursor
  call os_clear_screen
  
  mov si, wlcm_msg
  call os_print_string
  call os_print_newline
  
  mov si, wlcm_msg2
  call os_print_string
  call os_print_newline
  
  mov dl, 0
  mov dh, 0
  call looper


looper: 

  mov si, your_score
  call os_print_string
  call os_print_space
  mov al,dl
  mov ah,0
  call os_int_to_string
  mov si, ax
  call os_print_string
  call os_print_newline
  mov si, comp_score
  call os_print_string
  call os_print_space
  mov al,dh
  mov ah,0
  call os_int_to_string
  mov si, ax
  call os_print_string
  
  call os_print_newline
  
  cmp dl, 5
  je you_win
  cmp dh, 5
  je comp_win
  
  
  ; Display prompt message
  mov si, input_msg
  call os_print_string
  call os_print_newline

  ; Get user input
  mov ax, user_string
  mov bx, 255  ; Maximum number of characters
  call os_input_string
  call os_print_newline
  
  

  ; Check user input
  mov cx, 3       ; Length of comparison strings
  mov ax, user_string

  ; Compare with "1"
  mov si,ax
  call os_string_to_int
  
  cmp ax, 1
  je display_stone

  ; Compare with "2"
  mov ax, user_string
  mov si,ax
  call os_string_to_int
  
  cmp ax, 2
  je display_paper

  ; Compare with "3"
  mov ax, user_string
  mov si,ax
  call os_string_to_int
  
  cmp ax, 3
  je display_scissors
  
  cmp ax, 3
  jg display_invalid
  
  
  mov si, comp_message
  call os_print_string
  call computer_turn
  jmp end_program
  

display_invalid:
  ; If not 1, 2, or 3, print "Invalid string"
  mov si, invalid_msg
  call os_print_string
  call os_print_newline
  jmp end_program



display_stone:
  mov di, 0000
  mov [di], ax
  mov si, stone_icon
  call os_print_string
  call os_print_newline
  jmp computer_turn

display_paper:
  mov di, 0000
  mov [di], ax
  mov si, paper_icon
  call os_print_string
  call os_print_newline

  jmp computer_turn

display_scissors:
  mov di, 0000
  mov [di], ax
  mov si, scissors_icon
  call os_print_newline

  jmp computer_turn
  
 display_stone_c:
  mov si, stone_icon
  call os_print_string
  call os_print_newline
  
  mov si, 0000
  mov ax, [si]
  cmp ax, 1
  je null
  
  cmp ax, 2
  je you_inc
  
  cmp ax, 3
  je comp_inc
  
  

  
display_paper_c:
  mov si, paper_icon
  call os_print_string
  call os_print_newline
  
  mov si, 0000
  mov ax, [si]
  cmp ax, 1
  je comp_inc
  
  cmp ax, 2
  je null
  
  cmp ax, 3
  je you_inc

display_scissors_c:
  mov si, scissors_icon
  call os_print_newline

  mov si, 0000
  mov ax, [si]
  cmp ax, 1
  je you_inc
  
  cmp ax, 2
  je comp_inc
  
  cmp ax, 3
  je null
  
null: 
  jmp looper 
you_inc:
  inc dl
  jmp looper
  
comp_inc:
  inc dh
  jmp looper  


you_win:
  mov si, you_win_msg
  call os_print_string
  jmp end_program
  
comp_win:
  mov si, comp_win_msg
  call os_print_string
  jmp end_program

  
computer_turn:

  mov si, comp_message
  call os_print_string
  call os_print_newline
  ; Get a random number between 1 and 3
  mov ax, 1    ; Low value
  mov bx, 3    ; High value
  call os_get_random
  
  cmp cx, 1
  jle display_stone_c
  
  cmp cx, 2
  je display_paper_c
  
  cmp cx, 3
  jge display_scissors_c

  

end_program:
  ; End program
  call os_show_cursor
  ret

; Variables
user_string     db 256 dup(0)

; Messages;
comp_message    db 'computer choice', 0
input_msg       db 'Enter your choice (1-Stone, 2-Paper, 3-Scissors):', 0
invalid_msg     db 'Invalid choice', 0

you_win_msg     db 'YOU WIN', 0
comp_win_msg    db 'COMPUTER WINS', 0

; Icons
stone_icon      db 'Stone', 0
paper_icon      db 'Paper', 0
scissors_icon   db 'Scissors', 0

your_score      db 'your score:', 0
comp_score      db 'computer score:', 0

;welcome message
wlcm_msg        db '------------WELCOME TO STONE PAPER SCISSORS GAME-------------', 0
wlcm_msg2       db 'You will play against the computer and the one to score 5 points win', 0




; End Program
