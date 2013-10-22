//
//  ImageBrowseViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

//image cell
#define IMAGE_CELL_WIDTH 320.0
#define SPACE_BETWEEN_IMAGES 10.0

//animation
#define NAVIGATIONBAR_TIME_VISIBLE 3.0

#import "TFImageBrowseViewController.h"
#import "Settings.h"

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
    
    //set default values
    mShowedImageIndex = 1;
    mAllowExecuteScrollDelegate = YES;
    mContentView.contentSize = CGSizeZero;
    mContentView.contentOffset = CGPointZero;
    
    //hide tabbar
    [self.arcTabBar toggleTabBar:nil];
    
    //load images
    [mActivityIndicator startAnimating];
    [self performSelectorInBackground:@selector(getListOfPhotos) withObject:nil];
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
- (void)getListOfPhotos {
    [[Settings sharedSettings] getListOfPhotosInGroup:PHOTO_ALBUM complitionBlock:^(NSError *error, NSArray *imagesPath) {
        DLog(@"error: %@", error);
        if(error == nil) {
            mAssetsArray = [imagesPath copy];
            [self performSelectorOnMainThread:@selector(setImagesOnScrollView) withObject:nil waitUntilDone:NO];
        } else {
            DLog(@"images: %@", imagesPath);
            mInfoLabel.hidden = NO;
            [mActivityIndicator stopAnimating];
            mInfoLabel.text = NSLocalizedString(@"Error to get images", nil);
        }
    }];
}

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

- (void)showNextImage:(BOOL)pNext {
    if(mShowedImageIndex <= mAssetsArray.count && mShowedImageIndex >= 1) {
        
        //change content offset animated
        NSInteger lContentOffset = (IMAGE_CELL_WIDTH + 2 * SPACE_BETWEEN_IMAGES) * (pNext?1:-1);
        mAllowExecuteScrollDelegate = NO;
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            mContentView.contentOffset = CGPointMake(mContentView.contentOffset.x + lContentOffset,
                                                     mContentView.contentOffset.y);
        } completion:^(BOOL finished) {
            mAllowExecuteScrollDelegate = YES;
        }];
        
        mShowedImageIndex += pNext?1:-1;
        
        [self setCountLabelShowedIndex:mShowedImageIndex];
    }
}

- (void)setImagesOnScrollView {
    [mContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(mAssetsArray.count != 0) {
        mInfoLabel.hidden = YES;
        for(int i = 0; i < mAssetsArray.count; i++) {
            NSInteger lImageCellX = mContentView.contentSize.width + SPACE_BETWEEN_IMAGES;
            UIImageView *lCell = [[UIImageView alloc] initWithFrame:CGRectMake(lImageCellX,
                                                                               0,
                                                                               IMAGE_CELL_WIDTH,
                                                                               mContentView.frame.size.height)];
            [lCell setContentMode:UIViewContentModeScaleAspectFit];
            [lCell setBackgroundColor:[UIColor clearColor]];
            lCell.image = [mAssetsArray objectAtIndex:i];
            
            //change content size
            mContentView.contentSize = CGSizeMake(mContentView.contentSize.width + IMAGE_CELL_WIDTH + SPACE_BETWEEN_IMAGES * 2,
                                                  mContentView.frame.size.height);
            
            [mContentView addSubview:lCell];
        }
    } else {//there isn't any image in group "Troll friends"
        mShowedImageIndex = 0;
        mInfoLabel.hidden = NO;
        mInfoLabel.text = NSLocalizedString(@"You haven't any saved photos yet", nil);
    }
    
    [self setCountLabelShowedIndex:mShowedImageIndex];
    [mActivityIndicator stopAnimating];
}

- (void)setCountLabelShowedIndex:(NSInteger)pIndex {
    mCountLabel.text = [NSString stringWithFormat:@"%li %@ %lu", (long)pIndex, NSLocalizedString(@"of", Nil), (unsigned long)mAssetsArray.count];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(mAllowExecuteScrollDelegate) {
        CGFloat lPageWidth = (IMAGE_CELL_WIDTH + 2 * SPACE_BETWEEN_IMAGES);
        NSInteger lIndex = floorf((scrollView.contentOffset.x - lPageWidth / 2.0) / lPageWidth) + 1;
        mShowedImageIndex = lIndex + 1;
        [self setCountLabelShowedIndex:mShowedImageIndex];
    }
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
#pragma mark - navigation bar actions
- (IBAction)backButtonPressed:(UIButton *)pSender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)infoButtonPressed:(UIButton *)pSender {
    
}

#pragma - mark tool bar actions
- (void)changeImagePressed:(UIButton *)pSender {
    NSInteger lBorderIndex = pSender.tag == 0?1:mAssetsArray.count;
    if(mShowedImageIndex != lBorderIndex) {
        
        [self showNextImage:pSender.tag == 1];
    } else {
        TFAlertView *lAlert = [[TFAlertView alloc] initInfoViewWithInfo:pSender.tag?@"This is the first image":@"This is the last image" atLocation:TFLocationBottom rootView:self.view];
        [lAlert showAnimating:YES];
    }
}

- (void)showTabBar:(UIButton *)pSender {
    [self.arcTabBar toggleTabBar:nil];
}

@end
