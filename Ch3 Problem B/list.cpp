#include <regex>
#include <iostream>
#include <string.h>
using namespace std;

int main(){
	regex REG1 ("^noodles[\\s]+");  
	regex REG2 ("[\\s]+noodles$");
	regex REG3 ("[\\s]+noodles[\\s]+");
	regex REG4 ("noodles");
	string input;
	getline(cin, input);
	while(input.size()){
		if (regex_search(input, REG1) || 
		regex_search(input, REG2) ||
		regex_search(input, REG3) ||
		regex_search(input, REG4))
			cout<< input << endl;
		getline(cin, input);
	}
	
}