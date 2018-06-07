%{
#include <stdio.h>	
%}


INTEGER (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)
WORD [0-9a-zA-Z]+
WORD1 [0-9a-zA-Z]+[.]
%option noyywrap
%%
^({INTEGER}\.){3}{INTEGER}$ {printf("%s is an IP address",yytext);}
^[A-Z][a-zA-Z]*$ {printf("%s is a word",yytext);}
^{WORD}@{WORD1}+{WORD}$ {printf("%s is an email address",yytext);}
.  {}
%%

int main(){
	yylex();
	return 0;
}