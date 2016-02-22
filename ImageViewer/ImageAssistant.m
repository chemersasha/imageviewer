//
//  ImageAssistant.m
//  ImageViewer
//
//  Created by Chemersky on 2/22/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ImageAssistant.h"
#import <CoreImage/CoreImage.h>


@implementation ImageAssistant

+ (CIImage *)createCIImageFromNSImage:(NSImage *)image
{
    NSData * tiffData = [image TIFFRepresentation];
    NSBitmapImageRep * bitmap = [NSBitmapImageRep imageRepWithData:tiffData];
    CIImage *result = [[CIImage alloc] initWithBitmapImageRep:bitmap];

    return result;
}

+ (NSImage *)createNSImageFromCIImage:(CIImage *)image
{
    NSCIImageRep *imageRep = [NSCIImageRep imageRepWithCIImage:image];
    NSImage *result = [[NSImage alloc] initWithSize:[imageRep size]];
    [result addRepresentation:imageRep];
    
    return result;
}

+ (CIImage *)applyGaussianBlurWithRadius:(float)radius toImage:(CIImage *)inputImage
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];

    return [filter valueForKey:kCIOutputImageKey];
}



@end
