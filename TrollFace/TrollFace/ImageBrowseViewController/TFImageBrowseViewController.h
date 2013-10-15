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

@interface TFImageBrowseViewController : TFAbstractViewController <RNGridMenuDelegate> {
    IBOutlet UIView *mNavigationBar;
    IBOutlet UIScrollView *mContentView;
    IBOutlet UIView *mToolBar;
    IBOutlet UILabel *mCountLabel;
    
    NSArray *mAssetsArray;
    
    NSInteger mShowedImageIndex;
}

//navigation bar actions
- (IBAction)backButtonPressed:(UIButton *)pSender;
- (IBAction)infoButtonPressed:(UIButton *)pSender;

//tool bar actions
- (IBAction)changeImagePressed:(UIButton *)pSender;

@end
