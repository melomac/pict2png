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
        
        
        NSPICTImageRep *pict = [NSPICTImageRep imageRepWithData:data];
        
        if (!pict)
        {
            fprintf(stderr, "PICT representation failed.\n");
            
            return EXIT_FAILURE;
        }
        
#ifdef DEBUG
        NSLog(@"%@", pict);
#endif
        
        float width = floor(pict.size.width * pict.size.width / 72.0 + 0.5);
        float height = floor(pict.size.height * pict.size.height / 72.0 + 0.5);
        
        NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(width, height)];
        
        [image addRepresentation:pict];
        
#ifdef DEBUG
        NSLog(@"%@", image);
#endif
        
        NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil
                                                                           pixelsWide:pict.pixelsWide
                                                                           pixelsHigh:pict.pixelsHigh
                                                                        bitsPerSample:8
                                                                      samplesPerPixel:4
                                                                             hasAlpha:YES
                                                                             isPlanar:NO
                                                                       colorSpaceName:NSCalibratedRGBColorSpace
                                                                         bitmapFormat:0
                                                                          bytesPerRow:(pict.pixelsWide * 4)
                                                                         bitsPerPixel:32];
        
        bitmap.size = NSMakeSize(width, height);
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:bitmap]];
        
        [image drawInRect:NSMakeRect(0, 0, width, height) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
        
        [NSGraphicsContext restoreGraphicsState];
        
#ifdef DEBUG
        NSLog(@"%@", bitmap);
#endif
        
        NSData *png = [bitmap representationUsingType:NSPNGFileType properties:@{}];
        
        if (png.length == 0)
        {
            fprintf(stderr, "PNG representation failed.\n");
            
            return EXIT_FAILURE;
        }
        
        
        if ([png writeToFile:@(argv[2]) atomically:NO] != YES)
        {
            fprintf(stderr, "Output failed.\n");
            
            return EXIT_FAILURE;
        }
    }
    
    return EXIT_SUCCESS;
}
