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
	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	alphaBlend_c
	.thumb
	.thumb_func
	.type	alphaBlend_c, %function
alphaBlend_c:
.LFB1912:
	.file 1 "main.c"
	.loc 1 25 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.LVL0:
.LBB36:
.LBB37:
	.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/arm_neon.h"
	.loc 2 5502 0
	vmov.i32	d22, #0xffffffff  @ v8qi
.LBE37:
.LBE36:
	.loc 1 30 0
	movs	r3, #0
	.loc 1 25 0
	push	{r4, r5, r6}
	.cfi_def_cfa_offset 12
	.cfi_offset 4, -12
	.cfi_offset 5, -8
	.cfi_offset 6, -4
.LVL1:
.L2:
.LBB38:
.LBB39:
	.loc 2 10674 0 discriminator 3
	adds	r6, r0, r3
.LVL2:
.LBE39:
.LBE38:
.LBB41:
.LBB42:
	adds	r5, r1, r3
.LBE42:
.LBE41:
.LBB44:
.LBB45:
	.loc 2 11073 0 discriminator 3
	adds	r4, r2, r3
.LBE45:
.LBE44:
.LBB47:
.LBB40:
	.loc 2 10674 0 discriminator 3
	vld4.8	{d24-d27}, [r6]
.LVL3:
.LBE40:
.LBE47:
	.loc 1 30 0 discriminator 3
	adds	r3, r3, #32
.LVL4:
	cmp	r3, #1048576
	vmov.i32	d31, #0xffffffff  @ v8qi
.LBB48:
.LBB49:
	.loc 2 1114 0 discriminator 3
	vmull.u8	q10, d27, d24
.LBE49:
.LBE48:
.LBB50:
.LBB43:
	.loc 2 10674 0 discriminator 3
	vld4.8	{d4-d7}, [r5]
.LVL5:
.LBE43:
.LBE50:
.LBB51:
.LBB52:
	.loc 2 1114 0 discriminator 3
	vmull.u8	q9, d27, d25
.LBE52:
.LBE51:
.LBB53:
.LBB54:
	vmull.u8	q8, d27, d26
.LBE54:
.LBE53:
.LBB55:
.LBB56:
	.loc 2 1550 0 discriminator 3
	vsub.i8	d23, d22, d27
.LVL6:
.LBE56:
.LBE55:
.LBB57:
.LBB58:
	.loc 2 1252 0 discriminator 3
	vmlal.u8	q10, d23, d4
.LVL7:
.LBE58:
.LBE57:
.LBB59:
.LBB60:
	vmlal.u8	q9, d23, d5
.LBE60:
.LBE59:
.LBB61:
.LBB62:
	vmlal.u8	q8, d23, d6
.LBE62:
.LBE61:
.LBB63:
.LBB64:
	.loc 2 3662 0 discriminator 3
	vshr.u16	q10, q10, #8
.LVL8:
.LBE64:
.LBE63:
.LBB65:
.LBB66:
	vshr.u16	q9, q9, #8
.LVL9:
.LBE66:
.LBE65:
.LBB67:
.LBB68:
	vshr.u16	q8, q8, #8
.LVL10:
	vmovn.i16	d28, q10
.LVL11:
	vmovn.i16	d29, q9
.LVL12:
	vmovn.i16	d30, q8
.LVL13:
.LBE68:
.LBE67:
.LBB69:
.LBB46:
	.loc 2 11073 0 discriminator 3
	vst4.8	{d28-d31}, [r4]
.LBE46:
.LBE69:
	.loc 1 30 0 discriminator 3
	bne	.L2
	.loc 1 55 0
	pop	{r4, r5, r6}
	.cfi_restore 6
	.cfi_restore 5
	.cfi_restore 4
	.cfi_def_cfa_offset 0
.LVL14:
	bx	lr
	.cfi_endproc
.LFE1912:
	.size	alphaBlend_c, .-alphaBlend_c
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.thumb
	.thumb_func
	.type	main, %function
main:
.LFB1913:
	.loc 1 58 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL15:
	.loc 1 63 0
	cmp	r0, #4
	.loc 1 58 0
	push	{r4, r5, r6, r7, r8, lr}
	.cfi_def_cfa_offset 24
	.cfi_offset 4, -24
	.cfi_offset 5, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
	.cfi_offset 8, -8
	.cfi_offset 14, -4
	mov	r4, r0
	sub	sp, sp, #16
	.cfi_def_cfa_offset 40
	.loc 1 58 0
	mov	r5, r1
	.loc 1 63 0
	beq	.L7
	.loc 1 64 0
	movw	r3, #:lower16:stderr
	movw	r1, #:lower16:.LC0
.LVL16:
	movt	r3, #:upper16:stderr
	ldr	r2, [r5]
	ldr	r0, [r3]
.LVL17:
	movt	r1, #:upper16:.LC0
	bl	fprintf
.LVL18:
	.loc 1 65 0
	movs	r0, #1
.LVL19:
.L8:
	.loc 1 95 0
	add	sp, sp, #16
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.LVL20:
.L7:
	.cfi_restore_state
	.loc 1 67 0
	movw	r1, #:lower16:.LC1
.LVL21:
	ldr	r0, [r5, #4]
.LVL22:
	movt	r1, #:upper16:.LC1
	bl	fopen
.LVL23:
	.loc 1 68 0
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	.loc 1 67 0
	mov	r7, r0
.LVL24:
	.loc 1 68 0
	ldr	r0, [r5, #8]
.LVL25:
	bl	fopen
.LVL26:
	.loc 1 69 0
	movw	r1, #:lower16:.LC2
	movt	r1, #:upper16:.LC2
	.loc 1 68 0
	mov	r6, r0
.LVL27:
	.loc 1 69 0
	ldr	r0, [r5, #12]
.LVL28:
	bl	fopen
.LVL29:
	.loc 1 71 0
	cmp	r6, #0
	it	ne
	cmpne	r7, #0
	.loc 1 69 0
	mov	r5, r0
.LVL30:
	.loc 1 71 0
	beq	.L9
	cbz	r0, .L9
	.loc 1 72 0
	movw	r0, #:lower16:backImage
.LVL31:
	mov	r2, #512
	mov	r1, #2048
	movt	r0, #:upper16:backImage
	mov	r3, r6
	bl	fread
.LVL32:
	.loc 1 73 0
	cmp	r0, #512
	.loc 1 72 0
	mov	r2, r0
.LVL33:
	.loc 1 73 0
	beq	.L10
	.loc 1 74 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC3
.LVL34:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC3
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
.LVL35:
	bl	fwrite
.LVL36:
	.loc 1 75 0
	movs	r0, #3
	b	.L8
.LVL37:
.L9:
	.loc 1 93 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC6
.LVL38:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC6
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #23
	bl	fwrite
.LVL39:
	.loc 1 94 0
	movs	r0, #2
	b	.L8
.LVL40:
.L10:
	.loc 1 77 0
	movw	r0, #:lower16:foreImage
.LVL41:
	mov	r1, #2048
	movt	r0, #:upper16:foreImage
	mov	r3, r7
	bl	fread
.LVL42:
	.loc 1 78 0
	cmp	r0, #512
	.loc 1 77 0
	mov	r8, r0
.LVL43:
	.loc 1 78 0
	beq	.L11
	.loc 1 79 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC4
.LVL44:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC4
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
	bl	fwrite
.LVL45:
	.loc 1 80 0
	mov	r0, r4
	b	.L8
.LVL46:
.L11:
	.loc 1 82 0
	movs	r1, #0
	mov	r0, sp
.LVL47:
	bl	gettimeofday
.LVL48:
	.loc 1 83 0
	movw	r0, #:lower16:foreImage
	movw	r1, #:lower16:backImage
	movw	r2, #:lower16:newImage
	movt	r2, #:upper16:newImage
	movt	r0, #:upper16:foreImage
	movt	r1, #:upper16:backImage
	bl	alphaBlend_c
.LVL49:
	.loc 1 85 0
	movs	r1, #0
	add	r0, sp, #8
	bl	gettimeofday
.LVL50:
	.loc 1 86 0
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #12]
	movw	r0, #:lower16:stdout
	movt	r0, #:upper16:stdout
	movw	r1, #:lower16:.LC5
	subs	r2, r2, r3
	movt	r1, #:upper16:.LC5
	ldr	r0, [r0]
	bl	fprintf
.LVL51:
	.loc 1 87 0
	movw	r0, #:lower16:newImage
	mov	r2, r8
	mov	r1, #2048
	mov	r3, r5
	movt	r0, #:upper16:newImage
	bl	fwrite
.LVL52:
	.loc 1 88 0
	mov	r0, r7
	bl	fclose
.LVL53:
	.loc 1 89 0
	mov	r0, r6
	bl	fclose
.LVL54:
	.loc 1 90 0
	mov	r0, r5
	bl	fclose
.LVL55:
	.loc 1 91 0
	movs	r0, #0
	b	.L8
	.cfi_endproc
.LFE1913:
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
	.ascii	"Routine took %d microseconds\012\000"
	.space	2
.LC6:
	.ascii	"Problem opening a file\012\000"
	.text
.Letext0:
	.file 3 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/stddef.h"
	.file 4 "/usr/include/arm-linux-gnueabihf/bits/types.h"
	.file 5 "/usr/include/stdio.h"
	.file 6 "/usr/include/libio.h"
	.file 7 "/usr/include/stdint.h"
	.file 8 "/usr/include/arm-linux-gnueabihf/bits/time.h"
	.file 9 "/usr/include/arm-linux-gnueabihf/sys/time.h"
	.file 10 "<built-in>"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xc66
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF113
	.byte	0x1
	.4byte	.LASF114
	.4byte	.LASF115
	.4byte	.Ldebug_ranges0+0x48
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x4
	.byte	0x4
	.4byte	0x40
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF2
	.uleb128 0x5
	.4byte	.LASF11
	.byte	0x3
	.byte	0xd4
	.4byte	0x52
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x5
	.4byte	.LASF12
	.byte	0x4
	.byte	0x37
	.4byte	0x7c
	.uleb128 0x5
	.4byte	.LASF13
	.byte	0x4
	.byte	0x83
	.4byte	0xa0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF14
	.uleb128 0x5
	.4byte	.LASF15
	.byte	0x4
	.byte	0x84
	.4byte	0x8a
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF16
	.uleb128 0x5
	.4byte	.LASF17
	.byte	0x4
	.byte	0x8b
	.4byte	0xa0
	.uleb128 0x5
	.4byte	.LASF18
	.byte	0x4
	.byte	0x8d
	.4byte	0xa0
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x5
	.4byte	.LASF19
	.byte	0x5
	.byte	0x30
	.4byte	0xdc
	.uleb128 0x7
	.4byte	.LASF49
	.byte	0x98
	.byte	0x6
	.byte	0xf5
	.4byte	0x25c
	.uleb128 0x8
	.4byte	.LASF20
	.byte	0x6
	.byte	0xf6
	.4byte	0x33
	.byte	0
	.uleb128 0x8
	.4byte	.LASF21
	.byte	0x6
	.byte	0xfb
	.4byte	0x3a
	.byte	0x4
	.uleb128 0x8
	.4byte	.LASF22
	.byte	0x6
	.byte	0xfc
	.4byte	0x3a
	.byte	0x8
	.uleb128 0x8
	.4byte	.LASF23
	.byte	0x6
	.byte	0xfd
	.4byte	0x3a
	.byte	0xc
	.uleb128 0x8
	.4byte	.LASF24
	.byte	0x6
	.byte	0xfe
	.4byte	0x3a
	.byte	0x10
	.uleb128 0x8
	.4byte	.LASF25
	.byte	0x6
	.byte	0xff
	.4byte	0x3a
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x6
	.2byte	0x100
	.4byte	0x3a
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x6
	.2byte	0x101
	.4byte	0x3a
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x6
	.2byte	0x102
	.4byte	0x3a
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x6
	.2byte	0x104
	.4byte	0x3a
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x6
	.2byte	0x105
	.4byte	0x3a
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x6
	.2byte	0x106
	.4byte	0x3a
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x6
	.2byte	0x108
	.4byte	0x294
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x6
	.2byte	0x10a
	.4byte	0x29a
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x6
	.2byte	0x10c
	.4byte	0x33
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x6
	.2byte	0x110
	.4byte	0x33
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x6
	.2byte	0x112
	.4byte	0x95
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x6
	.2byte	0x116
	.4byte	0x60
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x6
	.2byte	0x117
	.4byte	0x6e
	.byte	0x46
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x6
	.2byte	0x118
	.4byte	0x2a0
	.byte	0x47
	.uleb128 0x9
	.4byte	.LASF40
	.byte	0x6
	.2byte	0x11c
	.4byte	0x2b0
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF41
	.byte	0x6
	.2byte	0x125
	.4byte	0xa7
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF42
	.byte	0x6
	.2byte	0x12e
	.4byte	0xcf
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF43
	.byte	0x6
	.2byte	0x12f
	.4byte	0xcf
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF44
	.byte	0x6
	.2byte	0x130
	.4byte	0xcf
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF45
	.byte	0x6
	.2byte	0x131
	.4byte	0xcf
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF46
	.byte	0x6
	.2byte	0x132
	.4byte	0x47
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF47
	.byte	0x6
	.2byte	0x134
	.4byte	0x33
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF48
	.byte	0x6
	.2byte	0x136
	.4byte	0x2b6
	.byte	0x70
	.byte	0
	.uleb128 0xa
	.4byte	.LASF116
	.byte	0x6
	.byte	0x9a
	.uleb128 0x7
	.4byte	.LASF50
	.byte	0xc
	.byte	0x6
	.byte	0xa0
	.4byte	0x294
	.uleb128 0x8
	.4byte	.LASF51
	.byte	0x6
	.byte	0xa1
	.4byte	0x294
	.byte	0
	.uleb128 0x8
	.4byte	.LASF52
	.byte	0x6
	.byte	0xa2
	.4byte	0x29a
	.byte	0x4
	.uleb128 0x8
	.4byte	.LASF53
	.byte	0x6
	.byte	0xa6
	.4byte	0x33
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x263
	.uleb128 0x4
	.byte	0x4
	.4byte	0xdc
	.uleb128 0xb
	.4byte	0x40
	.4byte	0x2b0
	.uleb128 0xc
	.4byte	0xb2
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x25c
	.uleb128 0xb
	.4byte	0x40
	.4byte	0x2c6
	.uleb128 0xc
	.4byte	0xb2
	.byte	0x27
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x2cc
	.uleb128 0xd
	.4byte	0x40
	.uleb128 0x5
	.4byte	.LASF54
	.byte	0x7
	.byte	0x30
	.4byte	0x59
	.uleb128 0x7
	.4byte	.LASF55
	.byte	0x8
	.byte	0x8
	.byte	0x1e
	.4byte	0x301
	.uleb128 0x8
	.4byte	.LASF56
	.byte	0x8
	.byte	0x20
	.4byte	0xb9
	.byte	0
	.uleb128 0x8
	.4byte	.LASF57
	.byte	0x8
	.byte	0x21
	.4byte	0xc4
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x307
	.uleb128 0xe
	.uleb128 0xd
	.4byte	0x33
	.uleb128 0x7
	.4byte	.LASF58
	.byte	0x8
	.byte	0x9
	.byte	0x37
	.4byte	0x332
	.uleb128 0x8
	.4byte	.LASF59
	.byte	0x9
	.byte	0x39
	.4byte	0x33
	.byte	0
	.uleb128 0x8
	.4byte	.LASF60
	.byte	0x9
	.byte	0x3a
	.4byte	0x33
	.byte	0x4
	.byte	0
	.uleb128 0x5
	.4byte	.LASF61
	.byte	0x2
	.byte	0x28
	.4byte	0x33d
	.uleb128 0xf
	.4byte	0x349
	.4byte	0x349
	.uleb128 0x10
	.byte	0x7
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x5
	.4byte	.LASF62
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF63
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF64
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF65
	.uleb128 0x2
	.byte	0x2
	.byte	0x4
	.4byte	.LASF66
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF67
	.uleb128 0x2
	.byte	0x1
	.byte	0x5
	.4byte	.LASF68
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF69
	.uleb128 0x5
	.4byte	.LASF70
	.byte	0x2
	.byte	0x33
	.4byte	0x38c
	.uleb128 0xf
	.4byte	0x398
	.4byte	0x398
	.uleb128 0x10
	.byte	0x7
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x7
	.4byte	.LASF71
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF72
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF73
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF74
	.uleb128 0x5
	.4byte	.LASF75
	.byte	0x2
	.byte	0x38
	.4byte	0x3bf
	.uleb128 0xf
	.4byte	0x350
	.4byte	0x3cb
	.uleb128 0x10
	.byte	0x7
	.byte	0
	.uleb128 0x5
	.4byte	.LASF76
	.byte	0x2
	.byte	0x42
	.4byte	0x3d6
	.uleb128 0xf
	.4byte	0x39f
	.4byte	0x3e2
	.uleb128 0x10
	.byte	0x7
	.byte	0
	.uleb128 0x11
	.4byte	.LASF77
	.byte	0x20
	.byte	0x2
	.2byte	0x172
	.4byte	0x3fd
	.uleb128 0x12
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x174
	.4byte	0x3fd
	.byte	0
	.byte	0
	.uleb128 0xb
	.4byte	0x381
	.4byte	0x40d
	.uleb128 0xc
	.4byte	0xb2
	.byte	0x3
	.byte	0
	.uleb128 0x13
	.4byte	.LASF77
	.byte	0x2
	.2byte	0x175
	.4byte	0x3e2
	.uleb128 0x14
	.4byte	.LASF79
	.byte	0x2
	.2byte	0x29af
	.4byte	0x40d
	.byte	0x3
	.4byte	0x465
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x29af
	.4byte	0x465
	.uleb128 0x16
	.byte	0x20
	.byte	0x2
	.2byte	0x29b1
	.4byte	0x458
	.uleb128 0x17
	.ascii	"__i\000"
	.byte	0x2
	.2byte	0x29b1
	.4byte	0x40d
	.uleb128 0x17
	.ascii	"__o\000"
	.byte	0x2
	.2byte	0x29b1
	.4byte	0x470
	.byte	0
	.uleb128 0x18
	.4byte	.LASF86
	.byte	0x2
	.2byte	0x29b1
	.4byte	0x436
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x46b
	.uleb128 0xd
	.4byte	0x2d1
	.uleb128 0x2
	.byte	0x20
	.byte	0x5
	.4byte	.LASF78
	.uleb128 0x14
	.4byte	.LASF80
	.byte	0x2
	.2byte	0x157c
	.4byte	0x381
	.byte	0x3
	.4byte	0x495
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x157c
	.4byte	0x2d1
	.byte	0
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x2
	.2byte	0x60c
	.4byte	0x381
	.byte	0x3
	.4byte	0x4bf
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x60c
	.4byte	0x381
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x2
	.2byte	0x60c
	.4byte	0x381
	.byte	0
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x2
	.2byte	0x458
	.4byte	0x3cb
	.byte	0x3
	.4byte	0x4e9
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x458
	.4byte	0x381
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x2
	.2byte	0x458
	.4byte	0x381
	.byte	0
	.uleb128 0x14
	.4byte	.LASF83
	.byte	0x2
	.2byte	0x4e2
	.4byte	0x3cb
	.byte	0x3
	.4byte	0x51f
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x4e2
	.4byte	0x3cb
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x2
	.2byte	0x4e2
	.4byte	0x381
	.uleb128 0x15
	.ascii	"__c\000"
	.byte	0x2
	.2byte	0x4e2
	.4byte	0x381
	.byte	0
	.uleb128 0x14
	.4byte	.LASF84
	.byte	0x2
	.2byte	0xe4c
	.4byte	0x3cb
	.byte	0x3
	.4byte	0x549
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0xe4c
	.4byte	0x3cb
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x2
	.2byte	0xe4c
	.4byte	0x308
	.byte	0
	.uleb128 0x14
	.4byte	.LASF85
	.byte	0x2
	.2byte	0x1870
	.4byte	0x381
	.byte	0x3
	.4byte	0x567
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x1870
	.4byte	0x3cb
	.byte	0
	.uleb128 0x19
	.4byte	.LASF117
	.byte	0x2
	.2byte	0x2b3e
	.byte	0x3
	.4byte	0x5bb
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x2
	.2byte	0x2b3e
	.4byte	0x5bb
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x2
	.2byte	0x2b3e
	.4byte	0x40d
	.uleb128 0x16
	.byte	0x20
	.byte	0x2
	.2byte	0x2b40
	.4byte	0x5ae
	.uleb128 0x17
	.ascii	"__i\000"
	.byte	0x2
	.2byte	0x2b40
	.4byte	0x40d
	.uleb128 0x17
	.ascii	"__o\000"
	.byte	0x2
	.2byte	0x2b40
	.4byte	0x470
	.byte	0
	.uleb128 0x18
	.4byte	.LASF87
	.byte	0x2
	.2byte	0x2b40
	.4byte	0x58c
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x2d1
	.uleb128 0x1a
	.4byte	.LASF118
	.byte	0x1
	.byte	0x18
	.4byte	.LFB1912
	.4byte	.LFE1912-.LFB1912
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x8a4
	.uleb128 0x1b
	.4byte	.LASF88
	.byte	0x1
	.byte	0x18
	.4byte	0x465
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1b
	.4byte	.LASF89
	.byte	0x1
	.byte	0x18
	.4byte	0x465
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1b
	.4byte	.LASF90
	.byte	0x1
	.byte	0x18
	.4byte	0x5bb
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1c
	.ascii	"fg\000"
	.byte	0x1
	.byte	0x1a
	.4byte	0x40d
	.4byte	.LLST0
	.uleb128 0x1d
	.ascii	"bg\000"
	.byte	0x1
	.byte	0x1a
	.4byte	0x40d
	.uleb128 0x12
	.byte	0x90
	.uleb128 0x48
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x49
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x4a
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x4b
	.byte	0x93
	.uleb128 0x4
	.byte	0x93
	.uleb128 0x10
	.uleb128 0x1c
	.ascii	"ds\000"
	.byte	0x1
	.byte	0x1a
	.4byte	0x40d
	.4byte	.LLST1
	.uleb128 0x1e
	.4byte	.LASF91
	.byte	0x1
	.byte	0x1b
	.4byte	0x381
	.uleb128 0x1e
	.4byte	.LASF92
	.byte	0x1
	.byte	0x1c
	.4byte	0x3cb
	.uleb128 0x1f
	.4byte	.LASF93
	.byte	0x1
	.byte	0x1d
	.4byte	0x33
	.4byte	.LLST2
	.uleb128 0x20
	.4byte	0x477
	.4byte	.LBB36
	.4byte	.LBE36-.LBB36
	.byte	0x1
	.byte	0x22
	.4byte	0x675
	.uleb128 0x21
	.4byte	0x488
	.sleb128 -1
	.byte	0
	.uleb128 0x22
	.4byte	0x419
	.4byte	.LBB38
	.4byte	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0x20
	.4byte	0x69d
	.uleb128 0x23
	.4byte	0x42a
	.4byte	.LLST3
	.uleb128 0x24
	.4byte	.Ldebug_ranges0+0
	.uleb128 0x25
	.4byte	0x458
	.byte	0
	.byte	0
	.uleb128 0x22
	.4byte	0x419
	.4byte	.LBB41
	.4byte	.Ldebug_ranges0+0x18
	.byte	0x1
	.byte	0x21
	.4byte	0x6c1
	.uleb128 0x26
	.4byte	0x42a
	.uleb128 0x24
	.4byte	.Ldebug_ranges0+0x18
	.uleb128 0x25
	.4byte	0x458
	.byte	0
	.byte	0
	.uleb128 0x22
	.4byte	0x567
	.4byte	.LBB44
	.4byte	.Ldebug_ranges0+0x30
	.byte	0x1
	.byte	0x35
	.4byte	0x714
	.uleb128 0x27
	.4byte	0x580
	.uleb128 0x14
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x26
	.4byte	0x574
	.uleb128 0x24
	.4byte	.Ldebug_ranges0+0x30
	.uleb128 0x28
	.4byte	0x5ae
	.uleb128 0x14
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x20
	.4byte	0x4bf
	.4byte	.LBB48
	.4byte	.LBE48-.LBB48
	.byte	0x1
	.byte	0x26
	.4byte	0x73e
	.uleb128 0x27
	.4byte	0x4dc
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x118
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x27
	.4byte	0x4d0
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x11b
	.byte	0x93
	.uleb128 0x8
	.byte	0
	.uleb128 0x20
	.4byte	0x4bf
	.4byte	.LBB51
	.4byte	.LBE51-.LBB51
	.byte	0x1
	.byte	0x2b
	.4byte	0x768
	.uleb128 0x27
	.4byte	0x4dc
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x119
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x27
	.4byte	0x4d0
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x11b
	.byte	0x93
	.uleb128 0x8
	.byte	0
	.uleb128 0x20
	.4byte	0x4bf
	.4byte	.LBB53
	.4byte	.LBE53-.LBB53
	.byte	0x1
	.byte	0x30
	.4byte	0x792
	.uleb128 0x27
	.4byte	0x4dc
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x11a
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x27
	.4byte	0x4d0
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x11b
	.byte	0x93
	.uleb128 0x8
	.byte	0
	.uleb128 0x20
	.4byte	0x495
	.4byte	.LBB55
	.4byte	.LBE55-.LBB55
	.byte	0x1
	.byte	0x24
	.4byte	0x7bf
	.uleb128 0x27
	.4byte	0x4b2
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x11b
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x29
	.4byte	0x4a6
	.byte	0x8
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0
	.uleb128 0x20
	.4byte	0x4e9
	.4byte	.LBB57
	.4byte	.LBE57-.LBB57
	.byte	0x1
	.byte	0x27
	.4byte	0x7ec
	.uleb128 0x26
	.4byte	0x512
	.uleb128 0x27
	.4byte	0x506
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x117
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x23
	.4byte	0x4fa
	.4byte	.LLST4
	.byte	0
	.uleb128 0x20
	.4byte	0x4e9
	.4byte	.LBB59
	.4byte	.LBE59-.LBB59
	.byte	0x1
	.byte	0x2c
	.4byte	0x815
	.uleb128 0x26
	.4byte	0x512
	.uleb128 0x27
	.4byte	0x506
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x117
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x26
	.4byte	0x4fa
	.byte	0
	.uleb128 0x20
	.4byte	0x4e9
	.4byte	.LBB61
	.4byte	.LBE61-.LBB61
	.byte	0x1
	.byte	0x31
	.4byte	0x83e
	.uleb128 0x26
	.4byte	0x512
	.uleb128 0x27
	.4byte	0x506
	.uleb128 0x5
	.byte	0x90
	.uleb128 0x117
	.byte	0x93
	.uleb128 0x8
	.uleb128 0x26
	.4byte	0x4fa
	.byte	0
	.uleb128 0x20
	.4byte	0x51f
	.4byte	.LBB63
	.4byte	.LBE63-.LBB63
	.byte	0x1
	.byte	0x28
	.4byte	0x861
	.uleb128 0x2a
	.4byte	0x53c
	.byte	0x8
	.uleb128 0x23
	.4byte	0x530
	.4byte	.LLST5
	.byte	0
	.uleb128 0x20
	.4byte	0x51f
	.4byte	.LBB65
	.4byte	.LBE65-.LBB65
	.byte	0x1
	.byte	0x2d
	.4byte	0x884
	.uleb128 0x2a
	.4byte	0x53c
	.byte	0x8
	.uleb128 0x23
	.4byte	0x530
	.4byte	.LLST6
	.byte	0
	.uleb128 0x2b
	.4byte	0x51f
	.4byte	.LBB67
	.4byte	.LBE67-.LBB67
	.byte	0x1
	.byte	0x32
	.uleb128 0x2a
	.4byte	0x53c
	.byte	0x8
	.uleb128 0x23
	.4byte	0x530
	.4byte	.LLST7
	.byte	0
	.byte	0
	.uleb128 0x2c
	.4byte	.LASF119
	.byte	0x1
	.byte	0x39
	.4byte	0x33
	.4byte	.LFB1913
	.4byte	.LFE1913-.LFB1913
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb16
	.uleb128 0x2d
	.4byte	.LASF94
	.byte	0x1
	.byte	0x39
	.4byte	0x33
	.4byte	.LLST8
	.uleb128 0x2d
	.4byte	.LASF95
	.byte	0x1
	.byte	0x39
	.4byte	0xb16
	.4byte	.LLST9
	.uleb128 0x1f
	.4byte	.LASF96
	.byte	0x1
	.byte	0x3b
	.4byte	0xb1c
	.4byte	.LLST10
	.uleb128 0x1f
	.4byte	.LASF97
	.byte	0x1
	.byte	0x3b
	.4byte	0xb1c
	.4byte	.LLST11
	.uleb128 0x1f
	.4byte	.LASF98
	.byte	0x1
	.byte	0x3b
	.4byte	0xb1c
	.4byte	.LLST12
	.uleb128 0x1f
	.4byte	.LASF99
	.byte	0x1
	.byte	0x3c
	.4byte	0x33
	.4byte	.LLST13
	.uleb128 0x2e
	.4byte	.LASF100
	.byte	0x1
	.byte	0x3d
	.4byte	0x2dc
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2e
	.4byte	.LASF101
	.byte	0x1
	.byte	0x3d
	.4byte	0x2dc
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2f
	.4byte	.LVL18
	.4byte	0xb89
	.4byte	0x94a
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL23
	.4byte	0xba5
	.4byte	0x961
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL26
	.4byte	0xba5
	.4byte	0x978
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL29
	.4byte	0xba5
	.4byte	0x98f
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC2
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL32
	.4byte	0xbc0
	.4byte	0x9ba
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0xa
	.2byte	0x200
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL36
	.4byte	0xbe5
	.4byte	0x9db
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x45
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL39
	.4byte	0xbe5
	.4byte	0x9fc
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x47
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC6
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL42
	.4byte	0xbc0
	.4byte	0xa20
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL45
	.4byte	0xbe5
	.4byte	0xa41
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x45
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC4
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL48
	.4byte	0xc0d
	.4byte	0xa5a
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL49
	.4byte	0x5c1
	.4byte	0xa83
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL50
	.4byte	0xc0d
	.4byte	0xa9c
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL51
	.4byte	0xb89
	.4byte	0xab3
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC5
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL52
	.4byte	0xc33
	.4byte	0xadd
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x78
	.sleb128 0
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL53
	.4byte	0xc58
	.4byte	0xaf1
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0x2f
	.4byte	.LVL54
	.4byte	0xc58
	.4byte	0xb05
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x31
	.4byte	.LVL55
	.4byte	0xc58
	.uleb128 0x30
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x3a
	.uleb128 0x4
	.byte	0x4
	.4byte	0xd1
	.uleb128 0x32
	.4byte	.LASF102
	.byte	0x5
	.byte	0xa8
	.4byte	0x29a
	.uleb128 0x32
	.4byte	.LASF103
	.byte	0x5
	.byte	0xa9
	.4byte	0x29a
	.uleb128 0x32
	.4byte	.LASF104
	.byte	0x5
	.byte	0xaa
	.4byte	0x29a
	.uleb128 0xb
	.4byte	0x33
	.4byte	0xb56
	.uleb128 0x33
	.4byte	0xb2
	.4byte	0x3ffff
	.byte	0
	.uleb128 0x34
	.4byte	.LASF105
	.byte	0x1
	.byte	0xb
	.4byte	0xb43
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.uleb128 0x34
	.4byte	.LASF106
	.byte	0x1
	.byte	0xc
	.4byte	0xb43
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.uleb128 0x34
	.4byte	.LASF107
	.byte	0x1
	.byte	0xd
	.4byte	0xb43
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.uleb128 0x35
	.4byte	.LASF108
	.byte	0x5
	.2byte	0x164
	.4byte	0x33
	.4byte	0xba5
	.uleb128 0x36
	.4byte	0xb1c
	.uleb128 0x36
	.4byte	0x2c6
	.uleb128 0x37
	.byte	0
	.uleb128 0x35
	.4byte	.LASF109
	.byte	0x5
	.2byte	0x110
	.4byte	0xb1c
	.4byte	0xbc0
	.uleb128 0x36
	.4byte	0x2c6
	.uleb128 0x36
	.4byte	0x2c6
	.byte	0
	.uleb128 0x35
	.4byte	.LASF110
	.byte	0x5
	.2byte	0x2c5
	.4byte	0x47
	.4byte	0xbe5
	.uleb128 0x36
	.4byte	0xcf
	.uleb128 0x36
	.4byte	0x47
	.uleb128 0x36
	.4byte	0x47
	.uleb128 0x36
	.4byte	0xb1c
	.byte	0
	.uleb128 0x38
	.4byte	.LASF120
	.byte	0xa
	.byte	0
	.4byte	.LASF112
	.4byte	0x52
	.4byte	0xc0d
	.uleb128 0x36
	.4byte	0x301
	.uleb128 0x36
	.4byte	0x52
	.uleb128 0x36
	.4byte	0x52
	.uleb128 0x36
	.4byte	0xcf
	.byte	0
	.uleb128 0x39
	.4byte	.LASF111
	.byte	0x9
	.byte	0x47
	.4byte	0x33
	.4byte	0xc27
	.uleb128 0x36
	.4byte	0xc27
	.uleb128 0x36
	.4byte	0xc2d
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x2dc
	.uleb128 0x4
	.byte	0x4
	.4byte	0x30d
	.uleb128 0x35
	.4byte	.LASF112
	.byte	0x5
	.2byte	0x2cb
	.4byte	0x47
	.4byte	0xc58
	.uleb128 0x36
	.4byte	0x301
	.uleb128 0x36
	.4byte	0x47
	.uleb128 0x36
	.4byte	0x47
	.uleb128 0x36
	.4byte	0xb1c
	.byte	0
	.uleb128 0x3a
	.4byte	.LASF121
	.byte	0x5
	.byte	0xed
	.4byte	0x33
	.uleb128 0x36
	.4byte	0xb1c
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x2107
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x21
	.byte	0
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x38
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL3
	.4byte	.LVL5
	.2byte	0x11
	.byte	0x90
	.uleb128 0x118
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x119
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11a
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL5
	.4byte	.LFE1912
	.2byte	0x14
	.byte	0x90
	.uleb128 0x118
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x119
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11a
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11b
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL1
	.4byte	.LVL5
	.2byte	0x14
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL5
	.4byte	.LVL8
	.2byte	0xe
	.byte	0x93
	.uleb128 0x18
	.byte	0x9e
	.uleb128 0x8
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL8
	.4byte	.LVL9
	.2byte	0xe
	.byte	0x93
	.uleb128 0x18
	.byte	0x9e
	.uleb128 0x8
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL9
	.4byte	.LVL10
	.2byte	0xe
	.byte	0x93
	.uleb128 0x18
	.byte	0x9e
	.uleb128 0x8
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL10
	.4byte	.LVL11
	.2byte	0xe
	.byte	0x93
	.uleb128 0x18
	.byte	0x9e
	.uleb128 0x8
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0xff
	.byte	0x93
	.uleb128 0x8
	.4byte	.LVL11
	.4byte	.LVL12
	.2byte	0x7
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x18
	.4byte	.LVL12
	.4byte	.LVL13
	.2byte	0x9
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x10
	.4byte	.LVL13
	.4byte	.LFE1912
	.2byte	0x14
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11c
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x11d
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL1
	.4byte	.LVL4
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL4
	.4byte	.LVL13
	.2byte	0x3
	.byte	0x73
	.sleb128 -32
	.byte	0x9f
	.4byte	.LVL13
	.4byte	.LFE1912
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL2
	.4byte	.LVL14
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL14
	.4byte	.LFE1912
	.2byte	0x9
	.byte	0x70
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x8
	.byte	0x20
	.byte	0x1c
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL6
	.4byte	.LVL7
	.2byte	0xa
	.byte	0x90
	.uleb128 0x114
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x114
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST5:
	.4byte	.LVL7
	.4byte	.LVL8
	.2byte	0xa
	.byte	0x90
	.uleb128 0x114
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x114
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST6:
	.4byte	.LVL8
	.4byte	.LVL9
	.2byte	0xa
	.byte	0x90
	.uleb128 0x112
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x112
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST7:
	.4byte	.LVL9
	.4byte	.LVL10
	.2byte	0xa
	.byte	0x90
	.uleb128 0x110
	.byte	0x93
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x110
	.byte	0x93
	.uleb128 0x8
	.4byte	0
	.4byte	0
.LLST8:
	.4byte	.LVL15
	.4byte	.LVL17
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL17
	.4byte	.LVL20
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL20
	.4byte	.LVL22
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL22
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LLST9:
	.4byte	.LVL15
	.4byte	.LVL16
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL16
	.4byte	.LVL19
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL19
	.4byte	.LVL20
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	.LVL20
	.4byte	.LVL21
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL21
	.4byte	.LVL30
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL30
	.4byte	.LFE1913
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST10:
	.4byte	.LVL24
	.4byte	.LVL25
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL25
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LLST11:
	.4byte	.LVL27
	.4byte	.LVL28
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL28
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x56
	.4byte	0
	.4byte	0
.LLST12:
	.4byte	.LVL30
	.4byte	.LVL31
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL31
	.4byte	.LVL37
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL37
	.4byte	.LVL38
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL38
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LLST13:
	.4byte	.LVL33
	.4byte	.LVL34
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL34
	.4byte	.LVL35
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL40
	.4byte	.LVL41
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL41
	.4byte	.LVL42-1
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL43
	.4byte	.LVL44
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL44
	.4byte	.LVL46
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL46
	.4byte	.LVL47
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL47
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB1913
	.4byte	.LFE1913-.LFB1913
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LBB38
	.4byte	.LBE38
	.4byte	.LBB47
	.4byte	.LBE47
	.4byte	0
	.4byte	0
	.4byte	.LBB41
	.4byte	.LBE41
	.4byte	.LBB50
	.4byte	.LBE50
	.4byte	0
	.4byte	0
	.4byte	.LBB44
	.4byte	.LBE44
	.4byte	.LBB69
	.4byte	.LBE69
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB1913
	.4byte	.LFE1913
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF80:
	.ascii	"vdup_n_u8\000"
.LASF60:
	.ascii	"tz_dsttime\000"
.LASF39:
	.ascii	"_shortbuf\000"
.LASF114:
	.ascii	"main.c\000"
.LASF116:
	.ascii	"_IO_lock_t\000"
.LASF104:
	.ascii	"stderr\000"
.LASF28:
	.ascii	"_IO_buf_end\000"
.LASF26:
	.ascii	"_IO_write_end\000"
.LASF3:
	.ascii	"unsigned int\000"
.LASF105:
	.ascii	"backImage\000"
.LASF59:
	.ascii	"tz_minuteswest\000"
.LASF20:
	.ascii	"_flags\000"
.LASF72:
	.ascii	"__builtin_neon_uhi\000"
.LASF113:
	.ascii	"GNU C 4.9.2 -march=armv7-a -mfpu=neon -mcpu=cortex-"
	.ascii	"a8 -mtune=cortex-a8 -mfloat-abi=hard -mthumb -mtls-"
	.ascii	"dialect=gnu -ggdb -O3 -ffast-math -fsingle-precisio"
	.ascii	"n-constant -fno-tree-loop-vectorize -fno-tree-vecto"
	.ascii	"rize -fno-unroll-loops\000"
.LASF81:
	.ascii	"vsub_u8\000"
.LASF32:
	.ascii	"_markers\000"
.LASF120:
	.ascii	"__builtin_fwrite\000"
.LASF98:
	.ascii	"outFile\000"
.LASF106:
	.ascii	"foreImage\000"
.LASF85:
	.ascii	"vmovn_u16\000"
.LASF53:
	.ascii	"_pos\000"
.LASF77:
	.ascii	"uint8x8x4_t\000"
.LASF103:
	.ascii	"stdout\000"
.LASF31:
	.ascii	"_IO_save_end\000"
.LASF0:
	.ascii	"float\000"
.LASF93:
	.ascii	"index\000"
.LASF99:
	.ascii	"result\000"
.LASF10:
	.ascii	"long long unsigned int\000"
.LASF79:
	.ascii	"vld4_u8\000"
.LASF30:
	.ascii	"_IO_backup_base\000"
.LASF41:
	.ascii	"_offset\000"
.LASF108:
	.ascii	"fprintf\000"
.LASF34:
	.ascii	"_fileno\000"
.LASF55:
	.ascii	"timeval\000"
.LASF89:
	.ascii	"bgImage\000"
.LASF109:
	.ascii	"fopen\000"
.LASF11:
	.ascii	"size_t\000"
.LASF62:
	.ascii	"__builtin_neon_qi\000"
.LASF23:
	.ascii	"_IO_read_base\000"
.LASF94:
	.ascii	"argc\000"
.LASF102:
	.ascii	"stdin\000"
.LASF51:
	.ascii	"_next\000"
.LASF57:
	.ascii	"tv_usec\000"
.LASF76:
	.ascii	"uint16x8_t\000"
.LASF83:
	.ascii	"vmlal_u8\000"
.LASF2:
	.ascii	"char\000"
.LASF47:
	.ascii	"_mode\000"
.LASF50:
	.ascii	"_IO_marker\000"
.LASF115:
	.ascii	"/root/GIT/ECE_785/Project_2_b\000"
.LASF21:
	.ascii	"_IO_read_ptr\000"
.LASF69:
	.ascii	"__builtin_neon_poly16\000"
.LASF75:
	.ascii	"int16x8_t\000"
.LASF61:
	.ascii	"int8x8_t\000"
.LASF54:
	.ascii	"uint8_t\000"
.LASF67:
	.ascii	"__builtin_neon_sf\000"
.LASF64:
	.ascii	"__builtin_neon_si\000"
.LASF65:
	.ascii	"__builtin_neon_di\000"
.LASF24:
	.ascii	"_IO_write_base\000"
.LASF9:
	.ascii	"long long int\000"
.LASF29:
	.ascii	"_IO_save_base\000"
.LASF78:
	.ascii	"__builtin_neon_oi\000"
.LASF118:
	.ascii	"alphaBlend_c\000"
.LASF12:
	.ascii	"__quad_t\000"
.LASF107:
	.ascii	"newImage\000"
.LASF88:
	.ascii	"fgImage\000"
.LASF96:
	.ascii	"fgFile\000"
.LASF84:
	.ascii	"vshrq_n_u16\000"
.LASF42:
	.ascii	"__pad1\000"
.LASF43:
	.ascii	"__pad2\000"
.LASF44:
	.ascii	"__pad3\000"
.LASF45:
	.ascii	"__pad4\000"
.LASF46:
	.ascii	"__pad5\000"
.LASF117:
	.ascii	"vst4_u8\000"
.LASF70:
	.ascii	"uint8x8_t\000"
.LASF87:
	.ascii	"__bu\000"
.LASF38:
	.ascii	"_vtable_offset\000"
.LASF95:
	.ascii	"argv\000"
.LASF58:
	.ascii	"timezone\000"
.LASF86:
	.ascii	"__rv\000"
.LASF22:
	.ascii	"_IO_read_end\000"
.LASF8:
	.ascii	"short int\000"
.LASF14:
	.ascii	"long int\000"
.LASF71:
	.ascii	"__builtin_neon_uqi\000"
.LASF110:
	.ascii	"fread\000"
.LASF92:
	.ascii	"temp\000"
.LASF101:
	.ascii	"newTv\000"
.LASF121:
	.ascii	"fclose\000"
.LASF66:
	.ascii	"__builtin_neon_hf\000"
.LASF63:
	.ascii	"__builtin_neon_hi\000"
.LASF40:
	.ascii	"_lock\000"
.LASF56:
	.ascii	"tv_sec\000"
.LASF16:
	.ascii	"sizetype\000"
.LASF6:
	.ascii	"long unsigned int\000"
.LASF36:
	.ascii	"_old_offset\000"
.LASF49:
	.ascii	"_IO_FILE\000"
.LASF111:
	.ascii	"gettimeofday\000"
.LASF73:
	.ascii	"__builtin_neon_usi\000"
.LASF4:
	.ascii	"unsigned char\000"
.LASF52:
	.ascii	"_sbuf\000"
.LASF74:
	.ascii	"__builtin_neon_udi\000"
.LASF25:
	.ascii	"_IO_write_ptr\000"
.LASF18:
	.ascii	"__suseconds_t\000"
.LASF100:
	.ascii	"oldTv\000"
.LASF17:
	.ascii	"__time_t\000"
.LASF97:
	.ascii	"bgFile\000"
.LASF68:
	.ascii	"__builtin_neon_poly8\000"
.LASF112:
	.ascii	"fwrite\000"
.LASF90:
	.ascii	"dstImage\000"
.LASF13:
	.ascii	"__off_t\000"
.LASF7:
	.ascii	"signed char\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF119:
	.ascii	"main\000"
.LASF91:
	.ascii	"aM255\000"
.LASF1:
	.ascii	"double\000"
.LASF33:
	.ascii	"_chain\000"
.LASF19:
	.ascii	"FILE\000"
.LASF35:
	.ascii	"_flags2\000"
.LASF37:
	.ascii	"_cur_column\000"
.LASF15:
	.ascii	"__off64_t\000"
.LASF48:
	.ascii	"_unused2\000"
.LASF27:
	.ascii	"_IO_buf_base\000"
.LASF82:
	.ascii	"vmull_u8\000"
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
