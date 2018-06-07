%{
#include "matrix.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char const *msg);
void semanError(char const*msg, int cn);
struct m* toPairs(int r, int c);
%}
%union{
	char* ttype;
	int n;
	struct m* matype; 	
	int oploc ;
}
%token <ttype> TRANS
%token <n> NUMBER
%token <oploc> MTPLY PLUS MINUS

%type <matype> expression
%left PLUS MINUS
%left MTPLY

%%
statement: expression {printf("Accepted\n");}
	|	   statement expression {printf("Accepted\n");}
	;

expression:	expression PLUS expression
			{	

				if($1->row == $3->row && $1->col == $3->col){
					$$ = toPairs($1->row,$1->col);
				}
				else{
					semanError("Semantic error on col ",$2);
				}
			}
			
	|		expression MINUS expression
			{
				if($1->row == $3->row && $1->col == $3->col){
					$$ = toPairs($1->row,$1->col);
				}
				else{
					semanError("Semantic error on col ",$2);			
				}
			}			
			
	|		expression MTPLY expression
			{
				
				if($1->col == $3->row){
					$$ = toPairs($1->row , $3->col);
				}
				else{
					semanError("Semantic error on col ",$2);
				}
			}
			
	|		'(' expression ')'
			{
				$$ = toPairs($2->row,$2->col);
			}
	|		'(' expression ')' TRANS
			{	
				
				$$ = toPairs($2->col,$2->row);
			}

	|		'[' NUMBER ',' NUMBER ']' 
			{
				
				$$ = toPairs($2,$4);
			}
	|		'[' NUMBER ',' NUMBER ']' TRANS
			{
				
				$$ = toPairs($4,$2);
			}
	;
			
%%
void yyerror (const char *message){
        
        printf ("%s \n",message);
        exit(0);

}
void semanError (const char *message, int cn){
		printf ("%s%d\n",message,cn);
        exit(0);
}
struct m* toPairs(int r, int c){
		struct m* temp = malloc (sizeof(struct m));
		temp -> row = r;
		temp -> col = c;
		return temp;
}

int main(int argc, char * argv[]){
	yyparse();
	return 0;
	
}