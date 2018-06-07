%{
#include <stdio.h>	
%}


fraction \.[0-9]+

%option noyywrap
%%
^[+-]?[1-9]{fraction}?E[+-]?[0-9][0-9]*$ {printf("%s",yytext);}
.  {}
%%

int main(){
	yylex();
	return 0;
}