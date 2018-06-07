%{	
#include "matrix.tab.h"
#include "matrix.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int charCount = 0;
%}
trans \^T
%option noyywrap
%%
[1-9] {
	charCount ++;
	yylval.n = atoi(yytext);
	return NUMBER;
}
{trans}		{
	charCount += yyleng;
	yylval.ttype = strdup(yytext); 
	return TRANS;
	}
\+  {
		charCount ++;
		yylval.oploc = charCount;
		return PLUS;
	}
-   {
		charCount ++;
		yylval.oploc = charCount;
		return MINUS;
	}
\*   {
		charCount ++;
		yylval.oploc = charCount;
		return MTPLY;
	}
[ \t]+ { charCount += yyleng; } 
\n  { return 0;}
.	{charCount++; return yytext[0];}

%%