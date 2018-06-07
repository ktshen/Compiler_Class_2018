%{	
#include "la.tab.h"
#include "la.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

%}
%option noyywrap
%%
[1-9]+ {
	yylval.ftype = atof(yytext);
	return NUMBER;
}
\+  {
		yylval.op = strdup(yytext);
		return PLUS;
	}
-   {
		yylval.op = strdup(yytext);
		return MINUS;
	}
\^ {
	yylval.op = strdup(yytext);
	return EXPO;
}

[ \t]+

\\frac {
	yylval.op = strdup(yytext);
	return FRAC; 
}

\n  {}

.	{return yytext[0];}

<<EOF>> {return 0;}

%%
