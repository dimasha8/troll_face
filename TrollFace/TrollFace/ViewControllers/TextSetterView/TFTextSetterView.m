//
//  TFTextSetterView.m
//  TrollFace
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFTextSetterView.h"

@implementation TFTextSetterView

@synthesize delegate = mDelegate;
//if (mDelegate && [mDelegate respondsToSelector:@selector(OPLoginWebViewDidLoginningDidCancel)]) {
//    [mDelegate performSelector:@selector(OPLoginWebViewDidLoginningDidCancel) withObject:nil];
//}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //ok button
        UIButton *lOkButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 80, 50)];
        [lOkButton setTitle:@"Ok" forState:UIControlStateNormal];
        [lOkButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lOkButton];
        
        //cancel button
        UIButton *lCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
        [lCancelButton setTitle:@"Ok" forState:UIControlStateNormal];
        [lCancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lCancelButton];
        
        //text field
        if (!mTextField) {
            mTextField = [[UITextField alloc] initWithFrame:CGRectMake(150, 150, 300, 80)];
        }
        [self addSubview:mTextField];
        
        
    }
    return self;
}

- (void)okButtonPressed{
    if (mDelegate && [mDelegate respondsToSelector:@selector(TFTextSetterViewOkButtonPressedWithInsertedText:)]) {
        [mDelegate performSelector:@selector(TFTextSetterViewOkButtonPressedWithInsertedText:) withObject:nil];
    }
}

- (void)cancelButtonPressed{
    if (mDelegate && [mDelegate respondsToSelector:@selector(TFTextSetterViewCancelButtonPressed)]) {
        [mDelegate performSelector:@selector(TFTextSetterViewCancelButtonPressed) withObject:mTextField.text];
    }
}
@end
