#ifndef MAIN_HPP
#define MAIN_HPP

#include <iostream>
#include <map>
#include <stdio.h>
#include <vector>
#include <string>
#include <cctype>

using namespace std;
struct chemical{
	string element_name;
	int subscript;
};
struct Type{
	char* str;
	map<string, int>* tbl;
};

extern "C"{
	void yyerror(const char *s);
}
void eraseFormula(string& formula, int pos);
string getElement(string& formula);
vector<chemical> getPoly(string& formula);
vector<chemical> parseGroup(string& formula);
map<string, int>* convertFormula( char* f, map<string,int>& table);
void printDiff(map<string,int>* ltable, map<string,int>* rtable);



#define YYSTYPE Type
#endif

