#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/mman.h>

void storebyte(char * base,char *str,int idx,int line_len)
{
	char temp=str[idx];
	char and=1;
	for(int i=0;i<8;i++)
	{
		int b=(*(base+line_len+i)-*(base+i))%3;
		if((temp&and)>0)
		{
			if(b==0)
			{
				*(base+line_len+i)+=1;
				printf("why not here?\n");
			}
			else if(b==1)
			{
				;
			}
			else
			{
				*(base+line_len+i)-=1;
			}
		}
		else
		{
			if(b==0)
			{
				printf("why here?\n");
			}
			else if(b==1)
			{
				*(base+line_len+i)-=1;
			}
			else
			{
				*(base+line_len+i)+=1;
			}
		}
		temp=temp>>1;
	}
}		

int main(int argc, char *argv[])
{
	int fd,ret,od,x,y;
	char * fdmm;

	fd=open(argv[1],O_RDWR);
	if(fd<0)
	{
		perror("open raw pic error!\n");
		exit(0);
	}
	
	read(fd,&x,4);
	read(fd,&y,4);

	fdmm=mmap(NULL,x*y*3+8,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	if(MAP_FAILED==fdmm)
	{
		perror("mmap");
		close(fd);
		exit(0);
	}

	unsigned long base=(unsigned long) (fdmm+8);
	int line=0;
	int len=strlen(argv[2]);
	for(int i=0;i<len;i++)
	{
		if((base-(unsigned long)fdmm)/(x*3)>line)
		{
			base+=x*3;
			line+=2;
		}
		if((base-(unsigned long)fdmm)>(x*y*3-1-3*x))
			break;
		storebyte((char *)base,argv[2],i,x*3);
		base+=8;
	}
	

	munmap(fdmm,x*y*3+8);
	close(fd);
}
