%{
#include "la.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

%}
%union{
	float ftype;
	char* op;
}

%token <ftype> NUMBER
%token <op> PLUS MINUS EXPO FRAC

%type <ftype> expression

%left PLUS MINUS
%left FRAC EXPO

%%
statement: expression {printf("%.3f\n", $1);}
;

expression: expression PLUS expression
			{	
				
				$$ = $1 + $3;
			}
			
|		 expression MINUS expression
			{	
				
				$$ = $1 - $3;
			}				
|		 '{' expression '}'
			{
				$$ = $2;
			}	        

| 		 FRAC expression expression {
				$$ = $2 / $3;
			}
	| 	expression EXPO expression {
				$$ = pow($1, $3);
			}
	| 	NUMBER {
				$$ = $1;
			}
	;	
			
%%

void yyerror (const char *message){
        
        printf ("%s \n",message);
        exit(0);

}
int main(int argc, char * argv[]){
	yyparse();
	return 0;
	
}
