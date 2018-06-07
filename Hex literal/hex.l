
%option noyywrap
%%

^[ \n\t]*0[xX][0-9a-fA-F]{1,8}$ {
					int i,j;
					char* newline = yytext;
					for( i= 0,j= 0; i<strlen(yytext);i++,j++){
						if(yytext[i] != ' ')
							newline[j] = yytext[i];
						else
							j--;
					}
					newline[j] =0;
					printf("%s",newline);}
. 
%%
int main(){
	yylex();
	return 0;
}