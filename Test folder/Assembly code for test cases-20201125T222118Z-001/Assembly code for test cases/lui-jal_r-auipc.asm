{\rtf1\ansi\ansicpg1252\cocoartf2576
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 addi x1,x0, 10 #x1=10\
addi x2,x0, 9  #x2=9\
lui x4,10000    #x4=40960000\
auipc x5,10000  #x5=409600012\
jal x3, L     #jump  and x3=20\
L:\
add x6,x2,x3  #x6=29\
addi x2,x6,1   #x2=30\
jalr x3,x1,34     #jump and x3=20}