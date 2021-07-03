.data 
etiqueta: .asciiz "  *******CONVERSOR DE DIVISAS*******\n"
saltoLinea: .asciiz "\n" 
menu: .asciiz "- Cambio de USD - Dolar Estadounidense a : \n\t 1.EUR - Euro \n\t 2.GBP - Libra Esterlina \n\t 3.COP - Peso colombiano \n\t 4.CAD - Dolar Canadiense \n\t 5.XBT - Bitcoin \n\t 6.ETH - Ethereum"
opcionEtiqueta: .asciiz "Elija una opcion: "
opcionUsuarioEtiqueta: .asciiz "La opcion que usted escogio corresponde a la siguiente tarifa: "
montoEtiqueta: .asciiz "\n\tCantidad de USD Americanos : "
tarifaEtiqueta : .asciiz "\tIngrese la tarifa proporcionada : "
fout: .asciiz "//Users//oscarlucas7//Conversor_De_Divisas//divisas.txt"
buffer: .space 1000
.text
.globl main


main:
	li $v0, 4
	la $a0, etiqueta
	syscall
	li $v0, 4
	la $a0, saltoLinea
	syscall
	li $v0, 4
	la $a0, menu
	syscall
	li $v0, 4
	la $a0, saltoLinea
	syscall
	li $v0, 4
	la $a0, opcionEtiqueta
	syscall
	li $v0, 5
	syscall
	move $s0, $v0 #Opcion del usuario
	jal abrirArchivo
	move $s1, $v0 #fd
	
	
	move $a3,$s0
	move $a0,$s1
	la $a1, buffer
	jal leerArchivo
	
	move $a0, $s1
	jal cerrarArchivo
	
	
	li $v0, 4
	la $a0, saltoLinea
	syscall
	li $v0, 4
	la $a0, montoEtiqueta
	syscall
	li $v0, 5
	syscall
	move $s2,$v0 #Monto se guarda en $s2
	li $v0, 4
	la $a0, saltoLinea
	syscall
	
	
	li $v0, 4
	la $a0, tarifaEtiqueta
	syscall
	li $v0, 7 #tarifa se guarda en f0
	syscall
	li $v0, 4
	la $a0, saltoLinea
	syscall
	
	li $v0,10 #fin del programa
	syscall
	
	
	
	
	
	
abrirArchivo:
	addi $sp,$sp,-12
	sw $ra, ($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)

	li $v0,13
	la $a0,fout
	la $a1,0 #read: 0, write: 1
	syscall 
	
	lw $ra, ($sp)
	lw $a0,4($sp)
	lw $a1, 8($sp)
	addi $sp,$sp,12
	jr $ra
	
	
cerrarArchivo:
	addi $sp,$sp,-4
	sw $ra, ($sp)
	
	li $v0,16
	syscall 
	
	lw $ra, ($sp)
	addi $sp,$sp,4
	jr $ra
	
	


	
	
leerArchivo:
	addi $sp,$sp,-20
	sw $ra, ($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)	
	sw $s3,16($sp)
	
	
	move $s0,$a3 #opcion de menu
	move $s1,$a0 #fd
	move $s2,$a1 #buffer
	
	li $t0,0 #contador de lineas
	li $s3,10 #\n
	
	li $v0, 4
	la $a0, opcionUsuarioEtiqueta
	syscall
	
	leer:
		
		slt $t1,$t0,$s0
		beq $t1,0, return
		
		li $v0,14
		move $a0,$s1
		la $a1,buffer
		li $a2,1
		syscall
		lb $t1,($s2)
		beq $t1,$s3,sumar
		addi $t2,$s0,-1
		slt $t2,$t0,$t2
		beq $t2,1,leer
		
		li $v0,4
		move $a0,$s2
		move $s5,$s2
		syscall
		j leer
	
	
		sumar:
			addi $t0,$t0,1
			j leer
		
		li $v0, 4
		move $a0,$s5
		syscall
	
	return:
	lw $ra, ($sp)
	lw $s0,4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	
	addi $sp,$sp,20
	jr $ra
	
	
	
	
	
	
