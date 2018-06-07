%{
#include <stdio.h>	
%}

INTEGER [0-9]{1,3}
%%
({INTEGER}"."){3}{INTEGER} {printf("%s\n",yytext);}
. 
%%

int main(){
	yylex();
	return 0;
}