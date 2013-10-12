//
//  TFAlertView.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/12/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFAlertViewDelegare;
@interface TFAlertView : UIView {
    __weak id <TFAlertViewDelegare> mDelegate;
    
    UIView *mAlertView;
    UIView *mBackGroundView;
}

- (id)initWithTitle:(NSString *)pTitle message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

- (void)showAnimating:(BOOL)pAnimating;

@end

@class TFAlertView;
@protocol TFAlertViewDelegare <NSObject>

@optional
- (void)alertView:(NSInteger)pViewTag didSelectButtonAtIndex:(NSInteger)pButtonIndex;

@end