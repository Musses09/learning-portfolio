{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;\f1\froman\fcharset0 Times-Bold;\f2\fmodern\fcharset0 Courier;
}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa240\partightenfactor0

\f0\fs24 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Probability is the mathematical study of randomly occurring phenomena. We will model such a phenomenon with a 
\f1\b random variable
\f0\b0 , which is simply a variable that can take a number of distinct outcomes depending on the result of a random process.\
For example, say that we have a bag containing 3 red balls and 2 blue balls. If we let 
\f1\b X
\f0\b0  represent the random variable corresponding to the color of a drawn ball, then the probability of each outcome is:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls1\ilvl0\cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 The probability of drawing a red ball, Pr(X=red) = 3/5\
\ls1\ilvl0\kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 The probability of drawing a blue ball, Pr(X=blue) = 2/5\
\pard\pardeftab720\sa240\partightenfactor0
\cf0 Random variables can be combined to create new random variables. For instance, let 
\f1\b Y
\f0\b0  represent the color of a second ball drawn from the bag (without replacing the first ball). The probability of 
\f1\b Y
\f0\b0  being red depends on whether the first ball was red or blue.\
To represent all possible outcomes of 
\f1\b X
\f0\b0  and 
\f1\b Y
\f0\b0 , we use a 
\f1\b probability tree diagram
\f0\b0 . This diagram branches out to show all the possible outcomes, with probabilities at each branch. The probability of any outcome is the product of probabilities along the path from the beginning of the tree.\
An 
\f1\b event
\f0\b0  is simply a collection of outcomes. The probability of an event can be written as the sum of the probabilities of its constituent outcomes. For example, if we define an event 
\f1\b A
\f0\b0  as "Y is blue," we can calculate its probability by adding up the probabilities of two distinct outcomes.\
\pard\pardeftab720\sa280\partightenfactor0

\f1\b\fs28 \cf0 Given:\
\pard\pardeftab720\sa240\partightenfactor0

\f0\b0\fs24 \cf0 Three positive integers 
\f1\b k
\f0\b0 , 
\f1\b m
\f0\b0 , and 
\f1\b n
\f0\b0 , representing a population of organisms:\
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls2\ilvl0
\f1\b \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 k
\f0\b0  individuals are homozygous dominant for a factor.\
\ls2\ilvl0
\f1\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 m
\f0\b0  individuals are heterozygous.\
\ls2\ilvl0
\f1\b \kerning1\expnd0\expndtw0 \outl0\strokewidth0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 n
\f0\b0  individuals are homozygous recessive.\
\pard\pardeftab720\sa240\partightenfactor0
\cf0 The total population is 
\f1\b k + m + n
\f0\b0  individuals.\
\pard\pardeftab720\sa280\partightenfactor0

\f1\b\fs28 \cf0 Output:\
\pard\pardeftab720\sa240\partightenfactor0

\f0\b0\fs24 \cf0 Return the probability that two randomly selected mating organisms will produce an individual with a dominant allele (and thus display the dominant phenotype). Assume that any two organisms can mate.\
\pard\pardeftab720\sa280\partightenfactor0

\f1\b\fs28 \cf0 Example\
\pard\pardeftab720\sa240\partightenfactor0

\fs24 \cf0 Sample Input:
\f2\b0\fs26 \
\pard\pardeftab720\partightenfactor0
\cf0 2 2 2\
\
\pard\pardeftab720\sa240\partightenfactor0

\f1\b\fs24 \cf0 Sample Output:
\f2\b0\fs26 \
\pard\pardeftab720\partightenfactor0
\cf0 0.78333\
}