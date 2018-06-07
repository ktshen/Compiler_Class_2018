%{
#include "equation.h"
extern "C"{
	
	extern int yylex(void);
}
int rside = 0;
map<string,int> ltable;
map<string,int> rtable;
%}

%token <str> ARROW CMPD
%type <tbl> expr exprlist

%%
formula:	exprlist ARROW exprlist
			{
				printDiff($1,$3);
			}
	;
exprlist: 	expr { $$ = $1;}
	|		exprlist '+' expr
			{
				$$ = $1;
			}
	;
expr:		CMPD 
			{
				if(rside == 0){
					$$ = convertFormula($1,ltable);
				}
				else{
					$$ = convertFormula($1,rtable);
				}

				
			}		 
	; 
%%
void yyerror (const char *message){
        
        printf ("%s\n",message);
        exit(0);


}
void eraseFormula(string& formula, int pos){
	formula.erase(formula.begin()+pos);
}

string getElement(string& formula){
	string::iterator it = formula.begin();
	string temp ;

	temp += *it;
	formula.erase(formula.begin());

	if(islower(*it)){
		temp += *it;
		formula.erase(formula.begin());
	} 

	return temp;
}

vector<chemical> getPoly(string& formula){
	vector<chemical> polyVec;
	string::iterator it = formula.begin();
	if(*it == '('){
		eraseFormula(formula,0);
		polyVec =  getPoly(formula);	
	}
	else{
		while(*it != ')'){
			if(*it == '('){
				eraseFormula(formula,0);
				vector<chemical> tmp ;
				tmp =  getPoly(formula);
				
				for(int j = 0; j < tmp.size(); j++){
					
					
				
					polyVec.push_back(tmp[j]);
				}
			
			}
			else{
			chemical poly;
			poly.element_name = getElement(formula);
			if(isdigit(*it)){
		
				if(isdigit(*(it+1))){
					string n ;
					n += *it;
					eraseFormula(formula,0);
					n += *it;
					eraseFormula(formula,0);
					if(isdigit(*it)){
						n += *it;
						eraseFormula(formula,0);
					}
					poly.subscript= atoi(n.c_str());
							
				}
		
				else{
					poly.subscript = (int)(*it - '0');
					eraseFormula(formula,0);
				}
			}
			else poly.subscript = 1;	
		
			polyVec.push_back(poly);
			}

		}
	}

	if(*it == ')'){
		eraseFormula(formula,0);
	}

	if(isdigit(*it)){
		int coef;
		if(isdigit(*(it+1))){
			string n ;
			n += *it;
			eraseFormula(formula,0);
			n += *it;
			eraseFormula(formula,0);
			if(isdigit(*it)){
				n += *it;
				eraseFormula(formula,0);
			}
			coef= atoi(n.c_str());			
		}
		else{
			coef = (int)(*it - '0');
			eraseFormula(formula,0);
		}
	
		
		for(int j = 0; j < polyVec.size(); j++){
			polyVec[j].subscript *= coef;
		}
		
	}

	return polyVec;
}

vector<chemical> parseGroup(string& formula){
	
	string::iterator it = formula.begin();
	vector<chemical> gvector;
	chemical myGroup; 

	if(*it == '('){			
		eraseFormula(formula,0);
		return  getPoly(formula);		
	}
	else if(isalpha(*it)){
		myGroup.element_name = getElement(formula);		
	}
	
	if(isdigit(*it)){
		
			if(isdigit(*(it+1))){
				string n ;
				n += *it;
				eraseFormula(formula,0);
				n += *it;
				eraseFormula(formula,0);
				if(isdigit(*it)){
					n += *it;
					eraseFormula(formula,0);
				}
				myGroup.subscript= atoi(n.c_str());					
			}
	
			else{
				myGroup.subscript = (int)(*it - '0');
				eraseFormula(formula,0);
			}
	}
	else myGroup.subscript = 1;	

	gvector.push_back(myGroup);
	return gvector;
}

map<string, int>* convertFormula( char* f, map<string,int>& table){
	
	int coefficient;
	map <string, int> temp;

	string formula(f);
	string::iterator it = formula.begin();

	if(isdigit(*it)) {
		if(isdigit(*(it+1))){
			string n ;
			n += *it;
			eraseFormula(formula,0);
			n += *it;
			eraseFormula(formula,0);
			if(isdigit(*it)){
				n += *it;
				eraseFormula(formula,0);
			}
			coefficient= atoi(n.c_str());						

		}
		
		else{
			coefficient = (int)(*it - '0');
			eraseFormula(formula,0);
		}
	}
	else coefficient = 1;
	
	while(formula.size() != 0) {
		vector<chemical> group = parseGroup(formula);
		for(int j = 0; j < group.size(); j++){
			string name = group[j].element_name;
			int scrt = group[j].subscript;
			temp[name] += scrt;
		}
	}

	map<string,int>::iterator mt;	
	
	for(mt = temp.begin();mt!=temp.end();mt++){
		table[mt->first] +=( (mt->second)*coefficient);
		
	}
	return &table;
}


void printDiff(map<string,int>* ltable, map<string,int>* rtable){
	map<string, int>::iterator lit;
	map<string, int>::iterator rit;

	for(rit = (*rtable).begin();rit!= (*rtable).end();rit++){
		lit = (*ltable).find(rit->first);
		if(lit != (*ltable).end()){
			lit->second = lit->second - rit->second;
		}
		else{
			(*ltable)[rit->first] = -(rit->second);
		}
	}

	for(lit = (*ltable).begin(); lit != (*ltable).end(); lit++){
		if(lit->second != 0)
			cout << lit->first << " " << lit->second << endl;
	}
}
int main(int argc, char * argv[]){
	
	yyparse();
	return 0;
	
}
