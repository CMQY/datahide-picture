	.file	"datahide.c"
	.text
	.globl	storebyte
	.type	storebyte, @function
storebyte:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -40(%rbp)
	movl	-36(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -1(%rbp)
	movb	$1, -9(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L2
.L8:
	movl	-40(%rbp), %eax
	movslq	%eax, %rdx
	movl	-8(%rbp), %eax
	cltq
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %edx
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	$1431655766, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movzbl	-9(%rbp), %eax
	movzbl	-1(%rbp), %edx
	andl	%edx, %eax
	testb	%al, %al
	jle	.L3
	cmpl	$0, -16(%rbp)
	je	.L6
	cmpl	$1, -16(%rbp)
	jmp	.L6
.L3:
	cmpl	$0, -16(%rbp)
	je	.L6
	cmpl	$1, -16(%rbp)
.L6:
	sarb	-1(%rbp)
	addl	$1, -8(%rbp)
.L2:
	cmpl	$7, -8(%rbp)
	jle	.L8
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	storebyte, .-storebyte
	.section	.rodata
.LC0:
	.string	"open raw pic error!\n"
.LC1:
	.string	"mmap"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jns	.L10
	movl	$.LC0, %edi
	movl	$0, %eax
	call	perror
	movl	$0, %edi
	call	exit
.L10:
	leaq	-56(%rbp), %rcx
	movl	-36(%rbp), %eax
	movl	$4, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	leaq	-60(%rbp), %rcx
	movl	-36(%rbp), %eax
	movl	$4, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	-56(%rbp), %edx
	movl	-60(%rbp), %eax
	imull	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	addl	$8, %eax
	cltq
	movl	-36(%rbp), %edx
	movl	$0, %r9d
	movl	%edx, %r8d
	movl	$1, %ecx
	movl	$3, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	mmap
	movq	%rax, -48(%rbp)
	cmpq	$-1, -48(%rbp)
	jne	.L11
	movl	$.LC1, %edi
	movl	$0, %eax
	call	perror
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$0, %edi
	call	exit
.L11:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -24(%rbp)
	movl	$0, -28(%rbp)
	movq	-80(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -52(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L12
.L16:
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movl	-56(%rbp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movslq	%eax, %rbx
	movq	%rcx, %rax
	movl	$0, %edx
	divq	%rbx
	movq	%rax, %rdx
	movl	-28(%rbp), %eax
	cltq
	cmpq	%rax, %rdx
	jbe	.L13
	movl	-56(%rbp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	cltq
	addq	%rax, -24(%rbp)
	addl	$2, -28(%rbp)
.L13:
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movl	-56(%rbp), %edx
	movl	-60(%rbp), %eax
	imull	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	$1, %eax
	cltq
	cmpq	%rax, %rcx
	jbe	.L14
	jmp	.L15
.L14:
	movl	-56(%rbp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	leal	(%rax,%rdx), %ecx
	movq	-80(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rsi
	movq	-24(%rbp), %rax
	movl	-32(%rbp), %edx
	movq	%rax, %rdi
	call	storebyte
	addq	$8, -24(%rbp)
	addl	$1, -32(%rbp)
.L12:
	movl	-32(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L16
.L15:
	movl	-56(%rbp), %edx
	movl	-60(%rbp), %eax
	imull	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	addl	$8, %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	munmap
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$0, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]"
	.section	.note.GNU-stack,"",@progbits
