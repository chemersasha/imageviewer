//
//  ImageAssistant.h
//  ImageViewer
//
//  Created by Chemersky on 2/22/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ImageAssistant : NSObject

+ (CIImage *)createCIImageFromNSImage:(NSImage *)image;
+ (NSImage *)createNSImageFromCIImage:(CIImage *)image;

+ (CIImage *)applyGaussianBlurWithRadius:(float)radius toImage:(CIImage *)inputImage;

@end
