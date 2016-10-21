	.syntax unified
	.cpu cortex-a8
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu neon
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.thumb
	.file	"alpha_time.c"
	.text
	.align	2
	.global	alphaBlend_c
	.thumb
	.thumb_func
	.type	alphaBlend_c, %function
alphaBlend_c:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov.i32	d28, #0xffffffff  @ v8qi
	movs	r3, #0
	push	{r4, r5, r6}
.L2:
	adds	r6, r0, r3
	adds	r5, r1, r3
	adds	r4, r2, r3
	vld4.8	{d20-d23}, [r6]
	vld4.8	{d4-d7}, [r5]
	adds	r3, r3, #32
	cmp	r3, #1048576
	vmov.i32	d27, #0xffffffff  @ v8qi
	vmull.u8	q15, d23, d20
	vmull.u8	q8, d23, d21
	vmull.u8	q9, d22, d22
	vsub.i8	d29, d28, d23
	vmov	q10, q15  @ v8hi
	vmlal.u8	q8, d29, d5
	vmlal.u8	q9, d29, d6
	vmlal.u8	q10, d29, d4
	vqshrn.u16	d25, q8, #8
	vqshrn.u16	d26, q9, #8
	vqshrn.u16	d24, q10, #8
	vst4.8	{d24-d27}, [r4]
	bne	.L2
	pop	{r4, r5, r6}
	bx	lr
	.size	alphaBlend_c, .-alphaBlend_c
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #4
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, r0
	sub	sp, sp, #16
	mov	r5, r1
	beq	.L7
	movw	r3, #:lower16:stderr
	movw	r1, #:lower16:.LC0
	movt	r3, #:upper16:stderr
	ldr	r2, [r5]
	ldr	r0, [r3]
	movt	r1, #:upper16:.LC0
	bl	fprintf
	movs	r0, #1
.L8:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L7:
	movw	r1, #:lower16:.LC1
	ldr	r0, [r5, #4]
	movt	r1, #:upper16:.LC1
	bl	fopen
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r7, r0
	ldr	r0, [r5, #8]
	bl	fopen
	movw	r1, #:lower16:.LC2
	movt	r1, #:upper16:.LC2
	mov	r6, r0
	ldr	r0, [r5, #12]
	bl	fopen
	cmp	r6, #0
	it	ne
	cmpne	r7, #0
	mov	r5, r0
	beq	.L9
	cbz	r0, .L9
	movw	r0, #:lower16:backImage
	mov	r2, #512
	mov	r1, #2048
	movt	r0, #:upper16:backImage
	mov	r3, r6
	bl	fread
	cmp	r0, #512
	mov	r2, r0
	beq	.L10
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC3
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC3
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
	bl	fwrite
	movs	r0, #3
	b	.L8
.L9:
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC6
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC6
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #23
	bl	fwrite
	movs	r0, #2
	b	.L8
.L10:
	movw	r0, #:lower16:foreImage
	mov	r1, #2048
	movt	r0, #:upper16:foreImage
	mov	r3, r7
	bl	fread
	cmp	r0, #512
	mov	r8, r0
	beq	.L11
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC4
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC4
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
	bl	fwrite
	mov	r0, r4
	b	.L8
.L11:
	movs	r1, #0
	mov	r0, sp
	bl	gettimeofday
	movw	r0, #:lower16:foreImage
	movw	r1, #:lower16:backImage
	movw	r2, #:lower16:newImage
	movt	r2, #:upper16:newImage
	movt	r0, #:upper16:foreImage
	movt	r1, #:upper16:backImage
	movw	r4, #:lower16:stdout
	bl	alphaBlend_c
	movs	r1, #0
	add	r0, sp, #8
	movt	r4, #:upper16:stdout
	bl	gettimeofday
	ldr	r1, [sp, #8]
	ldr	r0, [sp, #4]
	movw	lr, #16960
	ldr	r2, [sp]
	movt	lr, 15
	ldr	r3, [sp, #12]
	subs	r2, r1, r2
	movw	r1, #:lower16:.LC5
	subs	r3, r3, r0
	movt	r1, #:upper16:.LC5
	ldr	r0, [r4]
	mla	r2, lr, r2, r3
	bl	fprintf
	movw	r0, #:lower16:newImage
	mov	r2, r8
	mov	r1, #2048
	mov	r3, r5
	movt	r0, #:upper16:newImage
	bl	fwrite
	mov	r0, r7
	bl	fclose
	mov	r0, r6
	bl	fclose
	mov	r0, r5
	bl	fclose
	movs	r0, #0
	b	.L8
	.size	main, .-main
	.comm	newImage,1048576,4
	.comm	foreImage,1048576,4
	.comm	backImage,1048576,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Usage:%s foreground background outFile\012\000"
.LC1:
	.ascii	"rb\000"
	.space	1
.LC2:
	.ascii	"wb\000"
	.space	1
.LC3:
	.ascii	"Error with backImage\012\000"
	.space	2
.LC4:
	.ascii	"Error with foreImage\012\000"
	.space	2
.LC5:
	.ascii	"Routine took %ld microseconds\012\000"
	.space	1
.LC6:
	.ascii	"Problem opening a file\012\000"
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
