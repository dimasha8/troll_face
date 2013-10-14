//
//  TFGraphEditor.h
//  TrollFace
//
//  Created by Administrator on 10/9/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFAbstractViewController.h"
#import "TFGraphEditorScrollView.h"

@interface TFGraphEditorViewController : TFAbstractViewController<UIGestureRecognizerDelegate>{
    IBOutlet UIView *mTopView;
    IBOutlet UIView *mLeftView;
    IBOutlet UIView *mRightView;
    TFGraphEditorScrollView *mScrollView;
}

@end
