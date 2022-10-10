[org  0x7c00]
[bits 16]

entry:
    ; Disable interrupts and clear direction flag
    cli
    cld

	; Set the A20 line
	in    al, 0x92
	or    al, 2
	out 0x92, al

    ; Clear DS
    xor ax, ax
    mov ds, ax

    ; Load a 32-bit GDT
    lgdt [gdt]

    ; Enable protected mode
	mov eax, cr0
	or  eax, (1 << 0)
	mov cr0, eax
    
    ; Transition to 32-bit mode by setting CS to a protected mode selector
    jmp 0x0018:pm_entry

[bits 32]

