//
//  TFAlertView.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/12/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

typedef NS_ENUM (NSInteger, TFInfoViewLocation) {
    TFLocationCenter,
    TFLocationTop,
    TFLocationBottom,
    };

#import <UIKit/UIKit.h>

@protocol TFAlertViewDelegare;
@interface TFAlertView : UIView {
    __weak id <TFAlertViewDelegare> mDelegate;
    
    UIView *mAlertView;
    UIView *mBackGroundView;
    //view vhere will display alert
    UIView *mRootView;
    
    TFInfoViewLocation mInfoViewLocation;
    
    //this variable detect if alert view is info view
    BOOL mInfoView;
}

//init alert view
- (id)initWithTitle:(NSString *)pTitle message:(NSString *)message delegate:(id)delegate rootView:(UIView *)pRootView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

//init alert with single message(without title) and cancel button "OK"
- (id)initWithMessage:(NSString *)pMessage rootView:(UIView *)pRootView;

//show single info view
- (id)initInfoViewWithInfo:(NSString *)pInfo atLocation:(TFInfoViewLocation)pLocation rootView:(UIView *)pRootView;

//show alert
- (void)showAnimating:(BOOL)pAnimating;

@end

@class TFAlertView;
@protocol TFAlertViewDelegare <NSObject>

@optional
- (void)alertView:(NSInteger)pViewTag didSelectButtonAtIndex:(NSInteger)pButtonIndex;

@end