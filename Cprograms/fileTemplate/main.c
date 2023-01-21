#include <stdio.h>
#include <err.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
int main (const int argc,const char * argv[]) 
{
    int fd1;
    fd1=creat("test", S_IRUSR | S_IWUSR);
    for(uint32_t i = 0; i < 25; i++)
    {
        uint32_t mirrored=50-i;
        write(fd1,&i,sizeof(i));
        write(fd1, &mirrored, sizeof(mirrored));
    }
    close(fd1);
    return 0;
}
