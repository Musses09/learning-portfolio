{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Bold;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Problem Statement\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 Given two strings 
\f0\b s
\f1\b0  and 
\f0\b t
\f1\b0 , 
\f0\b t
\f1\b0  is a substring of 
\f0\b s
\f1\b0  if 
\f0\b t
\f1\b0  is contained as a contiguous collection of symbols in 
\f0\b s
\f1\b0 . This means 
\f0\b t
\f1\b0 must be no longer than 
\f0\b s
\f1\b0 .\
The position of a symbol in a string is the total number of symbols found to its left, including itself. For example, the positions of all occurrences of 'U' in the string "AUGCUUCAGAAAGGUCUUACG" are 2, 5, 6, 15, 17, and 18. The symbol at position 
\f0\b i
\f1\b0  of 
\f0\b s
\f1\b0  is denoted by 
\f0\b s[i]
\f1\b0 .\
A 
\f0\b substring
\f1\b0  of 
\f0\b s
\f1\b0  can be represented as 
\f0\b s[j:k]
\f1\b0 , where 
\f0\b j
\f1\b0  and 
\f0\b k
\f1\b0  represent the starting and ending positions of the substring in 
\f0\b s
\f1\b0 . For example, if 
\f0\b s = "AUGCUUCAGAAAGGUCUUACG"
\f1\b0 , then 
\f0\b s[2:5] = "UGCU"
\f1\b0 .\
The location of a substring 
\f0\b s[j:k]
\f1\b0  is its beginning position 
\f0\b j
\f1\b0 . Note that 
\f0\b t
\f1\b0  will have multiple locations in 
\f0\b s
\f1\b0  if it occurs more than once as a substring of 
\f0\b s
\f1\b0 .\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Given:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls1\ilvl0
\f1\b0\fs24 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Two DNA strings 
\f0\b s
\f1\b0  and 
\f0\b t
\f1\b0 , each of length at most 1000 base pairs.\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Output:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls2\ilvl0
\f1\b0\fs24 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Return all locations of 
\f0\b t
\f1\b0  as a substring of 
\f0\b s
\f1\b0 . These locations should be listed in order.\
}