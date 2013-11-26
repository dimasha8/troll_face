//
//  TFMainCanvasViewController.h
//  TrollFace
//
//  Created by Administrator on 10/19/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import "TFAbstractViewController.h"

@interface TFMainWorkFieldViewController : TFAbstractViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,RNGridMenuDelegate>{
    //backround scroll
    IBOutlet UIScrollView *mBackroundScrollView;
    //container img view
    IBOutlet UIImageView *mCanvasImageView;
    IBOutlet UIView *mZoomableView;
    //views with paint instruments
    IBOutlet UIView *mLeftView;
    IBOutlet UIView *mRightView;
    IBOutlet UIView *mTopView;
    IBOutlet UIView *mBottomMenuView;
}
#pragma mark - init methods
- (id)initEmptyWithNibName:(NSString *)nibNameOrNil;
- (id)initWithPattern:(UIImage*)pPattern WithNibName:(NSString *)nibNameOrNil;
- (id)initWithImage:(UIImage*)pImage WithNibName:(NSString*)nibNameOrNil;
- (IBAction)showButtonPressed:(id)sender;
@end
