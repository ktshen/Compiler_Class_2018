#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main(){

	string input;
	string line;
	
	vector <string> value;
	string types;
	int count = 0 ;
	size_t i = 0;

	while(getline(cin,line) && !line.empty()){
		input.append(line);
	}

	
	while(i < input.size()){

		if((int)input[i] == 32 || (int)input[i] == 10 || (int)input[i] == 13){
			i ++;
			continue;
		}
		else if((int)input[i] >= 97 && (int)input[i] <= 122){
			
			switch((int)input[i]){
				case 115:
					types += "s";
					value.push_back(string("strdcl ")+input[i]);
					break;

				case 112:
					types += "p";
					value.push_back(string("print ")+input[i]);
					break;
				default:
					types += "i";
					value.push_back(string("id ") + input[i]);
					break;
			}
			
			i++;
		}
		else if((int)input[i] == 34 && count == 0 ){
			
			string temp;
			
			while( i< input.size() && count< 2 ){	
				if((int)input[i] == 34){
					count ++;
					i++;
				}
				else if((int)input[i] >= 65 && (int)input[i] <= 90){
					temp += input[i];
					i++;
				}
				else if ((int)input[i] >= 97 && (int)input[i] <=122){
					temp += input[i];
					i++;
				}
				else if((int)input[i] >=48 && (int)input[i]<=57){
					temp += input[i];
					i++;
				}
				else{
					cout << "valid input" << endl;
					return 0;
				}
			
			}

			if(count== 2){
				types += "qnq";
				value.push_back(string("quote \""));				
				if(temp.size()){
					value.push_back(string("string ")+temp);
				}
				value.push_back(string("quote \""));
			}
			else{
				cout << "valid input" << endl;
				return 0;
			}
		}
		else{
			cout << "valid input "  << endl;
			return 0 ;
		}
	}

	if(types == "siqnqpi"){
		for(size_t i = 0 ; i < value.size();i++){
			cout << value[i] << endl;
		}
	}
	else{
		cout<< "valid input" << endl;			
	}


	return 0;
}