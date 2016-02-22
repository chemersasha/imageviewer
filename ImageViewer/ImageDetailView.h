//
//  ImageDetailView.h
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ImageDetailViewDelegate <NSObject>

@optional
- (void)didClickUpArrow;
- (void)didClickDownArrow;
- (void)didClickESC;

@end

@interface ImageDetailView : NSView

@property (weak) IBOutlet id<ImageDetailViewDelegate> delegate;

@end
