//
//  NSString+Image.m
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "NSString+Image.h"

@implementation NSString (Image)

- (BOOL)isImagePath
{
    BOOL result = NO;
    
    CFStringRef fileExtension = (__bridge CFStringRef) [self pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    
    if (UTTypeConformsTo(fileUTI, kUTTypeImage)) {
        result = YES;
    }
    
    return result;
}

@end
