//
//  ImageDetailViewController.h
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageDetailViewController : NSViewController

@property (nonatomic, strong) NSArray *contents;
@property NSInteger selectedItemIndex;

@end
