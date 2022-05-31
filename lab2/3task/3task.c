#include<stdio.h>
int main()
{
int i= 0;
int v1 = 5, v2 = 5, v3_1 = 1, v3_2 = 2,  v4_1 = 2, v4_2 =1;
int v5 = 1;
if (v1 == 5)
{
printf("%s", "First if expression (v1 == 5) resolved to true");
}
if (v2 == 6)
{
 printf("%s", "Second if expression (v2 == 6) resolved to true");
}
else{
 printf("%s", "Second if expression (v2 == 6) resolved to   false");
}
if (v3_1 == 1 && v3_2 == 2)
{
printf("%s", "Third if expression (v3_1 == 1 && v3_2 == 2) resolved to true");
}
else
{
printf("%s", "Third if expression (v3_1 == 1 && v3_2 == 2) resolved to false");
}
if (v4_1 == 1)
{
printf("%s", "Fourth if expression (v4_1 == 1) resolved to true");
}
else if (v4_2 == 2){

printf("%s", "Fourth if expression (v4_2 == 2) resolved to true");
}
else{
 printf("%s", "Fourth if expressions resolved to false");
}
switch (v5)
{
 case 0:printf("%s", "switch-case expression for v5 == 0");
	break;
case 1:printf("%s", "switch-case expression for v5 == 1");
	break;
case 2:printf("%s", "switch-case expression for v5 == 2");
	break;}
for (i = 0; i < 100; i++){printf("i = %d\n", i);
}
return 0;
}
