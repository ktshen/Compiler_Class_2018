%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>



%}
CPY cpy
OTHER [0-9_a-zA-z]
WORD {OTHER}*{CPY}{OTHER}*
%option noyywrap

%%
{WORD} {printf("%s\n",yytext);}
. 
%%


int main(){
	yylex();
	return 0;
}