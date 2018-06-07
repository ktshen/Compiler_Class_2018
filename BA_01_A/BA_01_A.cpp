#include <iostream>
#include <string>
#include <vector>
using namespace std;

bool primary_tail(string, vector<string> &);
bool exp(string, vector<string> &);


int get_len(string str){
	return str.size();
}

int ID_1(char &a){
	if ((int(a) >= 97 && int(a) <= 122) ||
		(int(a) >= 65 && int(a) <= 90) ||
		a == '_'){
		return true;
	}
	return false;
}

int ID_2(char &a){
	if ((int(a) >= 97 && int(a) <= 122) ||
		(int(a) >= 65 && int(a) <= 90) ||
		(int(a) >= 48 && int(a) <= 57) ||
		a == '_'){
		return true;
	}
	return false;
}


bool primary_tail(string str, vector<string> &res){
	//cout <<"primary_tail " << str<<endl;
	if(str[0] == '.'){
		string dot = "DOT .";
		res.push_back(dot);
		if(!ID_1(str[1])){
			res.pop_back();
			return false;
		}
		int i;
		for (i = 2; i < str.size(); i++){
			if(!ID_2(str[i]))
				break;
		}
		string id = "ID " + str.substr(1, i);
		res.push_back(id);
		if (i==str.size()) return true;
		if(!primary_tail(str.substr(i, str.size()), res)){
			res.pop_back();
			return false;
		}
		return true;
	}
	if(str[0] == '('){
		string lbr = "LBR (";
		res.push_back(lbr);
		int i = str.find(')');
		if(i>=1){
			if(i==1 || exp(str.substr(1, i-1), res)){
				string rbr = "RBR )";
				res.push_back(rbr);
				if (i+1 == str.size()) return true;
				if(!primary_tail(str.substr(i+1, str.size()), res)){
					res.pop_back();
				}
				else{
					return true;
				}
			}
		}
		res.pop_back();
	}
	return false;
}

bool primary(string str, vector<string> &res){
	//cout <<"primary " << str<<endl;
	if(!ID_1(str[0])){
		return false;
	}
	int i;
	for (i = 1; i < str.size(); i++){
		if(!ID_2(str[i]))
			break;
	}
	string id = "ID " + str.substr(0, i);
	res.push_back(id);
	string next;
	if(i == str.size()){
		return true;
	}
	if(!primary_tail(str.substr(i, str.size()), res)){
		res.pop_back();
		return false;
	}
	return true;
}


bool exp(string str, vector<string> &res){
	//cout <<"exp " << str<<endl;
	if (str[0]=='"' &&
		str.back()=='"'){
		string s = "STRLIT " + str;
		res.push_back(s);
		return true;
	}
	else{
		return primary(str, res);
	}
}

bool stmt(string str, vector<string> &res){
	//cout <<"stmt " << str<<endl;
	int len = str.size();
	if (str[len-1] == ';' ) {
		if(len==1 || exp(str.substr(0, len-1), res)){
			string s = "SEMICOLON ;";
			res.push_back(s);
			return true;
		}
	}
	return false;
}


bool program (string str, vector<string> &res){
	return stmt(str, res);
}

int main(){
	string input;
	getline(cin, input);
	vector<string> results;
	
	if(program(input, results)){
		for(int i=0; i<results.size(); i++){
			cout<<results[i]<<endl;
		}
	}
	else{
		cout<< "invalid input" <<endl;
	}

}



