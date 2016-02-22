//
//  ImageDetailView.m
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ImageDetailView.h"

@implementation ImageDetailView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark -

- (BOOL)acceptsFirstResponder
{
    return YES;
}

-(void)keyDown:(NSEvent *)event
{
    if ([[self.delegate class] conformsToProtocol:@protocol(ImageDetailViewDelegate)]) {
        switch([event keyCode]) {
            case 53: // esc
                [self.delegate didClickESC];
                break;
            case 125:    // Down arrow
                [self.delegate didClickDownArrow];
                break;
            case 126:    // Up arrow
                [self.delegate didClickUpArrow];
                break;
            default:
                [super keyDown:event];
        }
    } else {
        [super keyDown:event];
    }
}


@end
