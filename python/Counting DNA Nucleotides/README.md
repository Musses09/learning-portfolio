{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Bold;\f1\froman\fcharset0 Times-Roman;\f2\fmodern\fcharset0 Courier;
}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc0\levelnfcn0\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{decimal\}}{\leveltext\leveltemplateid1\'01\'00;}{\levelnumbers\'01;}\fi-360\li720\lin720 }{\listname ;}\listid1}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa321\partightenfactor0

\f0\b\fs48 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 DNA String Symbol Count\
\pard\pardeftab720\sa298\partightenfactor0

\fs36 \cf0 Problem Statement\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 A 
\f0\b string
\f1\b0  is an ordered collection of symbols selected from some alphabet and formed into a word. The 
\f0\b length
\f1\b0  of a string is the number of symbols it contains.\
For this activity, we will work with a DNA string. A DNA string consists of symbols from the alphabet 
\f0\b \{'A', 'C', 'G', 'T'\}
\f1\b0 .\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Example\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 An example of a DNA string of length 21 is:\
\pard\pardeftab720\partightenfactor0

\f2\fs26 \cf0 ATGCTTCAGAAAGGTCTTACG\
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf0 Task\
\pard\pardeftab720\sa280\partightenfactor0

\fs28 \cf0 Given:\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 A DNA string 
\f0\b s
\f1\b0  of length at most 
\f0\b 1000
\f1\b0  nucleotides.\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Return:\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf0 Four integers, separated by spaces, representing the number of times the symbols 
\f0\b 'A'
\f1\b0 , 
\f0\b 'C'
\f1\b0 , 
\f0\b 'G'
\f1\b0 , and 
\f0\b 'T'
\f1\b0  occur in the string 
\f0\b s
\f1\b0 .\
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf0 Input & Output Example\
\pard\pardeftab720\sa280\partightenfactor0

\fs28 \cf0 Sample Input:\
\pard\pardeftab720\partightenfactor0

\f2\b0\fs26 \cf0 AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC\
\pard\pardeftab720\sa280\partightenfactor0

\f0\b\fs28 \cf0 Sample Output:\
\pard\pardeftab720\partightenfactor0

\f2\b0\fs26 \cf0 20 12 17 21\
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf0 Instructions\
\pard\tx220\tx720\pardeftab720\li720\fi-720\sa240\partightenfactor0
\ls1\ilvl0
\f1\b0\fs24 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	1	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Read a DNA string 
\f0\b s
\f1\b0  from input.\
\ls1\ilvl0\kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	2	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Count the occurrences of each nucleotide ('A', 'C', 'G', 'T').\
\ls1\ilvl0\kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	3	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Print four integers separated by spaces, corresponding to the counts of 
\f0\b A, C, G,
\f1\b0  and 
\f0\b T
\f1\b0 .\
\ls1\ilvl0\kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	4	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Ensure the input string does not exceed 
\f0\b 1000
\f1\b0  characters.\
\pard\pardeftab720\sa240\partightenfactor0
\cf0 \
Source:\'a0https://rosalind.info/problems/dna/\
}