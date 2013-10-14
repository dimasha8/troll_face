//
//  UIImageView+Asset.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/15/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@interface UIImageView (Asset)

//init with ALAsset
- (id)initWithFrame:(CGRect)frame asset:(ALAsset *)pAsset;

//set image from ALAsset
- (void)setAsset:(ALAsset *)pAsse;

@end
