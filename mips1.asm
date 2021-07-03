.data 
etiqueta: .asciiz "  *******CONVERSOR DE DIVISAS*******\n"
saltoLinea: .asciiz "\n" 
menu: .asciiz "- Cambio de USD - Dolar Estadounidense a : \n\t 1.EUR - Euro \n\t 2.GBP - Libra Esterlina \n\t 3.COP - Peso colombiano \n\t 4.CAD - Dolar Canadiense \n\t 5.XBT - Bitcoin \n\t 5.ETH - Ethereum"
opcionEtiqueta: .asciiz "Elija una opcion: "
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
	#li $t0,20
	#sll $t0,$t0,2
	#addi $t0, $t0,-1
	#move $a0,$t0
	#li $v0,1
	#syscall
	
	
	
	
	li $v0,10
	syscall