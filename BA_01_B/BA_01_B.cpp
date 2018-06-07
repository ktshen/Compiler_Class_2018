#include <iostream>
#include <vector>
#include <string>
#include <stack>
using namespace std;

void printErrorMessage(string msg){
	cout << "Error: " << msg <<endl;
}

void printIllegalformula(){
    cout << "Error: Illegal formula!" <<endl;
}

bool equaloperator(string op){
    if(op.size()==1 &&
       (op[0]=='+' ||
        op[0]=='-' ||
        op[0]=='*' ||
        op[0]=='/'))
        return true;
    return false;
}


bool evalformula(stack<string> &st){
	string op;
    string first;
    string second;
   
	if(st.size()>=3){
		op = st.top();
		st.pop();
	}
    else if(st.size()==2){
        printIllegalformula();
        return false;
    }
    else if(st.size()==1){
        op = st.top();
        // only one number left
        if(!equaloperator(op)){
        	int n = stoi(op);
            cout << n << endl;
            return false;
        }
        else{
            printIllegalformula();
            return false;
        }
    }
	else
		return false;

    // equal to operator
	if(equaloperator(op)){
        first = st.top();
        while(equaloperator(first)){
            if(evalformula(st)){
                first = st.top();
            }
            else
                return false;
        }
        st.pop();

        if(st.size()==0){
        	printIllegalformula();
        	return false;
        }
        second = st.top();
        while(equaloperator(second)){
            if(evalformula(st)){
                second = st.top();
            }
            else
                return false;
        }
        st.pop();

        //Calculate
        int res;
        int fn = stoi(first);
        int sn = stoi(second);
        if(op[0]=='+')
            res = fn + sn;
        else if(op[0]=='-')
            res = fn - sn;
        else if(op[0]=='*')
            res = fn * sn;
        else if(op[0]=='/'){
            if(sn==0){
                printErrorMessage("Divide by ZERO!");
                return false;
            }
            res = fn / sn;
        }
        st.push(to_string(res));
	}
    else{
        printIllegalformula();
        return false;
    }
    return true;
	
}

stack<string> stringtostack(string token_list){
	stack<string> st;
	string cur="";
	for(int i=token_list.size()-1; i>=0; i--){
		if(token_list[i]==' '){
			if(cur.size()>0){
				st.push(cur);
				cur = "";
			}
		}
		else{
			cur = token_list[i] + cur;
		}
	}
	if(cur.size()>0)
		st.push(cur);
	return st;
}


bool readformula(string input, string &token_list){
	string cur = "";
	for(int i =0; i < input.size(); i++){
		if(input[i]=='/' ||
		    input[i]=='*'){
		   	if(cur.size()>0){
		   		token_list += cur + ' ';
		   		cur = "";
		   	}
			token_list = token_list + input[i] + ' ';
		}
		else if(input[i]=='+' || input[i]=='-'){
			if(cur.size()>=1){
				token_list = token_list + cur + ' ';
			}
			cur = input[i];

		}
		else if (int(input[i]) >= 48 && int(input[i]) <= 57){
			cur += input[i];
		}
		else if (input[i]==' '){
			if(cur.size()>0){
				token_list += cur + ' ';
			}
			cur = "";
		}
		else{
			if(cur.size()==1 && 
			   (cur[0]=='+' || cur[0]=='-'))
				cur = "";
			string error = cur + input[i];
			i++;
			for(; i<input.size(); i++){
				if(input[i]==' ')
					break;
				error += input[i];
			}
			error = "Unknown token " + error;
			printErrorMessage(error);
			return false;
		}
		if(i==input.size()-1){
			token_list += cur;
		}
	}
	if(token_list.size()>0){
		token_list += ' ';
	}
	return true;
}



int main(){
	cout <<"Welcome use our calculator!" << endl;
	string input;
	cout << "> " ;
	while(true){
		char c = 0;
		while(true){
			char ch;
			if(!cin.get(ch)){
				break;			
			}
			if(ch=='\n'){
				c = ch;
				break;
			}
			else{
				input += ch;
			}
		}
		if(input.size()>0){
			string token_list = "";
			bool correct = readformula(input, token_list);
			if(correct && token_list.size() > 0){
				stack<string> st ;
                st = stringtostack(token_list);
                while(evalformula(st));
			}
		}

		input = "";
 		if(c=='\n'){
			cout << "> " ;
		}
		else if (int(c)==0) {
			cout<< "ByeBye~"<< endl;
			break;
		}
	}
}