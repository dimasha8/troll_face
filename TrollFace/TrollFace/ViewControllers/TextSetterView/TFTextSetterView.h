//
//  TFTextSetterView.h
//  TrollFace
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TFTextSetterViewDelegate<NSObject>
@optional
- (void)TFTextSetterViewOkButtonPressedWithInsertedText:(NSString*)pInsertedText;
- (void)TFTextSetterViewCancelButtonPressed;
@end
@interface TFTextSetterView : UIView{
    UITextField *mTextField;
    id<TFTextSetterViewDelegate> mDelegate;
}

@property(nonatomic,retain)id<TFTextSetterViewDelegate> delegate;

@end
