#########################################################################
# Author: Morapelli Makhosane											#
# Student No: 202003231													#		
# Gmail: makhosanemorapeli02@gmail.com									#				
#																		#
# Reversable-prime-squares												#			
#																		#
#########################################################################

#########################################################################

.data
	newline: .asciiz "\n"
	printheader: .asciiz "\t\t\tHere are the first 10 reverseble primes \n"
	tab:	.asciiz "\t\t\t\t"
	subheader:	.asciiz "Root\t\t\t\tNumber\t\t\t\tReverse\n"
	
.text


main:
		#variable declaration
		addi	$s1,$0,0	#number to be checked
		addi	$s2,$0,0	#count
		addi	$s3,$0,0	#the reverse of the number to be checked
		addi	$s4,$0,0	#the root of the number being checked
		addi	$s5,$0,0	#the root of the reverse 	
		addi	$t1,$0,10	#to help break when count ==10
		addi	$t3,$zero,1	#to be used as my 1 when checking conditions
		
		li		$v0,4
		la		$a0,printheader
		syscall
		li		$v0,4
		la		$a0,subheader
		syscall
		
		for_main:
		#conditions for the loop
		move	$a1,$s1		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		bgez	$a1,if_1
		j	endmain
		##############################

		#if_1 and if_2 are used to check if both the square and reverse are perfect squares theref0re have integer actual roots
		if_1:
		jal	Reverse
		move	$s3,$v1		#store the reverse into its variable
		move	$v1,$zero	#set v1 to zero as it will be used to return in other functions
		move	$a1,$s1		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	isPerfect
		move	$t2,$v0		#store the returned condition value
		move	$v0,$zero	#set v0 to zero as it will be used to return the conditional values in other functions
		beq	$t2,$t3,if_2
		j	loop_end
		if_2:
		move	$a1,$s3		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	isPerfect
		move	$t2,$v0		#store the returned condition value
		move	$v0,$zero	#set v0 to zero as it will be used to return the conditional values in other functions
		beq	$t2,$t3,number_is_a_perfectsquare
		j	loop_end
		number_is_a_perfectsquare:
		move	$a1,$s1		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	Square_root
		move	$s4,$v1
		move	$v1,$zero	#set v1 to zero as it will be used to return in other functions
		move	$a1,$s3		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	Square_root
		move	$s5,$v1
		move	$v1,$zero	#set v1 to zero as it will be used to return in other functions
		move	$a1,$s4		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	primechecker
		move	$t2,$v0		#store the returned condition value
		move	$v0,$zero	#set v0 to zero as it will be used to return the conditional values in other functions
		beq	$t2,$t3,if_4
		j	loop_end
		if_4:
		move	$a1,$s5		#move the wanted variable to be treated as agument into the a register...this is similer to the auto pass by value process in normal compilers
		jal	primechecker
		move	$t2,$v0		#store the returned condition value
		move	$v0,$zero	#set v0 to zero as it will be used to return the conditional values in other functions
		beq	$t2,$t3,if_5		#if_5
		j	loop_end
		if_5:
		bne	$s1,$s3,final_execution 	#checks if our number k is not a palindrome
		j	loop_end
		final_execution:
		li		$v0,1
		move	$a0,$s4
		syscall
		li		$v0,4
		la		$a0,tab
		syscall
		li	$v0,1
		add	$a0,$zero,$s1
		syscall
		li		$v0,4
		la		$a0,tab
		syscall
		li		$v0,1
		move	$a0,$s3
		syscall
		li	$v0,4
		la	$a0,newline
		syscall
		addi	$s2,$s2,1
		beq	$s2,$t1,endmain
		j	loop_end	
		loop_end:
		addi	$s1,$s1,1	#increment the number to be checked...thus check the next integer
		#set all the variables to be used in the loop back to zero as to allow for the same tests to be run on a new number of k
		move	$v1,$zero
		move	$v0,$zero
		move	$a1,$zero
		move	$t2,$zero
		move	$s3,$zero
		move	$v0,$zero
		j	for_main

		endmain:
				
			#end of main
			li	$v0, 10
			syscall
##########################################################	
##			functions			##
##########################################################
Reverse:
addi	$sp,$sp,-20
sw	$t1,0($sp)
sw	$t2,4($sp)	#r
sw	$t3,8($sp)
sw	$t4,16($sp)
#set everything to zero  
move	$t1,$0
move	$t2,$0
move	$t3,$0
move	$t4,$0
move	$t5,$0
addi	$t3,$0,10
L1:
beqz	$a1,end
div	$a1,$t3
mfhi	$t2
mul	$t4,$t1,$t3
add	$t1,$t4,$t2
div	$a1,$t3
mflo	$a1
j	L1

end:
add	$v1,$0,$t1	#add to v register inorder to return value


lw	$t1,0($sp)
lw	$t2,4($sp)	
lw	$t3,8($sp)
lw	$t4,16($sp)		
addi	$sp,$sp,20
jr	$ra
#########################################################
#							#
#########################################################
primechecker:
addi	$sp,$sp,-24
sw	$t1,0($sp)
sw	$t2,4($sp)	#isTrue
sw	$t3,8($sp)
sw	$t4,16($sp)
sw	$t5,20($sp)
#set everything to zero
move	$t1,$0
move	$t2,$0
move	$t3,$0
move	$t4,$0
move	$t5,$0
addi	$t1,$0,1
addi	$t2,$0,1
addi	$t3,$0,2	#i	

beqz	$a1,return0
beq	$a1,$t1,return0
div	$a1,$t3
mflo	$t4
j	for	

for:
ble	$t3,$t4,L2
j	end2
L2:	
div	$a1,$t3
mfhi	$t5
j	if_p
if_p:
beqz	$t5,return0
j	loop_p
loop_p:
addi	$t3,$t3,1
move	$t5,$zero
j	for

return0:
move	$t2,$0
j	end2
end2:
move	$v0,$t2		#add to v register inorder to return value
lw	$t1,0($sp)
lw	$t2,4($sp)	#isTrue
lw	$t3,8($sp)
lw	$t4,16($sp)
lw	$t5,20($sp)
addi	$sp,$sp,24
jr	$ra
#########################################################
							#
#########################################################	
isPerfect:
addi	$sp,$sp,-24
sw	$t1,0($sp)	#i
sw	$t2,4($sp)	
sw	$t3,8($sp)
sw	$t4,16($sp)
sw	$t5,20($sp)
#set everything to zero
move	$t1,$0
move	$t2,$0
move	$t3,$0
move	$t4,$0
move	$t5,$0
move	$t6,$0
########################
addi	$t1,$0,1	#i
For1:
mul	$t2,$t1,$t1
ble	$t2,$a1,L3
j	return_false
L3:
div	$a1,$t1
mfhi	$t4
mflo	$t5

beqz	$t4,if1
j	loopend	
if1:
beq	$t5,$t1,return_true
j	loopend
return_true:
addi	$t6,$0,1
j	end4
loopend:
addi	$t1,$t1,1
j	For1
return_false:
addi	$t6,$0,0
j	end4
end4:
add	$v0,$0,$t6  	#add to v register inorder to return value

lw	$t1,0($sp)
lw	$t2,4($sp)	
lw	$t3,8($sp)
lw	$t4,16($sp)
lw	$t5,20($sp)
addi	$sp,$sp,24
jr	$ra	
###########################################################################
# A new necessary function to implement since Mips doesnot have libraries #
###########################################################################
Square_root:
addi	$sp,$sp,-24
sw	$a1,12($sp)	#value
sw	$t1,0($sp)	#sqroot
sw	$t2,4($sp)	#counter	
sw	$t3,8($sp)	
sw	$t4,16($sp)
sw	$t5,20($sp)
#set everything to zero
move	$t1,$0
move	$t2,$0
move	$t3,$0
move	$t4,$0
move	$t5,$0
########################
move	$v0,$zero
addi	$t1,$0,1
addi	$t2,$0,1
beqz	$a1,return_value
beq	$a1,$t1,return_value
while2:
ble	$t1,$a1,L4
j	output
L4:
addi	$t2,$t2,1
mult	$t2,$t2
mflo	$t1
j	while2
output:
addi	$t7,$t2,-1
add	$v1,$0,$t7
j	end5
return_value:
move	$t7,$a1
j	end5
end5:
add	$v1,$0,$t7   #add to v register inorder to return value
lw	$t1,0($sp)
lw	$t2,4($sp)	
lw	$t3,8($sp)
lw	$t4,16($sp)
lw	$t5,20($sp)
addi	$sp,$sp,24
jr	$ra		
##########################################################################
##				End of code												##
##########################################################################
