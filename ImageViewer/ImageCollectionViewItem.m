//
//  ImageCollectionViewItem.m
//  ImageViewer
//
//  Created by Chemersky on 2/20/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ImageCollectionViewItem.h"

@interface ImageCollectionViewItem ()

@end

@implementation ImageCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark -

-(void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    
    if (representedObject != nil) {
        self.imageView.image = representedObject;
        [self.imageView unregisterDraggedTypes];
    }
}

@end
