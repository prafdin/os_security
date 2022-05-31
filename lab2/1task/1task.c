double func(){char str[] = "This is a local string";
char* p = "This is NOT a local string, a pointer is local though";
int l0, l1, l2, l3, l4, l5 = 5;
short l6 = 1;return 4.0;
}

int main()
{
int local1,
 local2 = 55;
 long local3 = 0;
 float local4 = 0.0,
 local5 = 3.14;
 double local6 = 2.7,
 ret = 0.;ret = func();
 return 0;
}
