//
//  ImageDetailViewController.m
//  ImageViewer
//
//  Created by Chemersky on 2/21/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "ImageDetailViewController.h"
#import "ImageDetailView.h"
#import "ImageAssistant.h"


@interface ImageDetailViewController () <ImageDetailViewDelegate>
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateImageView];
    [[NSApp mainWindow] makeFirstResponder:self.view];
}

- (void)updateImageView
{
    self.imageView.image = self.contents[self.selectedItemIndex];
}

#pragma mark -

- (void)next
{
    self.selectedItemIndex = (self.selectedItemIndex >= (self.contents.count-1)) ? 0 : (self.selectedItemIndex+1);
    [self updateImageView];
}

- (void)previous
{
    self.selectedItemIndex = (self.selectedItemIndex <= 0) ? (self.contents.count-1) : (self.selectedItemIndex-1);
    [self updateImageView];
}

- (void)close
{
    [self.presentingViewController dismissViewController:self];
}

#pragma mark - IBActions

- (IBAction)dissmis:(id)sender
{
    [self close];
}

- (IBAction)next:(id)sender
{
    [self next];
}

- (IBAction)previous:(id)sender
{
    [self previous];
}

- (IBAction)blur:(id)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIImage *inputImage = [ImageAssistant createCIImageFromNSImage:self.imageView.image];
        CIImage *outputImage = [ImageAssistant applyGaussianBlurWithRadius:3.0f toImage:inputImage];
        NSImage *image = [ImageAssistant createNSImageFromCIImage:outputImage];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

#pragma mark - ImageDetailViewDelegate

- (void)didClickUpArrow
{
    [self next];
}

- (void)didClickDownArrow
{
    [self previous];
}

- (void)didClickESC
{
    [self close];
}

@end
