#include <stdio.h>
#include <err.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>



int cmp(const void *a, const void *b);
int cmp(const void *a, const void *b)
{
	return *(const uint32_t *) a - *(const uint32_t *) b;
}


int main (const int argc,const char * argv[]) 
{
	if(argc != 2)
	{
		err(1, "Not enough args.");
	}
	
	int fd1 = open(argv[1], O_RDONLY);
	int fd2 = creat("result", S_IRUSR | S_IWUSR);
	if(fd1 <0)
	{
		err(2, "Error opening the file");
	}
	
	uint32_t cur;
	uint32_t buf[5000];
	ssize_t rdsz; 
	size_t size = 0;

	while((rdsz = read(fd1, &cur, sizeof(cur))) > 0)
	{
		buf[size++] = cur;
	}
	
	uint32_t size1 = (size/2), size2 = (size/2);	
	uint32_t halfBuf1[25];
	uint32_t halfBuf2[25];

	size_t index = 0;

	while(index < size)
	{
		halfBuf1[index] = buf[index];
		halfBuf2[index] = buf[((size/2) + index )];
		index++;
	}
	
	qsort(halfBuf1, (size/2),sizeof(uint32_t), cmp);
	qsort(halfBuf2, (size/2),sizeof(uint32_t), cmp);
	
	size_t index1 = 0, index2 = 0, curIndex = 0;

	uint32_t endBuff[50];

	while(index1 < (size/2) && index2 < (size/2))
	{
		if(halfBuf1[index1] >= halfBuf2[index2])
		{
			endBuff[curIndex++] = halfBuf2[index2++];
		}
		else
		{
			endBuff[curIndex++] = halfBuf1[index1++];
		}
	}

	if(index1 < (size/2))
	{
		while(index1 < (size/2))
		{
			endBuff[curIndex++] = halfBuf1[index1++];
		}
	}
	else if(index2 < (size/2))
	{
		while(index2 < (size/2))
		{
			endBuff[curIndex++] = halfBuf2[index2++];
		}
	}

	index = 0;
	while(index < size && write(fd2, &endBuff[index], sizeof(uint32_t)) == sizeof(uint32_t))
	{
		index++;
	}

	return 0;
}
