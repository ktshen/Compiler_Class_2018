%{
#include "s.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int stack[1000];
int top = -1;
int isEmpty();
void push(int); 
int pop();
void check();

%}
%union{
	int num;
	char* op;
}

%token <num> NUMBER
%token <op> ADD SUB MUL MOD DEC INC LOAD

%type <op> expression


%%
statement: long_expression {check();}
;

long_expression: long_expression expression {}
| expression {}
;

expression: ADD {
				int i = pop();
				int j = pop();
				int s = i + j;
				push(s);
			}
|		SUB {
			int i = pop();
			int j = pop();
			int s = i - j;
			push(s);
		}
|		MUL {
			int i = pop();
			int j = pop();
			int s = i * j;
			push(s);
		}
|		INC {
			int i = pop();
			int s = i + 1;
			push(s);
		}
|		DEC {
			int i = pop();
			int s = i - 1;
			push(s);
		}
| 		MOD {
			int i = pop();
			int j = pop();
			int s = i % j;
			push(s);
		}
|		LOAD NUMBER {
			push($2);
		}
;

	
%%
int isEmpty(){
	if(top==-1){
		return 1; 
	}else{
		return 0;
	}
} 

void push(int data){
	top++;
	stack[top]=data;
} 

int pop(){
	int data;
	if(isEmpty()){
		printf("Invalid format\n");
		exit(0);
	}else{
		data=stack[top];
		top--;
		return data; 
	}
}

void check(){
	if(top==0){
		int i = pop();
		printf("%d\n", i);
	}
	else{
		printf("Invalid format\n");
	}
	exit(0);
}


void yyerror (const char *message){
        
        printf ("%s \n",message);
        exit(0);

}
int main(int argc, char * argv[]){
	yyparse();
	return 0;
	
}
