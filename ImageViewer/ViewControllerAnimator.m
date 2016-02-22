//
//  ImageDetailAnimator.m
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ViewControllerAnimator.h"

@implementation ViewControllerAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController
{
    NSView *fromView = fromViewController.view;
    NSView *view = viewController.view;
    
    fromView.wantsLayer = YES;
    view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    view.alphaValue = 0;
    
    for (NSView *subview in fromView.subviews) {
        [subview setHidden:YES];
    }
    
    [fromView addSubview:view];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [fromView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:fromView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0]
     ];
    [fromView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:fromView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:0]
     ];
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context)
                        {
                            context.duration = 0.5;
                            viewController.view.animator.alphaValue = 1;
                        }
                        completionHandler:nil
     ];
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController
{
    NSView *fromView = fromViewController.view;
    NSView *view = viewController.view;
    
    for (NSView *subview in fromView.subviews) {
        [subview setHidden:NO];
    }
    view.wantsLayer = YES;
    view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        viewController.view.animator.alphaValue = 0;
    } completionHandler:^{
        [viewController.view removeFromSuperview];
    }];
}

@end
