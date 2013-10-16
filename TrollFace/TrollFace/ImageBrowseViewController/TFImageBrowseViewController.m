//
//  ImageBrowseViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

//image cell
#define IMAGE_CELL_WIDTH 320.0
#define SPACE_BETWEEN_IMAGES 20.0

//animation
#define NAVIGATIONBAR_TIME_VISIBLE 3.0

#import "TFImageBrowseViewController.h"

@interface TFImageBrowseViewController ()

@end

@implementation TFImageBrowseViewController

#pragma mark - Life cicle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add long press gesture recognizer
    RNLongPressGestureRecognizer *lRecognizer = [[RNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [mContentView addGestureRecognizer:lRecognizer];
    
    UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [mContentView addGestureRecognizer:lTapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    mShowedImageIndex = 0;
    mShowedImagesCount = -1;
    
    [[Settings sharedSettings] getListOfPhotosInGroup:PHOTO_ALBUM complitionBlock:^(NSError *error, NSArray *imagesPath) {
        DLog(@"error: %@", error);
        if(error == nil) {
            if(imagesPath != nil) {
                if(imagesPath.count != 0) {
                    mAssetsArray = [imagesPath copy];
                    [self showImageAtIndex:mShowedImageIndex];
                } else {//there isn't any image in group "Troll friends"
                    
                }
            } else {//group "Troll friends" didn't found
                
            }
        } else {
            DLog(@"images: %@", imagesPath);
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(showHideNavigationBar:) withObject:(id)NO afterDelay:NAVIGATIONBAR_TIME_VISIBLE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (void)showHideNavigationBar:(BOOL)pShow; {
    NSTimeInterval lAnimationDuration = pShow?0.1:ANIMATION_DURATION + 0.5;
    [UIView animateWithDuration:lAnimationDuration animations:^{
        mNavigationBar.alpha = pShow?1.0:0.0;
    } completion:^(BOOL finished) {
        
    }];
    
    if(pShow) {
        //hide navigations bar after NAVIGATIONBAR_TIME_VISIBLE
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showHideNavigationBar:) object:nil];
        [self performSelector:@selector(showHideNavigationBar:) withObject:(id)NO afterDelay:NAVIGATIONBAR_TIME_VISIBLE];
    }
    
}

- (void)showImageAtIndex:(NSInteger)pIndex {
    if(pIndex < mAssetsArray.count && pIndex >= 0) {
        
        static NSInteger lPreviousImageIndex = 0;
        BOOL lNextImage = pIndex > lPreviousImageIndex;
        
        if(pIndex > mShowedImagesCount) {
            mShowedImagesCount = MAX(mShowedImagesCount, pIndex);
            
            //show new image
            NSInteger lImageCellX = mContentView.contentSize.width + (mShowedImagesCount > 0?SPACE_BETWEEN_IMAGES:0.0);
            DLog(@"lImageCellX: %i", lImageCellX);
            UIImageView *lCell = [[UIImageView alloc] initWithFrame:CGRectMake(lImageCellX,
                                                                               0,
                                                                               IMAGE_CELL_WIDTH,
                                                                               mContentView.frame.size.height)];
            [lCell setContentMode:UIViewContentModeScaleAspectFit];
            [lCell setBackgroundColor:[UIColor clearColor]];
            lCell.image = [mAssetsArray objectAtIndex:pIndex];
            
            //change content size
            DLog(@"content size 1: %@", NSStringFromCGSize(mContentView.contentSize));
            mContentView.contentSize = CGSizeMake(mContentView.contentSize.width + IMAGE_CELL_WIDTH + (mShowedImagesCount > 0?SPACE_BETWEEN_IMAGES:0.0),
                                                  mContentView.frame.size.height);
            DLog(@"content size 2: %@", NSStringFromCGSize(mContentView.contentSize));
            
            [mContentView addSubview:lCell];
        }
        
        if(mShowedImagesCount != 0) {
            NSInteger lContentOffset = lNextImage?(IMAGE_CELL_WIDTH + SPACE_BETWEEN_IMAGES):-(IMAGE_CELL_WIDTH + SPACE_BETWEEN_IMAGES);
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                mContentView.contentOffset = CGPointMake(mContentView.contentOffset.x + lContentOffset,
                                                         mContentView.contentOffset.y);
            }];
        }
        DLog(@"contant offset: %@ --------------------", NSStringFromCGPoint(mContentView.contentOffset));
        
        //change count label
        mCountLabel.text = [NSString stringWithFormat:@"%i %@ %i", pIndex + 1, NSLocalizedString(@"of", nil), mAssetsArray.count];
        
        lPreviousImageIndex = pIndex;
    }
}

#pragma mark - GridMenu
- (void)showGridMenuAtPoint:(CGPoint)pPoint {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Attach"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithTitle:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithTitle:@"Download"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Source Code"],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *lGridMenu = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    lGridMenu.delegate = self;
    lGridMenu.menuStyle = RNGridMenuStyleGrid;
    
    lGridMenu.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, lGridMenu.itemSize.width*3, lGridMenu.itemSize.height*3)];
    
    [lGridMenu showInViewController:self center:pPoint];
}

#pragma mark - Delegates
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    DLog(@"scrollViewWillEndDragging");
    
    if(targetContentOffset->x != 0 || (targetContentOffset->x != (mContentView.contentSize.width - IMAGE_CELL_WIDTH))) {
        DLog(@"offset: %@", NSStringFromCGPoint(*targetContentOffset));
        
        CGFloat lScale = targetContentOffset->x / (IMAGE_CELL_WIDTH + SPACE_BETWEEN_IMAGES);
        
        if(lScale > 1.0) {
        }
    }
    mContentView.pagingEnabled = YES;
}

#pragma mark - GridMenu delegate
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    DLog(@"item index: %i", itemIndex);
}

#pragma mark - User actions
#pragma mark - gestureRecognizers
- (void)longPress:(UILongPressGestureRecognizer *)pGesture {
    if(pGesture.state == UIGestureRecognizerStateBegan) {
        [self showGridMenuAtPoint:[pGesture locationInView:self.view]];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)pTap {
    if(pTap.state == UIGestureRecognizerStateEnded) {
        [self showHideNavigationBar:YES];
    }
}

#pragma mark - buttons actions
//navigation bar actions
- (IBAction)backButtonPressed:(UIButton *)pSender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)infoButtonPressed:(UIButton *)pSender {
    
}

//tool bar actions
- (void)changeImagePressed:(UIButton *)pSender {
    NSInteger lBorderIndex = pSender.tag == 0?0:mAssetsArray.count - 1;
    if(mShowedImageIndex != lBorderIndex) {
        mShowedImageIndex = pSender.tag == 0?--mShowedImageIndex:++mShowedImageIndex;
        
        [self showImageAtIndex:mShowedImageIndex];
    } else {
        TFAlertView *lAlert = [[TFAlertView alloc] initInfoViewWithInfo:pSender.tag?@"This is the first image":@"This is the last image" atLocation:TFLocationBottom rootView:self.view];
        [lAlert showAnimating:YES];
    }
}

@end
