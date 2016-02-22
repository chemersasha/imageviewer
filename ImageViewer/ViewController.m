//
//  ViewController.m
//  ImageViewer
//
//  Created by Chemersky on 2/20/16.
//  Copyright © 2016 Chemer. All rights reserved.
//

#import "ViewController.h"
#import "ImageItemView.h"
#import "ViewControllerAnimator.h"
#import "ImageDetailViewController.h"
#import "NSString+Image.h"

static NSString *const kImageCollectionViewItemID   = @"imageCollectionViewItemID";
static NSString *const kImageDetailViewControllerID = @"imageDetailViewControllerID";


@interface ViewController () <NSCollectionViewDelegate>
@property (weak) IBOutlet NSCollectionView *imageCollectionView;

@property (nonatomic, strong) NSMutableArray *contents;
@property NSInteger selectedItemIndex;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareImageCollectioinView];
}

- (void)viewWillAppear
{
    [self.imageCollectionView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    [self.imageCollectionView addObserver:self forKeyPath:@"selectionIndexes" options:NSKeyValueObservingOptionNew context:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDoubleClick) name:kImageItemViewDidDoubleClick object:nil];
}

- (void)viewWillDisappear
{
    [self.imageCollectionView unregisterDraggedTypes];
    [self.imageCollectionView removeObserver:self forKeyPath:@"selectionIndexes"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -

- (void)prepareImageCollectioinView
{
    self.contents = [[NSMutableArray alloc] initWithObjects:
                                 [NSImage imageNamed:@"image0"],
                                 [NSImage imageNamed:@"image1"],
                                 [NSImage imageNamed:@"image2"],
                                 [NSImage imageNamed:@"image3"],
                                 [NSImage imageNamed:@"image4"],
                                 nil
    ];
    
    [self.imageCollectionView setItemPrototype:[self.storyboard instantiateControllerWithIdentifier:kImageCollectionViewItemID]];
    [self.imageCollectionView setContent:self.contents];
}

#pragma mark - NSCollectionViewDelegate

- (BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id<NSDraggingInfo>)draggingInfo index:(NSInteger)index dropOperation:(NSCollectionViewDropOperation)dropOperation
{
    BOOL result = NO;
    NSPasteboard *pboard = [draggingInfo draggingPasteboard];

    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        result = YES;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *paths = [pboard propertyListForType:NSFilenamesPboardType];

            for (NSString *path in [paths reverseObjectEnumerator]) {
                if ([path isImagePath]) {
                    [self.contents insertObject:[[NSImage alloc] initWithContentsOfFile:path] atIndex:index];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self.imageCollectionView setContent:self.contents];
                    });
                }
            }
        });
    }
    
    return result;
}

-(NSDragOperation)collectionView:(NSCollectionView *)collectionView validateDrop:(id<NSDraggingInfo>)draggingInfo proposedIndex:(NSInteger *)proposedDropIndex dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation
{
    NSDragOperation result = NSDragOperationNone;
    
    NSPasteboard *pboard = [draggingInfo draggingPasteboard];
    if ([[pboard types] containsObject:NSFilenamesPboardType]) {
        NSArray *paths = [pboard propertyListForType:NSFilenamesPboardType];
        for (NSString *path in paths) {
            if ([path isImagePath]) {
                result = NSDragOperationCopy;
                break;
            }
        }
    }
    return result;
}

#pragma mark - ImageItem notification

- (void)didDoubleClick
{
    ImageDetailViewController *imageDetailViewController = [self.storyboard instantiateControllerWithIdentifier:kImageDetailViewControllerID];
    
    imageDetailViewController.contents          = self.contents;
    imageDetailViewController.selectedItemIndex = self.selectedItemIndex;
    
    [self presentViewController:imageDetailViewController animator:[ViewControllerAnimator new]];
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectionIndexes"]) {
        NSCollectionView *collectionView = object;
        self.selectedItemIndex = (collectionView.selectionIndexes.count) ? [collectionView.selectionIndexes firstIndex] : -1;
    }
}

@end
