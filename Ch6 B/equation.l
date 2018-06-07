%{
#include "equation.h"	
#include "equation.tab.h"
#include <string.h>

extern "C"{
	
	int yylex(void);
}

extern int rside;
%}

arrow ->
number [1-9][0-9]?[0-9]?
coef [1-9][0-9]?[0-9]?
elements [A-Z][a-z]?{number}?
ion \(?{elements}?\({elements}+\){number}?\)?{number}?
%option noyywrap
%%
{coef}?({elements}|{ion})+ {
		yylval.str = strdup(yytext);
		return CMPD;
}

{arrow}		{ 
		yylval.str = strdup(yytext);
		rside = 1;
		return ARROW;
}

[ \t]+ 
\n {return 0;}
\+	{ return yytext[0];}
. {	
	yyerror("Invalid format");
	 return 0;
}
%%
