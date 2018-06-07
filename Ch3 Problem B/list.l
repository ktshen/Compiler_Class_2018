%{
#include <stdio.h>	
%}

SPACE [ ]+
NOODLE [nN]oodles
WORD [A-Za-z]+
%%
^{WORD}{SPACE}{WORD}{SPACE}{NOODLE}{SPACE}{WORD}$ {printf("%s",yytext);}
. 
%%

int main(){
	yylex();
	return 0;
}