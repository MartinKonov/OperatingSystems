#include<stdio.h>

int main (int argc, char *argv[])
{
	
	int f1;

	if(f1=open(argv[1], O_RDWR) == -1){
		err(1, "Can't open file");
	}
	int lenght = lseek(f1, 0, SEEK_END)+1;
	
	
	int i = 0;

	exit(1)
}
