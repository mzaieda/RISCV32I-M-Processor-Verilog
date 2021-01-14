{\rtf1\ansi\ansicpg1252\cocoartf2576
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 addi x1, x0, 10\
addi x2, x0, 5\
ori x1, x1, 3    #x1 = 11\
andi x1, x1, 2  #x1= 2\
xori x2, x2, 3   #x2 = 6\
slti x1, x2, 4   #x1 = 4\
sltiu x1, x2, 10 #x1 = 1\
}