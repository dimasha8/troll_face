//
//  ImageBrowseViewController.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFAbstractViewController.h"
#import "RNGridMenu.h"

@interface TFImageBrowseViewController : TFAbstractViewController <RNGridMenuDelegate, UIScrollViewDelegate> {
    IBOutlet UIView *mNavigationBar;
    IBOutlet UIScrollView *mContentView;
    IBOutlet UIView *mToolBar;
    IBOutlet UILabel *mCountLabel;
    
    //array of loaded images
    NSArray *mAssetsArray;
    
    //index(in mAssetsArray) of image which is displaing
    NSInteger mShowedImageIndex;
    
    //this variable contane count of image cells which are on mContent view
    NSInteger mShowedImagesCount;
    
    //pan gesture begin point
    CGPoint mBeginPanPoint;
}

//navigation bar actions
- (IBAction)backButtonPressed:(UIButton *)pSender;
- (IBAction)infoButtonPressed:(UIButton *)pSender;

//tool bar actions
- (IBAction)changeImagePressed:(UIButton *)pSender;

@end
