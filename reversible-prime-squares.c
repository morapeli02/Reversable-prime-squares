/*
Author: Morapeli Alphonsus Makhosane
		202003231
		CS3520
		reversible prime squares
*/		






#include <stdio.h>
#include <stdbool.h>
#include<math.h>

//Since this C code acts as Psuedo code we use libraries as to speed up the time taken to write the code



//Functions
int reverse(int num)
{
	int r;
	int reverse=0;
	while(num!=0)
	{
		r=num%10;
		reverse= (reverse*10)+r;
		num=num/10;
	}
	return reverse;
}

bool primechecker(int num)
{
	int i;
	bool isPrime=true;
	
	if(num==0 || num==1 )
	{
		isPrime=false;
	}
	
	for(i=2;i<=(num)/2;i++)
	{
		if(num%i == 0)
		{
			isPrime=false;
			break;
		}
		
	}
	return isPrime;
}

bool not_palindrome(int num)
{
	bool isPaledrome=true;
	if(reverse(num)==num)
	{
		isPaledrome = false;
	}
	return isPaledrome;
}

bool isPerfect(int num)
{
	int i;
    for(i=1; i * i <= num; i++ )
    {
        if((num % i == 0) && (num / i == i))
        {
            return true;
        }
    }
    return false;
}

int main()
{
	int counter=0;
	int number_to_be_checked,root_of_number,reverse_of_number,root_of_reverse;
	printf( "\t\t\tHere are the first 10 reverseble primes \nRoot\t\t\t\tNumber\t\t\t\tReverse\n");
	for(number_to_be_checked=0;number_to_be_checked>=0;number_to_be_checked++)
	{
		
		int reverse_of_number = reverse(number_to_be_checked);

        if(isPerfect(number_to_be_checked) == true && isPerfect(reverse_of_number) == true)
        {
            root_of_number = sqrt(number_to_be_checked);
            root_of_reverse = sqrt(reverse_of_number);

            if(primechecker(root_of_number)&&primechecker(root_of_reverse))
            {
               if(not_palindrome(number_to_be_checked))
                {
                    printf("%d\t\t\t\t%d\t\t\t\t%d\n",root_of_number,number_to_be_checked,reverse_of_number);
                    counter++;
                    if(counter==10)
                    {
                    	break;
					}
                }

            }
        }
			
	}

	
	return 0;
}
