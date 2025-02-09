---
output:
  word_document: default
  html_document: default
  pdf_document: default
---
{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;\f1\froman\fcharset0 Times-Bold;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa240\partightenfactor0

\f0\fs24 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 A 
\f1\b matrix
\f0\b0  is a rectangular table of values divided into rows and columns. An 
\f1\b m\'d7n matrix
\f0\b0  has 
\f1\b m
\f0\b0  rows and 
\f1\b n
\f0\b0  columns. For a given matrix 
\f1\b A
\f0\b0 , we use 
\f1\b A(i,j)
\f0\b0  to represent the value at the intersection of row 
\f1\b i
\f0\b0  and column 
\f1\b j
\f0\b0 .\
Imagine we have a collection of DNA strings, all having the same length 
\f1\b n
\f0\b0 . Their 
\f1\b profile matrix
\f0\b0  is a 
\f1\b 4\'d7n matrix
\f0\b0  where:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls1\ilvl0
\f1\b \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 P(1,j)
\f0\b0  represents the number of times that 'A' occurs in the 
\f1\b j-th position
\f0\b0  of one of the strings.\
\ls1\ilvl0
\f1\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 P(2,j)
\f0\b0  represents the number of times that 'C' occurs in the 
\f1\b j-th position
\f0\b0 .\
\ls1\ilvl0
\f1\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 P(3,j)
\f0\b0  represents the number of times that 'G' occurs in the 
\f1\b j-th position
\f0\b0 .\
\ls1\ilvl0
\f1\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 P(4,j)
\f0\b0  represents the number of times that 'T' occurs in the 
\f1\b j-th position
\f0\b0 .\
\pard\pardeftab720\sa240\partightenfactor0
\cf0 A 
\f1\b consensus string
\f0\b0  is a string of length 
\f1\b n
\f0\b0  formed from the collection by taking the most common symbol at each position. The 
\f1\b j-th symbol
\f0\b0  of the consensus string corresponds to the symbol that appears most frequently in the 
\f1\b j-th column
\f0\b0  of the profile matrix.\
There can be multiple consensus strings if there are multiple symbols with the same maximum frequency in a column.\
\pard\pardeftab720\sa280\partightenfactor0

\f1\b\fs28 \cf0 Example:\
\pard\pardeftab720\sa240\partightenfactor0

\f0\b0\fs24 \cf0 Given the following DNA strings:\
}