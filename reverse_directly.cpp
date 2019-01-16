#include <iostream>
#include <fstream>

using namespace std;
int main(int argc, char *argv[] )
{
    ifstream fh("F:/A_Parts.txt");
    if (!fh) cout << "can't open file" << endl;
    string s;
    while ( ! fh.eof() ) 
    {
        getline(fh, s);
        cout << s << endl;
    }
    return 0;
}
