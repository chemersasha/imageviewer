//
//  ImageItemView.m
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ImageItemView.h"

@implementation ImageItemView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark -

-(void)mouseDown:(NSEvent *)event
{
    [super mouseDown:event];
    
    if (event.clickCount == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kImageItemViewDidDoubleClick object:self];
    }
}
@end

NSString *const kImageItemViewDidDoubleClick = @"ImageItemViewDidDoubleClickNotification";
