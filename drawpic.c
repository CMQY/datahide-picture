#include <unistd.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>

#define MERG(blue,green,red,transp)	\
	((blue)|(green)<<8|(red)<<16)
#define DRAWPOINT(addr,color)	\
	(*((int *)(addr))=(color));
#define CALLOCATION(x,y)	\
	((x)*4+(y)*1376*4)

void drawpoint(void *fb_base,long x,long y,int color)
{
	DRAWPOINT(CALLOCATION(x,y)+(unsigned long)fb_base,color);
}

int main(int argc, char *argv[])
{
	int fb;
	int ret;
	struct fb_var_screeninfo fbvar;
	unsigned long screensize;
	void * fbmm;
	int fd;

	fb=open("/dev/fb0",O_RDWR);
	if(fb<0)
	{
		perror("open fb device error!\n");
		exit(0);
	}

	ret=ioctl(fb,FBIOGET_VSCREENINFO,&fbvar);
	if(ret<0)
	{
		printf("get fb var info error!\n");
		exit(0);
	}

	screensize=fbvar.bits_per_pixel/8*fbvar.xres*fbvar.yres;
	fbmm=mmap(NULL,screensize,PROT_READ|PROT_WRITE,MAP_SHARED,fb,0);
	if(MAP_FAILED==fbmm)
	{
		printf("pic file mmap error!\n");
		exit(0);
	}

	fd=open(argv[1],O_RDONLY);
	if(fb<0)
	{
		printf("open raw picture error!\n");
		exit(0);
	}

	unsigned int x,y,temp;
	void * fdmm;

	read(fd,&x,4);
	read(fd,&y,4);
	printf("%d %d\n",x,y);
	fdmm=mmap(NULL,x*y*3,PROT_READ,MAP_SHARED,fd,0);
	if(MAP_FAILED==fdmm)
	{
		perror("raw file mmap error!\n");
		exit(0);
	}
	
	for(int i=0;i<y;i++)
		for(int j=0;j<x;j++)
		{
			temp=MERG(*(char *)(fdmm+8+j*3+i*x*3+2),*(char *)(fdmm+8+j*3+i*x*3+1),*(char *)(fdmm+8+j*3+i*x*3),0);
			drawpoint(fbmm,j,i,temp);
		}
	
	munmap(fbmm,screensize);
	close(fb);
	munmap(fdmm,x*y*3);
	close(fd);
}

