{\rtf1\ansi\ansicpg1252\cocoartf2576
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 TimesNewRomanPSMT;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10940\viewh8860\viewkind0
\deftab720
\pard\pardeftab720\li720\fi-720\ri-340\sl259\slmult1\sa160\partightenfactor0

\f0\fs24 \cf0 addi x1, x0, 10 #x1 = 10\
addi x2, x0, 10 #x2 = 10\
beq x1, x2, L1 #BEQ 8\
addi x3, x0, -10 #  12\
L1:\
addi x3, x0, -1 #16\
addi x2, x0, -10 #x2 = 0\
blt x2, x1, L2 #BLT 24\
nop 28\
addi x3, x0, -10 32\
L2:\
addi x3, x0, -2 36\
bgt x1, x2, L3 #BGT \
nop\
addi x3, x0, -10\
L3:\
addi x3, x0, -3\
bne x1, x2, L4 #BNE \
nop\
addi x3, x0, -10\
L4:\
addi x3, x0, -4 \
bge x1, x2, L5 \
nop\
addi x3, x0, -10\
L5:\
addi x3, x0, -5 \
addi x1, x0, -7\
addi x2, x0, -6\
bltu x2, x1, L6 \
nop\
addi x3, x0, -10\
L6:\
addi x3, x0, -6 \
bgeu x1, x2, L7\
nop\
L7:\
addi x3, x0, -7\
}