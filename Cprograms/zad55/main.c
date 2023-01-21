#include <stdio.h>
#include <err.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>

struct INTERVAL
{
	uint32_t begin;
	uint32_t end;
};


int main (const int argc,const char * argv[]) 
{
	if (argc != 3)
	{
		errx(1, "Not enough arguments");
	}

	int fd1 = open(argv[1], O_RDONLY);
	int fd2 = open(argv[2], O_RDONLY);
	int fd3 = creat("f3", S_IRUSR | S_IWUSR);
	
	if (fd1 == -1 || fd2 == -1 || fd3 == -1)
	{
		err(2, "A file failed to open");
	}
	

	ssize_t readsize1, readsize2;
	struct INTERVAL curInterval;
	uint32_t cur;

	while(readsize1 = read(fd1, &curInterval, sizeof(curInterval)) == sizeof(curInterval))
	{
		
		if(lseek(fd2, curInterval.begin, SEEK_SET) == -1)
		{
			err(3, "Error in lseek");
		}
		
		for(size_t i = 0; i < curInterval.end; i++){
			
			if(readsize2 = read(fd2, &cur, sizeof(cur)) != sizeof(cur))
			{
				err(4, "Error in second read");
			}
			
			if(write(fd3, &cur, sizeof(cur)) != sizeof(cur))
			{
				err(5, "Error in writing to the third file");
			}
		}


	}
	
	if(readsize1 == -1)
	{
		err(6, "Error in read from fd1");
	}
	if(readsize1 > 0)
	{
		err(7, "fd1 reading error");
	}
	return 0;
}
