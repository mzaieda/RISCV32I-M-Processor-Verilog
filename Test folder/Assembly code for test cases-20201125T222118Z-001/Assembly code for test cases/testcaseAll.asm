{\rtf1\ansi\ansicpg1252\cocoartf2576
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 addi x1, x0, 5 \
addi x2, x0, 4  \
auipc x4,100\
lui x5,100 \
jal x3, L1      \
addi x4, x0, 4   \
\
L1:\
add x6,x2,x3  \
addi x2,x6,1   \
jalr x3,x1,34    \
addi x6, x0, 10 \
\
L2:\
addi x4, x0, 10    \
addi x5, x0, 15\
addi x13, x5, 1   \
slti x1, x5, -15 \
beq x1, x0, L3   \
addi x4, x0, 20\
\
\
L3: \
sltiu x2, x5, -15\
xori x4, x6, 40   \
ori x4, x4, 40  \
andi x5, x4, 35   \
bne x5, x4, L4\
addi x4, x0, 30\
\
L4: \
slli x5, x5, 2   \
srli x6, x5, 10  \
add x7, x2, x6 \
sub x6, x7, x4   \
bltu x7, x6, L5\
addi x4, x0, 40  \
\
L5: \
addi x1, x0, 5\
sw x1, 0(x1)\
lw x4, 0(x1)\
addi x2, x0, 1024\
addi x5,x0, 24\
sb x2, 0(x5)\
lb x2, 0(x5)\
blt x6, x7, L6\
addi x4, x0, 50\
\
L6: \
addi x7, x0, 4  \
sll x8, x7, x7 \
slt x9, x7, x8  \
addi x7, x0, -10 \
bgeu x7, x9, L7\
addi x4, x0, 60 \
\
L7: \
sltu x10, x8, x7 \
slt x10, x8, x7 \
xor x11, x8, x6 \
addi x7, x0, 6\
bgt x7, x10, L8\
addi x4, x0, 70   \
\
L8: \
srl x11,  x11,  x7  \
or x11,  x7,  x11   \
and x11,  x11,  x7 \
addi x3,  x0, 1024\
addi x5,  x0,  24\
sh x3, 0(x5)\
lh x3, 0(x5)\
fence 1,1\
addi x6, x0, 1024\
addi x5, x0, 24\
sb x6, 0(x5)\
lbu x7, 0(x5)\
ebreak\
addi x13, x0, 10\
ecall \
addi x12, x0, 100\
addi x4, x0, 100\
\
}