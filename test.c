#include <unistd.h>
#include <pthread.h>
#include <sys/inotify.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>

#define MERG(blue,green,red,transp)	\
	((bule)|(green)<<8|(red)<<16)
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
	struct fb_fix_screeninfo fbfix;
	struct fb_var_screeninfo fbvar;
	unsigned long screensize;
	void * fbmm;

	fb=open("/dev/fb0",O_RDWR);
	if(fb<0)
	{
		printf("open fb devices error!!!\n");
		exit(0);
	}
	
	ret=ioctl(fb,FBIOGET_FSCREENINFO,&fbfix);
	if(ret<0)
	{
		printf("get fb fix information error!\n");
		exit(0);
	}

	ret=ioctl(fb,FBIOGET_VSCREENINFO,&fbvar);
	if(ret<0)
	{
		printf("get fb var information error!\n");
		exit(0);
	}
/*	
	printf("id:\t%s\n\
		smem_len:\t%ul\n\
		line_length:\t%ul\n\n\
		",fbfix.id,fbfix.smem_len,fbfix.line_length);

	printf("bits_per_pixel:\t%d\n\
		grayscale:\t%d\n\
		height:\t%d\n\
		xres: %d yres: %d\n\
		width:\t%d\n\n",fbvar.bits_per_pixel,fbvar.grayscale,fbvar.height,fbvar.xres,fbvar.yres,fbvar.width);

	printf("red: %d %d %d\n",fbvar.red.offset,fbvar.red.length,fbvar.red.msb_right);
	printf("green: %d %d %d\n",fbvar.green.offset,fbvar.green.length,fbvar.green.msb_right);
	printf("blue: %d %d %d\n",fbvar.blue.offset,fbvar.blue.length,fbvar.blue.msb_right);
	printf("transp: %d %d %d\n",fbvar.transp.offset,fbvar.transp.length,fbvar.transp.msb_right);
*/
	screensize=fbvar.bits_per_pixel/8*fbvar.xres*fbvar.yres;
//	printf("screen size is %il\n",screensize);
	fbmm=mmap(NULL,screensize,PROT_READ|PROT_WRITE,MAP_SHARED,fb,0);
	if(MAP_FAILED==fbmm)
	{
		printf("mmap error!\n");
		exit(0);
	}
	
	for(long i=0;i<762;i++)
		for(long j=0;j<1366;j++)
		{
			drawpoint(fbmm,j,i,0xdb5951);
		}

	munmap(fbmm,screensize);
	close(fb);


	

}
