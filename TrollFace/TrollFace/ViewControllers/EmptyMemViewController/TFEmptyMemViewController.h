//
//  TFEmptyMemViewController.h
//  TrollFace
//
//  Created by Administrator on 10/16/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFAbstractViewController.h"

@interface TFEmptyMemViewController : TFAbstractViewController<UIScrollViewDelegate>{
    IBOutlet UIScrollView *mScrollView;
    IBOutlet UIImageView *mContainerView;
}

@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *containerView;
@end
