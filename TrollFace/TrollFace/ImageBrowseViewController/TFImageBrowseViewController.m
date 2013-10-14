//
//  ImageBrowseViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#define NAVIGATIONBAR_TIME_VISIBLE 3.0

#import "TFImageBrowseViewController.h"
#import "UIImageView+Asset.h"

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
    
    UIPanGestureRecognizer *lPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [lPanGesture setMaximumNumberOfTouches:1];
    [lPanGesture setMinimumNumberOfTouches:1];
    [mContentView addGestureRecognizer:lPanGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    mShowedImageIndex = 0;
    
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
        UIImageView *lCell = [[UIImageView alloc] initWithFrame:mContentView.bounds asset:[mAssetsArray objectAtIndex:pIndex]];
        [mContentView addSubview:lCell];
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

- (void)panGesture:(UIPanGestureRecognizer *)pPan {
    switch (pPan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
            
        case UIGestureRecognizerStateChanged:
            
            break;
            
        default:
            break;
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
- (IBAction)nextImagePressed:(UIButton *)pSender {
    
}

- (IBAction)previousImagePressed:(UIButton *)pSender {
    
}

@end
