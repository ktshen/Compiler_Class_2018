#include <string>
#include <iostream>
#include <map>
#include <vector>

using namespace std;

int main(){

	string input;
	// string::iterator it;
	vector<string> result;
	map<string,int> exist;
	exist["id"] = 0;
	exist["assign"] = 0;
	exist["inum"] = 0;
	unsigned int i = 0;


	getline(cin,input);

	while(i <input.size()){
		if((int)input[i] == 32){
			i ++;
			continue;
		}

		// [a-z]
		else if((int)input[i] >= 97 && (int)input[i] <=122){

			if( !((exist["id"]++)^exist["assign"]) ){
				result.push_back(string("id ")+input[i]);
				i++;
			}

			else{
				cout << "valid input"<< endl;
				return 0;
			}
		}

		// equal sign
		else if((int)input[i] == 61){

			if( !(exist["assign"]++)){
				result.push_back(string("assign ")+input[i]);
				i++;
			}

			else{
				cout << "valid input" << endl;
				return 0 ;
			}		
		}
		else if((int)input[i] >= 48 && (int)input[i]<= 57){

			if(exist["assign"]+exist["id"] == 2){

				string temp ;

				while(i < input.size()){
					if( !(input[i] >= 48 && input[i] <= 57)){
						cout << "valid input" << endl;
						return 0;
					}
					temp += input[i];
					i++;
				}

				result.push_back(string("inum ") +temp);

			}
			else{
				cout << "valid input" << endl;
				return 0 ;
			}
		}
		else{
			cout << "valid input" <<endl;
			return 0;
		}

	}
	if(result.size() != 3){
		cout << "valid input" <<endl;
		return 0;
	}
	
	for(unsigned int i = 0 ; i < result.size();i++){
		cout << result[i] << endl;

	}
	return 0;
}

