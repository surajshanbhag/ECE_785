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
	.loc 1 20 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.LVL0:
	.loc 1 20 0
	movs	r3, #0
.LVL1:
.L2:
	adds	r3, r3, #4
	.loc 1 24 0 discriminator 3
	cmp	r3, #2048
	bne	.L2
	.loc 1 32 0
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
	.loc 1 35 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL2:
	.loc 1 40 0
	cmp	r0, #4
	.loc 1 35 0
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
	.loc 1 35 0
	mov	r5, r1
	.loc 1 40 0
	beq	.L6
	.loc 1 41 0
	movw	r3, #:lower16:stderr
	movw	r1, #:lower16:.LC0
.LVL3:
	movt	r3, #:upper16:stderr
	ldr	r2, [r5]
	ldr	r0, [r3]
.LVL4:
	movt	r1, #:upper16:.LC0
	bl	fprintf
.LVL5:
	.loc 1 42 0
	movs	r0, #1
.LVL6:
.L7:
	.loc 1 72 0
	add	sp, sp, #16
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.LVL7:
.L6:
	.cfi_restore_state
	.loc 1 44 0
	movw	r1, #:lower16:.LC1
.LVL8:
	ldr	r0, [r5, #4]
.LVL9:
	movt	r1, #:upper16:.LC1
	bl	fopen
.LVL10:
	.loc 1 45 0
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	.loc 1 44 0
	mov	r7, r0
.LVL11:
	.loc 1 45 0
	ldr	r0, [r5, #8]
.LVL12:
	bl	fopen
.LVL13:
	.loc 1 46 0
	movw	r1, #:lower16:.LC2
	movt	r1, #:upper16:.LC2
	.loc 1 45 0
	mov	r6, r0
.LVL14:
	.loc 1 46 0
	ldr	r0, [r5, #12]
.LVL15:
	bl	fopen
.LVL16:
	.loc 1 48 0
	cmp	r6, #0
	it	ne
	cmpne	r7, #0
	.loc 1 46 0
	mov	r5, r0
.LVL17:
	.loc 1 48 0
	beq	.L8
	cbz	r0, .L8
	.loc 1 49 0
	movw	r0, #:lower16:backImage
.LVL18:
	mov	r2, #512
	mov	r1, #2048
	movt	r0, #:upper16:backImage
	mov	r3, r6
	bl	fread
.LVL19:
	.loc 1 50 0
	cmp	r0, #512
	.loc 1 49 0
	mov	r2, r0
.LVL20:
	.loc 1 50 0
	beq	.L9
	.loc 1 51 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC3
.LVL21:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC3
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
.LVL22:
	bl	fwrite
.LVL23:
	.loc 1 52 0
	movs	r0, #3
	b	.L7
.LVL24:
.L8:
	.loc 1 70 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC6
.LVL25:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC6
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #23
	bl	fwrite
.LVL26:
	.loc 1 71 0
	movs	r0, #2
	b	.L7
.LVL27:
.L9:
	.loc 1 54 0
	movw	r0, #:lower16:foreImage
.LVL28:
	mov	r1, #2048
	movt	r0, #:upper16:foreImage
	mov	r3, r7
	bl	fread
.LVL29:
	.loc 1 55 0
	cmp	r0, #512
	.loc 1 54 0
	mov	r8, r0
.LVL30:
	.loc 1 55 0
	beq	.L10
	.loc 1 56 0
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC4
.LVL31:
	movt	r3, #:upper16:stderr
	movt	r0, #:upper16:.LC4
	ldr	r3, [r3]
	movs	r1, #1
	movs	r2, #21
	bl	fwrite
.LVL32:
	.loc 1 57 0
	mov	r0, r4
	b	.L7
.LVL33:
.L10:
	.loc 1 59 0
	movs	r1, #0
	mov	r0, sp
.LVL34:
	bl	gettimeofday
.LVL35:
	.loc 1 60 0
	movw	r0, #:lower16:foreImage
	movw	r1, #:lower16:backImage
	movw	r2, #:lower16:newImage
	movt	r2, #:upper16:newImage
	movt	r0, #:upper16:foreImage
	movt	r1, #:upper16:backImage
	bl	alphaBlend_c
.LVL36:
	.loc 1 62 0
	movs	r1, #0
	add	r0, sp, #8
	bl	gettimeofday
.LVL37:
	.loc 1 63 0
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #12]
	movw	r0, #:lower16:stdout
	movt	r0, #:upper16:stdout
	movw	r1, #:lower16:.LC5
	subs	r2, r2, r3
	movt	r1, #:upper16:.LC5
	ldr	r0, [r0]
	bl	fprintf
.LVL38:
	.loc 1 64 0
	movw	r0, #:lower16:newImage
	mov	r2, r8
	mov	r1, #2048
	mov	r3, r5
	movt	r0, #:upper16:newImage
	bl	fwrite
.LVL39:
	.loc 1 65 0
	mov	r0, r7
	bl	fclose
.LVL40:
	.loc 1 66 0
	mov	r0, r6
	bl	fclose
.LVL41:
	.loc 1 67 0
	mov	r0, r5
	bl	fclose
.LVL42:
	.loc 1 68 0
	movs	r0, #0
	b	.L7
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
	.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/stddef.h"
	.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
	.file 4 "/usr/include/stdio.h"
	.file 5 "/usr/include/libio.h"
	.file 6 "/usr/include/stdint.h"
	.file 7 "/usr/include/arm-linux-gnueabihf/bits/time.h"
	.file 8 "/usr/include/arm-linux-gnueabihf/sys/time.h"
	.file 9 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/arm_neon.h"
	.file 10 "<built-in>"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x8a9
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF103
	.byte	0x1
	.4byte	.LASF104
	.4byte	.LASF105
	.4byte	.Ldebug_ranges0+0
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
	.byte	0x2
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
	.byte	0x3
	.byte	0x37
	.4byte	0x7c
	.uleb128 0x5
	.4byte	.LASF13
	.byte	0x3
	.byte	0x83
	.4byte	0xa0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF14
	.uleb128 0x5
	.4byte	.LASF15
	.byte	0x3
	.byte	0x84
	.4byte	0x8a
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF16
	.uleb128 0x5
	.4byte	.LASF17
	.byte	0x3
	.byte	0x8b
	.4byte	0xa0
	.uleb128 0x5
	.4byte	.LASF18
	.byte	0x3
	.byte	0x8d
	.4byte	0xa0
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x5
	.4byte	.LASF19
	.byte	0x4
	.byte	0x30
	.4byte	0xdc
	.uleb128 0x7
	.4byte	.LASF49
	.byte	0x98
	.byte	0x5
	.byte	0xf5
	.4byte	0x25c
	.uleb128 0x8
	.4byte	.LASF20
	.byte	0x5
	.byte	0xf6
	.4byte	0x33
	.byte	0
	.uleb128 0x8
	.4byte	.LASF21
	.byte	0x5
	.byte	0xfb
	.4byte	0x3a
	.byte	0x4
	.uleb128 0x8
	.4byte	.LASF22
	.byte	0x5
	.byte	0xfc
	.4byte	0x3a
	.byte	0x8
	.uleb128 0x8
	.4byte	.LASF23
	.byte	0x5
	.byte	0xfd
	.4byte	0x3a
	.byte	0xc
	.uleb128 0x8
	.4byte	.LASF24
	.byte	0x5
	.byte	0xfe
	.4byte	0x3a
	.byte	0x10
	.uleb128 0x8
	.4byte	.LASF25
	.byte	0x5
	.byte	0xff
	.4byte	0x3a
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x5
	.2byte	0x100
	.4byte	0x3a
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x5
	.2byte	0x101
	.4byte	0x3a
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x5
	.2byte	0x102
	.4byte	0x3a
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x5
	.2byte	0x104
	.4byte	0x3a
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x5
	.2byte	0x105
	.4byte	0x3a
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x5
	.2byte	0x106
	.4byte	0x3a
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x5
	.2byte	0x108
	.4byte	0x294
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x5
	.2byte	0x10a
	.4byte	0x29a
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x5
	.2byte	0x10c
	.4byte	0x33
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x5
	.2byte	0x110
	.4byte	0x33
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x5
	.2byte	0x112
	.4byte	0x95
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x5
	.2byte	0x116
	.4byte	0x60
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x5
	.2byte	0x117
	.4byte	0x6e
	.byte	0x46
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x5
	.2byte	0x118
	.4byte	0x2a0
	.byte	0x47
	.uleb128 0x9
	.4byte	.LASF40
	.byte	0x5
	.2byte	0x11c
	.4byte	0x2b0
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF41
	.byte	0x5
	.2byte	0x125
	.4byte	0xa7
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF42
	.byte	0x5
	.2byte	0x12e
	.4byte	0xcf
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF43
	.byte	0x5
	.2byte	0x12f
	.4byte	0xcf
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF44
	.byte	0x5
	.2byte	0x130
	.4byte	0xcf
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF45
	.byte	0x5
	.2byte	0x131
	.4byte	0xcf
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF46
	.byte	0x5
	.2byte	0x132
	.4byte	0x47
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF47
	.byte	0x5
	.2byte	0x134
	.4byte	0x33
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF48
	.byte	0x5
	.2byte	0x136
	.4byte	0x2b6
	.byte	0x70
	.byte	0
	.uleb128 0xa
	.4byte	.LASF106
	.byte	0x5
	.byte	0x9a
	.uleb128 0x7
	.4byte	.LASF50
	.byte	0xc
	.byte	0x5
	.byte	0xa0
	.4byte	0x294
	.uleb128 0x8
	.4byte	.LASF51
	.byte	0x5
	.byte	0xa1
	.4byte	0x294
	.byte	0
	.uleb128 0x8
	.4byte	.LASF52
	.byte	0x5
	.byte	0xa2
	.4byte	0x29a
	.byte	0x4
	.uleb128 0x8
	.4byte	.LASF53
	.byte	0x5
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
	.byte	0x6
	.byte	0x30
	.4byte	0x59
	.uleb128 0x4
	.byte	0x4
	.4byte	0x33
	.uleb128 0x7
	.4byte	.LASF55
	.byte	0x8
	.byte	0x7
	.byte	0x1e
	.4byte	0x307
	.uleb128 0x8
	.4byte	.LASF56
	.byte	0x7
	.byte	0x20
	.4byte	0xb9
	.byte	0
	.uleb128 0x8
	.4byte	.LASF57
	.byte	0x7
	.byte	0x21
	.4byte	0xc4
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x30d
	.uleb128 0xe
	.uleb128 0x7
	.4byte	.LASF58
	.byte	0x8
	.byte	0x8
	.byte	0x37
	.4byte	0x333
	.uleb128 0x8
	.4byte	.LASF59
	.byte	0x8
	.byte	0x39
	.4byte	0x33
	.byte	0
	.uleb128 0x8
	.4byte	.LASF60
	.byte	0x8
	.byte	0x3a
	.4byte	0x33
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x5
	.4byte	.LASF61
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF62
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF63
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF64
	.uleb128 0x2
	.byte	0x2
	.byte	0x4
	.4byte	.LASF65
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF66
	.uleb128 0x2
	.byte	0x1
	.byte	0x5
	.4byte	.LASF67
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF68
	.uleb128 0x2
	.byte	0x1
	.byte	0x7
	.4byte	.LASF69
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF70
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF71
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF72
	.uleb128 0x5
	.4byte	.LASF73
	.byte	0x9
	.byte	0x37
	.4byte	0x392
	.uleb128 0xf
	.4byte	0x333
	.4byte	0x39e
	.uleb128 0x10
	.byte	0xf
	.byte	0
	.uleb128 0x5
	.4byte	.LASF74
	.byte	0x9
	.byte	0x41
	.4byte	0x3a9
	.uleb128 0xf
	.4byte	0x36b
	.4byte	0x3b5
	.uleb128 0x10
	.byte	0xf
	.byte	0
	.uleb128 0x11
	.4byte	.LASF75
	.byte	0x40
	.byte	0x9
	.2byte	0x177
	.4byte	0x3d0
	.uleb128 0x12
	.ascii	"val\000"
	.byte	0x9
	.2byte	0x179
	.4byte	0x3d0
	.byte	0
	.byte	0
	.uleb128 0xb
	.4byte	0x39e
	.4byte	0x3e0
	.uleb128 0xc
	.4byte	0xb2
	.byte	0x3
	.byte	0
	.uleb128 0x13
	.4byte	.LASF75
	.byte	0x9
	.2byte	0x17a
	.4byte	0x3b5
	.uleb128 0x14
	.4byte	.LASF77
	.byte	0x9
	.2byte	0x2a11
	.4byte	0x3e0
	.byte	0x3
	.4byte	0x438
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x9
	.2byte	0x2a11
	.4byte	0x438
	.uleb128 0x16
	.byte	0x40
	.byte	0x9
	.2byte	0x2a13
	.4byte	0x42b
	.uleb128 0x17
	.ascii	"__i\000"
	.byte	0x9
	.2byte	0x2a13
	.4byte	0x3e0
	.uleb128 0x17
	.ascii	"__o\000"
	.byte	0x9
	.2byte	0x2a13
	.4byte	0x443
	.byte	0
	.uleb128 0x18
	.4byte	.LASF82
	.byte	0x9
	.2byte	0x2a13
	.4byte	0x409
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x43e
	.uleb128 0xd
	.4byte	0x2d1
	.uleb128 0x2
	.byte	0x40
	.byte	0x5
	.4byte	.LASF76
	.uleb128 0x14
	.4byte	.LASF78
	.byte	0x9
	.2byte	0x3fe
	.4byte	0x39e
	.byte	0x3
	.4byte	0x474
	.uleb128 0x15
	.ascii	"__a\000"
	.byte	0x9
	.2byte	0x3fe
	.4byte	0x39e
	.uleb128 0x15
	.ascii	"__b\000"
	.byte	0x9
	.2byte	0x3fe
	.4byte	0x39e
	.byte	0
	.uleb128 0x19
	.4byte	.LASF107
	.byte	0x1
	.byte	0x13
	.4byte	.LFB1912
	.4byte	.LFE1912-.LFB1912
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4e7
	.uleb128 0x1a
	.4byte	.LASF79
	.byte	0x1
	.byte	0x13
	.4byte	0x2dc
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF80
	.byte	0x1
	.byte	0x13
	.4byte	0x2dc
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1a
	.4byte	.LASF81
	.byte	0x1
	.byte	0x13
	.4byte	0x2dc
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1b
	.ascii	"fg\000"
	.byte	0x1
	.byte	0x15
	.4byte	0x3e0
	.uleb128 0x1b
	.ascii	"bg\000"
	.byte	0x1
	.byte	0x15
	.4byte	0x3e0
	.uleb128 0x1b
	.ascii	"ds\000"
	.byte	0x1
	.byte	0x15
	.4byte	0x3e0
	.uleb128 0x1b
	.ascii	"a\000"
	.byte	0x1
	.byte	0x16
	.4byte	0x33
	.uleb128 0x1c
	.4byte	.LASF85
	.byte	0x1
	.byte	0x17
	.4byte	0x33
	.4byte	.LLST0
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF108
	.byte	0x1
	.byte	0x22
	.4byte	0x33
	.4byte	.LFB1913
	.4byte	.LFE1913-.LFB1913
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x759
	.uleb128 0x1e
	.4byte	.LASF83
	.byte	0x1
	.byte	0x22
	.4byte	0x33
	.4byte	.LLST1
	.uleb128 0x1e
	.4byte	.LASF84
	.byte	0x1
	.byte	0x22
	.4byte	0x759
	.4byte	.LLST2
	.uleb128 0x1c
	.4byte	.LASF86
	.byte	0x1
	.byte	0x24
	.4byte	0x75f
	.4byte	.LLST3
	.uleb128 0x1c
	.4byte	.LASF87
	.byte	0x1
	.byte	0x24
	.4byte	0x75f
	.4byte	.LLST4
	.uleb128 0x1c
	.4byte	.LASF88
	.byte	0x1
	.byte	0x24
	.4byte	0x75f
	.4byte	.LLST5
	.uleb128 0x1c
	.4byte	.LASF89
	.byte	0x1
	.byte	0x25
	.4byte	0x33
	.4byte	.LLST6
	.uleb128 0x1f
	.4byte	.LASF90
	.byte	0x1
	.byte	0x26
	.4byte	0x2e2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1f
	.4byte	.LASF91
	.byte	0x1
	.byte	0x26
	.4byte	0x2e2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x20
	.4byte	.LVL5
	.4byte	0x7cc
	.4byte	0x58d
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.uleb128 0x20
	.4byte	.LVL10
	.4byte	0x7e8
	.4byte	0x5a4
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0x20
	.4byte	.LVL13
	.4byte	0x7e8
	.4byte	0x5bb
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0x20
	.4byte	.LVL16
	.4byte	0x7e8
	.4byte	0x5d2
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC2
	.byte	0
	.uleb128 0x20
	.4byte	.LVL19
	.4byte	0x803
	.4byte	0x5fd
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0xa
	.2byte	0x200
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.byte	0
	.uleb128 0x20
	.4byte	.LVL23
	.4byte	0x828
	.4byte	0x61e
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x45
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.byte	0
	.uleb128 0x20
	.4byte	.LVL26
	.4byte	0x828
	.4byte	0x63f
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x47
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC6
	.byte	0
	.uleb128 0x20
	.4byte	.LVL29
	.4byte	0x803
	.4byte	0x663
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.byte	0
	.uleb128 0x20
	.4byte	.LVL32
	.4byte	0x828
	.4byte	0x684
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x45
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC4
	.byte	0
	.uleb128 0x20
	.4byte	.LVL35
	.4byte	0x850
	.4byte	0x69d
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.4byte	.LVL36
	.4byte	0x474
	.4byte	0x6c6
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.byte	0
	.uleb128 0x20
	.4byte	.LVL37
	.4byte	0x850
	.4byte	0x6df
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x20
	.4byte	.LVL38
	.4byte	0x7cc
	.4byte	0x6f6
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC5
	.byte	0
	.uleb128 0x20
	.4byte	.LVL39
	.4byte	0x876
	.4byte	0x720
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x78
	.sleb128 0
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.byte	0
	.uleb128 0x20
	.4byte	.LVL40
	.4byte	0x89b
	.4byte	0x734
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.4byte	.LVL41
	.4byte	0x89b
	.4byte	0x748
	.uleb128 0x21
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x22
	.4byte	.LVL42
	.4byte	0x89b
	.uleb128 0x21
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
	.uleb128 0x23
	.4byte	.LASF92
	.byte	0x4
	.byte	0xa8
	.4byte	0x29a
	.uleb128 0x23
	.4byte	.LASF93
	.byte	0x4
	.byte	0xa9
	.4byte	0x29a
	.uleb128 0x23
	.4byte	.LASF94
	.byte	0x4
	.byte	0xaa
	.4byte	0x29a
	.uleb128 0xb
	.4byte	0x33
	.4byte	0x799
	.uleb128 0x24
	.4byte	0xb2
	.4byte	0x3ffff
	.byte	0
	.uleb128 0x25
	.4byte	.LASF95
	.byte	0x1
	.byte	0xb
	.4byte	0x786
	.uleb128 0x5
	.byte	0x3
	.4byte	backImage
	.uleb128 0x25
	.4byte	.LASF96
	.byte	0x1
	.byte	0xc
	.4byte	0x786
	.uleb128 0x5
	.byte	0x3
	.4byte	foreImage
	.uleb128 0x25
	.4byte	.LASF97
	.byte	0x1
	.byte	0xd
	.4byte	0x786
	.uleb128 0x5
	.byte	0x3
	.4byte	newImage
	.uleb128 0x26
	.4byte	.LASF98
	.byte	0x4
	.2byte	0x164
	.4byte	0x33
	.4byte	0x7e8
	.uleb128 0x27
	.4byte	0x75f
	.uleb128 0x27
	.4byte	0x2c6
	.uleb128 0x28
	.byte	0
	.uleb128 0x26
	.4byte	.LASF99
	.byte	0x4
	.2byte	0x110
	.4byte	0x75f
	.4byte	0x803
	.uleb128 0x27
	.4byte	0x2c6
	.uleb128 0x27
	.4byte	0x2c6
	.byte	0
	.uleb128 0x26
	.4byte	.LASF100
	.byte	0x4
	.2byte	0x2c5
	.4byte	0x47
	.4byte	0x828
	.uleb128 0x27
	.4byte	0xcf
	.uleb128 0x27
	.4byte	0x47
	.uleb128 0x27
	.4byte	0x47
	.uleb128 0x27
	.4byte	0x75f
	.byte	0
	.uleb128 0x29
	.4byte	.LASF109
	.byte	0xa
	.byte	0
	.4byte	.LASF102
	.4byte	0x52
	.4byte	0x850
	.uleb128 0x27
	.4byte	0x307
	.uleb128 0x27
	.4byte	0x52
	.uleb128 0x27
	.4byte	0x52
	.uleb128 0x27
	.4byte	0xcf
	.byte	0
	.uleb128 0x2a
	.4byte	.LASF101
	.byte	0x8
	.byte	0x47
	.4byte	0x33
	.4byte	0x86a
	.uleb128 0x27
	.4byte	0x86a
	.uleb128 0x27
	.4byte	0x870
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.4byte	0x2e2
	.uleb128 0x4
	.byte	0x4
	.4byte	0x30e
	.uleb128 0x26
	.4byte	.LASF102
	.byte	0x4
	.2byte	0x2cb
	.4byte	0x47
	.4byte	0x89b
	.uleb128 0x27
	.4byte	0x307
	.uleb128 0x27
	.4byte	0x47
	.uleb128 0x27
	.4byte	0x47
	.uleb128 0x27
	.4byte	0x75f
	.byte	0
	.uleb128 0x2b
	.4byte	.LASF110
	.byte	0x4
	.byte	0xed
	.4byte	0x33
	.uleb128 0x27
	.4byte	0x75f
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
	.uleb128 0x1a
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
	.uleb128 0x1b
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
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x20
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
	.uleb128 0x21
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
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
	.uleb128 0x24
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x25
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
	.uleb128 0x26
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
	.uleb128 0x27
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x29
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
	.uleb128 0x2a
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
	.uleb128 0x2b
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
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL2
	.4byte	.LVL4
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL4
	.4byte	.LVL7
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL7
	.4byte	.LVL9
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL9
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL2
	.4byte	.LVL3
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL3
	.4byte	.LVL6
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL6
	.4byte	.LVL7
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	.LVL7
	.4byte	.LVL8
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL8
	.4byte	.LVL17
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL17
	.4byte	.LFE1913
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL11
	.4byte	.LVL12
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL12
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL14
	.4byte	.LVL15
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL15
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x56
	.4byte	0
	.4byte	0
.LLST5:
	.4byte	.LVL17
	.4byte	.LVL18
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL18
	.4byte	.LVL24
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL24
	.4byte	.LVL25
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL25
	.4byte	.LFE1913
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LLST6:
	.4byte	.LVL20
	.4byte	.LVL21
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL21
	.4byte	.LVL22
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL27
	.4byte	.LVL28
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL28
	.4byte	.LVL29-1
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL30
	.4byte	.LVL31
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL31
	.4byte	.LVL33
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL33
	.4byte	.LVL34
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL34
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
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB1913
	.4byte	.LFE1913
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF87:
	.ascii	"bgFile\000"
.LASF12:
	.ascii	"__quad_t\000"
.LASF35:
	.ascii	"_flags2\000"
.LASF89:
	.ascii	"result\000"
.LASF1:
	.ascii	"double\000"
.LASF49:
	.ascii	"_IO_FILE\000"
.LASF56:
	.ascii	"tv_sec\000"
.LASF31:
	.ascii	"_IO_save_end\000"
.LASF8:
	.ascii	"short int\000"
.LASF11:
	.ascii	"size_t\000"
.LASF96:
	.ascii	"foreImage\000"
.LASF16:
	.ascii	"sizetype\000"
.LASF41:
	.ascii	"_offset\000"
.LASF64:
	.ascii	"__builtin_neon_di\000"
.LASF63:
	.ascii	"__builtin_neon_si\000"
.LASF25:
	.ascii	"_IO_write_ptr\000"
.LASF20:
	.ascii	"_flags\000"
.LASF74:
	.ascii	"uint8x16_t\000"
.LASF65:
	.ascii	"__builtin_neon_hf\000"
.LASF82:
	.ascii	"__rv\000"
.LASF32:
	.ascii	"_markers\000"
.LASF22:
	.ascii	"_IO_read_end\000"
.LASF58:
	.ascii	"timezone\000"
.LASF85:
	.ascii	"index\000"
.LASF78:
	.ascii	"vmulq_u8\000"
.LASF66:
	.ascii	"__builtin_neon_sf\000"
.LASF110:
	.ascii	"fclose\000"
.LASF90:
	.ascii	"oldTv\000"
.LASF0:
	.ascii	"float\000"
.LASF19:
	.ascii	"FILE\000"
.LASF94:
	.ascii	"stderr\000"
.LASF9:
	.ascii	"long long int\000"
.LASF40:
	.ascii	"_lock\000"
.LASF14:
	.ascii	"long int\000"
.LASF62:
	.ascii	"__builtin_neon_hi\000"
.LASF37:
	.ascii	"_cur_column\000"
.LASF60:
	.ascii	"tz_dsttime\000"
.LASF53:
	.ascii	"_pos\000"
.LASF98:
	.ascii	"fprintf\000"
.LASF72:
	.ascii	"__builtin_neon_udi\000"
.LASF71:
	.ascii	"__builtin_neon_usi\000"
.LASF84:
	.ascii	"argv\000"
.LASF54:
	.ascii	"uint8_t\000"
.LASF99:
	.ascii	"fopen\000"
.LASF36:
	.ascii	"_old_offset\000"
.LASF76:
	.ascii	"__builtin_neon_xi\000"
.LASF86:
	.ascii	"fgFile\000"
.LASF109:
	.ascii	"__builtin_fwrite\000"
.LASF93:
	.ascii	"stdout\000"
.LASF4:
	.ascii	"unsigned char\000"
.LASF80:
	.ascii	"bgImage\000"
.LASF70:
	.ascii	"__builtin_neon_uhi\000"
.LASF45:
	.ascii	"__pad4\000"
.LASF83:
	.ascii	"argc\000"
.LASF97:
	.ascii	"newImage\000"
.LASF7:
	.ascii	"signed char\000"
.LASF101:
	.ascii	"gettimeofday\000"
.LASF10:
	.ascii	"long long unsigned int\000"
.LASF3:
	.ascii	"unsigned int\000"
.LASF50:
	.ascii	"_IO_marker\000"
.LASF39:
	.ascii	"_shortbuf\000"
.LASF15:
	.ascii	"__off64_t\000"
.LASF24:
	.ascii	"_IO_write_base\000"
.LASF48:
	.ascii	"_unused2\000"
.LASF21:
	.ascii	"_IO_read_ptr\000"
.LASF61:
	.ascii	"__builtin_neon_qi\000"
.LASF28:
	.ascii	"_IO_buf_end\000"
.LASF77:
	.ascii	"vld4q_u8\000"
.LASF2:
	.ascii	"char\000"
.LASF108:
	.ascii	"main\000"
.LASF67:
	.ascii	"__builtin_neon_poly8\000"
.LASF79:
	.ascii	"fgImage\000"
.LASF51:
	.ascii	"_next\000"
.LASF42:
	.ascii	"__pad1\000"
.LASF43:
	.ascii	"__pad2\000"
.LASF44:
	.ascii	"__pad3\000"
.LASF59:
	.ascii	"tz_minuteswest\000"
.LASF46:
	.ascii	"__pad5\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF104:
	.ascii	"main.c\000"
.LASF102:
	.ascii	"fwrite\000"
.LASF6:
	.ascii	"long unsigned int\000"
.LASF26:
	.ascii	"_IO_write_end\000"
.LASF17:
	.ascii	"__time_t\000"
.LASF34:
	.ascii	"_fileno\000"
.LASF33:
	.ascii	"_chain\000"
.LASF55:
	.ascii	"timeval\000"
.LASF13:
	.ascii	"__off_t\000"
.LASF73:
	.ascii	"int8x16_t\000"
.LASF57:
	.ascii	"tv_usec\000"
.LASF75:
	.ascii	"uint8x16x4_t\000"
.LASF30:
	.ascii	"_IO_backup_base\000"
.LASF92:
	.ascii	"stdin\000"
.LASF27:
	.ascii	"_IO_buf_base\000"
.LASF88:
	.ascii	"outFile\000"
.LASF105:
	.ascii	"/root/GIT/ECE_785/Project_2_b\000"
.LASF68:
	.ascii	"__builtin_neon_poly16\000"
.LASF47:
	.ascii	"_mode\000"
.LASF23:
	.ascii	"_IO_read_base\000"
.LASF103:
	.ascii	"GNU C 4.9.2 -march=armv7-a -mfpu=neon -mcpu=cortex-"
	.ascii	"a8 -mtune=cortex-a8 -mfloat-abi=hard -mthumb -mtls-"
	.ascii	"dialect=gnu -ggdb -O3 -ffast-math -fsingle-precisio"
	.ascii	"n-constant -fno-tree-loop-vectorize -fno-tree-vecto"
	.ascii	"rize -fno-unroll-loops\000"
.LASF38:
	.ascii	"_vtable_offset\000"
.LASF81:
	.ascii	"dstImage\000"
.LASF69:
	.ascii	"__builtin_neon_uqi\000"
.LASF29:
	.ascii	"_IO_save_base\000"
.LASF107:
	.ascii	"alphaBlend_c\000"
.LASF91:
	.ascii	"newTv\000"
.LASF18:
	.ascii	"__suseconds_t\000"
.LASF52:
	.ascii	"_sbuf\000"
.LASF100:
	.ascii	"fread\000"
.LASF95:
	.ascii	"backImage\000"
.LASF106:
	.ascii	"_IO_lock_t\000"
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
