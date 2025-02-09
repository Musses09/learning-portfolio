{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Bold;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}
{\list\listtemplateid3\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid201\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid3}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}{\listoverride\listid3\listoverridecount0\ls3}}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Problem Statement\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 A 
\f0\b sequence
\f1\b0  is a list of numbers where each number is called a term. For example, (1, 3, 5, 7) is a sequence of odd numbers. A 
\f0\b recurrence relation
\f1\b0  is a way to define each term in a sequence based on the previous ones.\
In this problem, we are looking at a sequence of rabbit pairs. If we start with one pair of rabbits, each month, the rabbits that are old enough produce a litter of 
\f0\b k
\f1\b0  new rabbit pairs. The new rabbits are also old enough to reproduce starting the next month.\
The number of rabbit pairs each month can be described by a 
\f0\b recurrence relation
\f1\b0 . This means that:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls1\ilvl0\cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 The number of rabbit pairs after the 
\f0\b n
\f1\b0 -th month depends on the number of rabbit pairs in the previous months.\
\ls1\ilvl0\kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 The recurrence relation is:\uc0\u8232 
\f0\b F\uc0\u8345  = F\u8345 \u8331 \u8321  + F\u8345 \u8331 \u8322 
\f1\b0 \uc0\u8232 where 
\f0\b F\uc0\u8345 
\f1\b0  is the number of rabbits in the 
\f0\b n
\f1\b0 -th month.\uc0\u8232 We start with 1 pair of rabbits at month 1 and month 2 (i.e., F\u8321  = F\u8322  = 1).\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Given:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls2\ilvl0
\fs24 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 n
\f1\b0 : The number of months, where 
\f0\b n
\f1\b0  \uc0\u8804  40.\
\ls2\ilvl0
\f0\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 k
\f1\b0 : The number of rabbit pairs each pair produces every month, where 
\f0\b k
\f1\b0  \uc0\u8804  5.\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Output:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls3\ilvl0
\f1\b0\fs24 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 You need to find out how many rabbit pairs there will be after 
\f0\b n
\f1\b0  months, starting with 1 pair, and with each pair producing 
\f0\b k
\f1\b0  new rabbit pairs every month.\
}