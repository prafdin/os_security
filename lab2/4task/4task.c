#include <iostream>
using namespace std;

int main()
{
    setlocale(0, "");
    int i = 0; 
    int sum = 0; 
    while (i < 1000)
    {
        i++;
        sum += i;
    }
    cout << "Сумма чисел от 1 до 1000 = " << sum << endl; 

    int j = 0; 
    int result = 0; 
    do {
        j++;
        result += j;
    } while (j < 1000); 
    cout << "Сумма чисел от 1 до 1000 = " << result << endl;

    return 0;
}
