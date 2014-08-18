#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main(int argc, const char *argv[])
{
	if (argc != 3)
	{
		fprintf(stderr, "Usage: pict2png image.pict image.png\n");
		
		return EXIT_FAILURE;
	}
	
	@autoreleasepool
	{
		NSData *data = [NSData dataWithContentsOfFile:@(argv[1])];
		
		if (data.length == 0)
		{
			fprintf(stderr, "Input failed.\n");
			
			return EXIT_FAILURE;
		}
		
		
		NSPICTImageRep *pict = [[NSPICTImageRep alloc] initWithData:data];
		
		if (!pict)
		{
			fprintf(stderr, "PICT representation failed.\n");
			
			return EXIT_FAILURE;
		}
		
		
		NSImage *image = [[NSImage alloc] initWithSize:pict.size];
		
		[image addRepresentation:pict];
		
		
		NSData *tiff = [image TIFFRepresentation];
		
		if (tiff.length == 0)
		{
			fprintf(stderr, "TIFF representation failed.\n");
			
			return EXIT_FAILURE;
		}
		
		
		NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithData:tiff];
		
		NSData *png = [bitmap representationUsingType:NSPNGFileType properties:nil];
		
		if (png.length == 0)
		{
			fprintf(stderr, "PNG representation failed.\n");
			
			return EXIT_FAILURE;
		}
		
		
		if (![png writeToFile:@(argv[2]) atomically:NO])
		{
			fprintf(stderr, "Output failed.\n");
			
			return EXIT_FAILURE;
		}
	}
	
	return EXIT_SUCCESS;
}
