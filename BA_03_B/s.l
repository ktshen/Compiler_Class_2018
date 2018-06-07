%{	
#include "s.tab.h"
#include "s.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

%}
%option noyywrap
%%
[1-9][0-9]? {
	yylval.num = atoi(yytext);
	return NUMBER;
}
load  {
		yylval.op = strdup(yytext);
		return LOAD;
	}
inc   {
		yylval.op = strdup(yytext);
		return INC;
	}
dec   {
		yylval.op = strdup(yytext);
		return DEC;
	}
add {
	yylval.op = strdup(yytext);
	return ADD;
}

sub {
	yylval.op = strdup(yytext);
	return SUB;
}

mod {
	yylval.op = strdup(yytext);
	return MOD;
}

mul {
	yylval.op = strdup(yytext);
	return MUL;
}


[ \t]+ {}

\n     {}

<<EOF>>  { return 0;}

.	{return yytext[0];}



%%
