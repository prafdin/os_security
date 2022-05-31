#include <string.h>
#include <iostream>

struct MyStruct
{
    int a;
    long b;
    float c;
    double d;
    char e[10];
    int* f;
    MyStruct* pNext;
};

class MyClass
{
public:
    int a;
    long b;
    float c;
    double d;
    char e[10];
    int* f;
    MyClass* pNext;

public:
    MyClass()
    {
        this->a = 1;
        this->b = 2;
        this->c = 3.0;
        this->d = 4.0;
        memset(this->e, '5', sizeof(this->e));
        this->f = 0;
        this->pNext = 0;
    }
};

int main()
{
    MyStruct strct;
    MyClass  cls;
    strct.a++;
    strct.d += 5.0;
    cls.a++;
    cls.d+= 5.0;
    return 0;
}
